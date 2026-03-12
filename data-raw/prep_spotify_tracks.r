###
#----Spotify Tracks----
# Data retrieved from Kaggle. 
# Available at \url{https://www.kaggle.com/datasets/maharshipandya/-spotify-tracks-dataset}.
# This script generates the dataset `spotify_tracks.rda`.
###

library(AIDA)
library(RKaggle)
library(dplyr)
library(widyr)

##### Download the Spotify dataset from Kaggle and load it
spotify <- get_dataset("maharshipandya/-spotify-tracks-dataset")
spotify <- as.data.frame(spotify)

spotify <- spotify[,c("track_genre","track_id","track_name",
                        "artists","album_name","explicit","mode","time_signature","key",
                        "duration_ms","popularity","danceability","energy",
                        "loudness","speechiness","acousticness",
                        "instrumentalness","liveness","valence","tempo")]
spotify <- spotify[!duplicated(spotify), ]
spotify <- spotify[!is.na(spotify$track_genre),]
spotify <- spotify[which(spotify$track_name!=""),]

# Homegenize genre names
spotify[which(spotify$track_genre=="latino"),"track_genre"] <- "latin"
spotify[which(spotify$track_genre=="songwriter"),"track_genre"] <- "singer-songwriter"
spotify[which(spotify$track_genre=="kids"),"track_genre"] <- "children"

#remove duplicates - keep most popular version of the song
spotify <- spotify %>%
  group_by(track_name, artists, track_genre) %>%        # columns to define duplicates
  slice_max(order_by = popularity, n = 1, with_ties = FALSE) %>%  # keep row with highest value
  ungroup()

##### Assign 1 genre to multi-genre tracks, using robust distances ----------------------------------------------------- #####
# Identify how many genres per track
genre_counts <- spotify %>%
  group_by(track_name, artists) %>%
  summarise(n_genres = n_distinct(track_genre), .groups = "drop")

# Merge back and split
spotify <- spotify %>%
  left_join(genre_counts, by = c("track_name", "artists"))

spotify_single <- spotify %>% filter(n_genres == 1)

numeric_features <- c("duration_ms","popularity","danceability","energy",
                        "loudness","speechiness","acousticness",
                        "instrumentalness","liveness","valence","tempo")

safe_mcd <- function(df) {
  # Drop columns that are entirely NA
  df <- df[, colSums(is.na(df)) < nrow(df)]
  
  res <- tryCatch(
    {
      mcd <- robustbase::covMcd(df)
      list(center = mcd$center, cov = mcd$cov, method = "MCD")
    },
    error = function(e) {
      list(
        center = apply(df, 2, median, na.rm = TRUE),
        cov = cov(df, use = "pairwise.complete.obs"),
        method = "median"
      )
    }
  )
  
  return(res)
}

# Compute MCD for each genre based on single-genre tracks
genre_models <- spotify_single %>%
  group_by(track_genre) %>%
  summarise(
    mcd = list(safe_mcd(across(all_of(numeric_features)))),
    .groups = "drop"
  ) %>%
  mutate(
    center = purrr::map(mcd, "center"),
    cov = purrr::map(mcd, "cov"),
    method = purrr::map_chr(mcd, "method")
  ) %>%
  select(-mcd)

assign_genre_restricted <- function(song_features, genre_models, candidate_genres) {
  sub_models <- genre_models %>% filter(track_genre %in% candidate_genres)
  
  dists <- purrr::map_dbl(1:nrow(sub_models), function(i) {
    tryCatch(
      mahalanobis(song_features,
                  sub_models$center[[i]],
                  sub_models$cov[[i]]),
      error = function(e) Inf
    )
  })
  
  sub_models$track_genre[which.min(dists)]
}

multi_tracks <- spotify %>%
  group_by(track_name, artists) %>%
  summarise(
    track_genre = paste(unique(track_genre), collapse = ", "),
    across(all_of(numeric_features), \(x) median(x, na.rm = TRUE)),
    .groups = "drop"
  )

# Use the genre models to assign a single genre to each multi-genre track
multi_tracks$reassigned_genre <- purrr::pmap_chr(
  multi_tracks[, c(numeric_features, "track_genre")],
  function(..., track_genre) {
    song_feats <- c(...)[numeric_features]
    genres <- strsplit(track_genre, ",\\s*")[[1]]
    assign_genre_restricted(song_feats, genre_models, genres)
  }
)

# Join back the reassigned genres to the original dataset and filter to keep only rows where the track_genre matches the reassigned genre
spotify <- spotify %>%
  left_join(
    multi_tracks %>% select(track_name, artists, reassigned_genre),
    by = c("track_name", "artists")
  ) %>%
  filter(track_genre == reassigned_genre) %>%
  select(-n_genres, -reassigned_genre)
##### ----------------------------------------------------------------------------------------- #####

#remove remaining duplicates
spotify <- spotify %>%
  group_by(artists,duration_ms,danceability,energy,loudness,speechiness,acousticness,instrumentalness,liveness,valence,tempo) %>%        # columns to define duplicates
  slice_max(order_by = popularity, n = 1, with_ties = FALSE) %>%  # keep row with highest value
  ungroup()

#Handle 0 values in tempo and duration_ms
spotify <- spotify %>%
  mutate(
    tempo = ifelse(tempo == 0, NA, tempo),
    duration_ms = ifelse(duration_ms == 0, NA, duration_ms)
  )

spotify <- as.data.frame(spotify)
spotify_clean <- spotify

##### ----- Data Transformation ------ #####
spotify[,"popularity"] <- spotify[,"popularity"]/100
spotify[,"loudness"] <- log10(spotify[,"loudness"]+60)
spotify[,"tempo"] <- log10(spotify[,"tempo"]+1)
spotify[,"duration_ms"] <- spotify[,"duration_ms"]/60000 #minutes
colnames(spotify)[which(colnames(spotify)=="duration_ms")] <- "duration"

##### Create intData object
# Since LatentCase="General", the latent variables' parameters are estimated from the microdata, using KDE
spotify_units <- factor(spotify$track_genre)
spotify_int_minmax <- micro2intData(spotify[,10:20],agrby=spotify_units, agrcrt = "minmax", LatentCase = "General")
spotify_int_trimmed <- micro2intData(spotify[,10:20],agrby=spotify_units, agrcrt = c(0.01, 0.99), LatentCase = "General")

spotify_tracks <- list(
    microdata = spotify_clean,
    microdata_transformed = spotify,
    intData_minmax = spotify_int_minmax,
    intData_trimmed = spotify_int_trimmed
)

##### Save the processed data
usethis::use_data(spotify_tracks, overwrite = TRUE)