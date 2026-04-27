# Spotify Tracks Dataset

This dataset contains interval data of Spotify tracks' audio features,
including min-max values and trimmed intervals, as well as the
microdata. It is composed of 11 audio features: duration, danceability,
energy, loudness, speechiness, acousticness, instrumentalness, liveness,
valence, tempo, and popularity. The aggregation of the microdata was
done by track genre.

## Usage

``` r
data(spotify_tracks)
```

## Format

A list with the following components:

- `microdata`:

  A data frame with `81033` rows and `20` columns. It contains the
  microdata, with individual measurements of each variable for all
  observations.

- `microdata_transformed`:

  A data frame with `81033` rows and `20` columns. It contains the
  transformed microdata, with individual measurements of each variable
  for all observations. Logarithmic transformations were applied to
  "loudness" and "tempo". "duration_ms" in milliseconds was converted to
  "duration" in minutes. "popularity" was scaled to the range `[0,1]`.

- `intData_minmax`:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object with `111` interval-valued observations and `11` variables,
  constructed using min-max aggregation based on the transformed
  microdata.

- `intData_trimmed`:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object with `111` interval-valued observations and `11` variables,
  constructed using trimmed aggregation (`1\%` trimming) based on the
  transformed microdata.

## References

This data was retrieved from Kaggle, available at
<https://www.kaggle.com/datasets/maharshipandya/-spotify-tracks-dataset>.

## Examples

``` r
data(spotify_tracks)
head(spotify_tracks$intData_minmax)
#>                      duration            popularity          danceability                energy              loudness           speechiness          acousticness      instrumentalness              liveness               valence                 tempo
#> acoustic      [1.0051000,  9.634400]  [   0    ,   0.82  ]  [ 0.2130 ,  0.879  ]  [0.01190 ,  0.974  ]  [1.513590, 1.763705]  [ 0.0232 ,  0.403  ]  [5.53e-06,  0.992  ]  [   0    ,  0.978  ]  [ 0.0369 ,  0.944  ]  [ 0.0419 ,  0.975  ]  [1.739137, 2.313785]  
#> afrobeat      [0.5304000, 13.809767]  [   0    ,   0.75  ]  [ 0.2850 ,  0.974  ]  [0.19800 ,  0.995  ]  [1.592032, 1.763143]  [ 0.0231 ,  0.924  ]  [7.89e-05,  0.977  ]  [   0    ,  0.979  ]  [ 0.0219 ,  0.992  ]  [ 0.0765 ,  0.995  ]  [1.759660, 2.344551]  
#> alt-rock      [1.5160000,  8.933333]  [   0    ,   0.86  ]  [ 0.1670 ,  0.922  ]  [0.20100 ,  0.972  ]  [1.622131, 1.764258]  [ 0.0230 ,  0.272  ]  [9.24e-06,  0.983  ]  [   0    ,  0.847  ]  [ 0.0144 ,  0.989  ]  [ 0.0398 ,  0.977  ]  [1.835494, 2.294312]  
#> alternative   [1.5003833,  5.682000]  [   0    ,   0.93  ]  [ 0.2020 ,  0.969  ]  [0.19000 ,  0.991  ]  [1.647442, 1.760905]  [ 0.0238 ,  0.396  ]  [1.21e-05,  0.954  ]  [   0    ,  0.509  ]  [ 0.0327 ,  0.816  ]  [ 0.0368 ,  0.964  ]  [1.774473, 2.311748]  
#> ambient       [0.6984000, 17.358667]  [   0    ,   0.79  ]  [ 0.0000 ,  0.794  ]  [0.00144 ,  0.974  ]  [1.259880, 1.744833]  [ 0.0000 ,  0.761  ]  [2.52e-05,  0.996  ]  [   0    ,  0.986  ]  [ 0.0345 ,  0.975  ]  [ 0.0000 ,  0.962  ]  [1.606048, 2.323978]  
#> anime         [0.8422167,  9.250117]  [   0    ,   0.83  ]  [ 0.0835 ,  0.898  ]  [0.02170 ,  0.994  ]  [1.443795, 1.783174]  [ 0.0227 ,  0.507  ]  [4.79e-06,  0.996  ]  [   0    ,  0.976  ]  [ 0.0233 ,  0.971  ]  [ 0.0309 ,  0.966  ]  [1.594183, 2.311741]  
head(spotify_tracks$intData_trimmed)
#>                      duration            popularity          danceability                energy              loudness           speechiness          acousticness      instrumentalness              liveness               valence                 tempo
#> acoustic      [1.4771000, 6.153333]  [  0.00  ,   0.71  ]  [ 0.2590 ,  0.795  ]  [0.05460 ,  0.934  ]  [1.609509, 1.755356]  [ 0.0248 ,  0.138  ]  [1.65e-04,  0.979  ]  [   0    ,  0.755  ]  [ 0.0506 ,  0.614  ]  [ 0.0771 ,  0.950  ]  [1.831262, 2.302775]  
#> afrobeat      [1.2420000, 9.602217]  [  0.09  ,   0.56  ]  [ 0.3530 ,  0.887  ]  [0.23300 ,  0.976  ]  [1.631687, 1.752325]  [ 0.0270 ,  0.394  ]  [3.80e-04,  0.930  ]  [   0    ,  0.936  ]  [ 0.0392 ,  0.930  ]  [ 0.1890 ,  0.969  ]  [1.881231, 2.281036]  
#> alt-rock      [2.4228833, 6.974033]  [  0.00  ,   0.79  ]  [ 0.2330 ,  0.791  ]  [0.23900 ,  0.957  ]  [1.661074, 1.758193]  [ 0.0247 ,  0.209  ]  [5.71e-05,  0.874  ]  [   0    ,  0.804  ]  [ 0.0395 ,  0.965  ]  [ 0.0668 ,  0.965  ]  [1.875605, 2.278662]  
#> alternative   [1.9311167, 5.067550]  [  0.00  ,   0.86  ]  [ 0.3220 ,  0.908  ]  [0.26100 ,  0.976  ]  [1.670487, 1.758919]  [ 0.0260 ,  0.333  ]  [4.44e-05,  0.845  ]  [   0    ,  0.248  ]  [ 0.0429 ,  0.676  ]  [ 0.0888 ,  0.943  ]  [1.840996, 2.273011]  
#> ambient       [0.8888833, 9.946217]  [  0.00  ,   0.73  ]  [ 0.0655 ,  0.719  ]  [0.00229 ,  0.866  ]  [1.335638, 1.739699]  [ 0.0252 ,  0.091  ]  [2.14e-03,  0.995  ]  [   0    ,  0.980  ]  [ 0.0598 ,  0.604  ]  [ 0.0293 ,  0.654  ]  [1.759766, 2.267390]  
#> anime         [1.1157667, 6.404000]  [  0.17  ,   0.72  ]  [ 0.1680 ,  0.853  ]  [0.04510 ,  0.981  ]  [1.504185, 1.770012]  [ 0.0262 ,  0.399  ]  [3.13e-05,  0.986  ]  [   0    ,  0.960  ]  [ 0.0467 ,  0.790  ]  [ 0.0380 ,  0.913  ]  [1.776076, 2.278648]  
head(spotify_tracks$microdata)
#>   track_genre               track_id                      track_name
#> 1       study 3v6ypsJzaoY2xgYp6mMJfM                        pagadoff
#> 2       study 1d4ZvL8uuUPTEAnocC3zEa                       strolling
#> 3    children 4aY2hh55axhL2qYYqXNoOM              Going on a Mission
#> 4    children 5qtlopq4SnnvVeiQVt3M0n Puppy Dog Pals Main Title Theme
#> 5      comedy 47s9GjMHMPSzPaEBUumq5g                    Spatula City
#> 6      comedy 4sCvka8sF2BOw6cViFanCW          Since You've Been Gone
#>                 artists                          album_name explicit mode
#> 1                !nvite                            pagadoff    False    0
#> 2                !nvite                           strolling    False    1
#> 3 "Puppy Dog Pals" Cast Puppy Dog Pals: Disney Junior Music    False    0
#> 4 "Puppy Dog Pals" Cast Puppy Dog Pals: Disney Junior Music    False    1
#> 5   "Weird Al" Yankovic            UHF: "Weird Al" Yankovic    False    0
#> 6   "Weird Al" Yankovic   The Essential "Weird Al" Yankovic    False    1
#>   time_signature key duration_ms popularity danceability energy loudness
#> 1              4  11      135860          5        0.784  0.657   -7.591
#> 2              4   2      138875         41        0.857  0.381  -12.755
#> 3              3   7       38144         55        0.629  0.776   -3.839
#> 4              4   3       57789         60        0.781  0.936   -4.709
#> 5              5   6       67840         23        0.638  0.449  -16.040
#> 6              3   9       83026         21        0.723  0.393   -8.303
#>   speechiness acousticness instrumentalness liveness valence   tempo
#> 1       0.348        0.332          0.00362    0.131   0.501  84.997
#> 2       0.192        0.666          0.01910    0.126   0.329  84.997
#> 3       0.047        0.021          0.00000    0.093   0.957  93.937
#> 4       0.202        0.171          0.00141    0.202   0.873 182.148
#> 5       0.556        0.796          0.00000    0.340   0.557 114.985
#> 6       0.102        0.542          0.00000    0.321   0.920 132.218
head(spotify_tracks$microdata_transformed)
#>   track_genre               track_id                      track_name
#> 1       study 3v6ypsJzaoY2xgYp6mMJfM                        pagadoff
#> 2       study 1d4ZvL8uuUPTEAnocC3zEa                       strolling
#> 3    children 4aY2hh55axhL2qYYqXNoOM              Going on a Mission
#> 4    children 5qtlopq4SnnvVeiQVt3M0n Puppy Dog Pals Main Title Theme
#> 5      comedy 47s9GjMHMPSzPaEBUumq5g                    Spatula City
#> 6      comedy 4sCvka8sF2BOw6cViFanCW          Since You've Been Gone
#>                 artists                          album_name explicit mode
#> 1                !nvite                            pagadoff    False    0
#> 2                !nvite                           strolling    False    1
#> 3 "Puppy Dog Pals" Cast Puppy Dog Pals: Disney Junior Music    False    0
#> 4 "Puppy Dog Pals" Cast Puppy Dog Pals: Disney Junior Music    False    1
#> 5   "Weird Al" Yankovic            UHF: "Weird Al" Yankovic    False    0
#> 6   "Weird Al" Yankovic   The Essential "Weird Al" Yankovic    False    1
#>   time_signature key  duration popularity danceability energy loudness
#> 1              4  11 2.2643333       0.05        0.784  0.657 1.719406
#> 2              4   2 2.3145833       0.41        0.857  0.381 1.674356
#> 3              3   7 0.6357333       0.55        0.629  0.776 1.749435
#> 4              4   3 0.9631500       0.60        0.781  0.936 1.742654
#> 5              5   6 1.1306667       0.23        0.638  0.449 1.643058
#> 6              3   9 1.3837667       0.21        0.723  0.393 1.713465
#>   speechiness acousticness instrumentalness liveness valence    tempo
#> 1       0.348        0.332          0.00362    0.131   0.501 1.934483
#> 2       0.192        0.666          0.01910    0.126   0.329 1.934483
#> 3       0.047        0.021          0.00000    0.093   0.957 1.977436
#> 4       0.202        0.171          0.00141    0.202   0.873 2.262802
#> 5       0.556        0.796          0.00000    0.340   0.557 2.064402
#> 6       0.102        0.542          0.00000    0.321   0.920 2.124563
```
