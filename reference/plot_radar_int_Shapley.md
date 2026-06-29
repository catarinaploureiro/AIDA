# Radar plot of Shapley values for interval-valued data.

Radar plot of Shapley values for interval-valued data.

## Usage

``` r
plot_radar_int_Shapley(shapley, palette = NULL, sort.obs = FALSE)
```

## Arguments

- shapley:

  A \\n \times p\\ matrix containing the Shapley values of \\n\\
  observations and \\p\\ variables.

- palette:

  A vector of palette for each observation. Default is black.

- sort.obs:

  Logical. If `TRUE` (default), observations are sorted according to
  their squared (robust) Interval-Mahalanobis distance.

## Value

Returns a radar plot that displays the Shapley values
([`int_Shapley`](https://catarinaploureiro.github.io/AIDA/reference/int_Shapley.md))
for each observation.

## Examples

``` r
# Create intData object
data(creditcard)
credit_card_int <- creditcard$intData

# Estimate the mean and covariance matrix
credit_card_IMCD <- IMCD(credit_card_int, 
                         m = floor(nrow(credit_card_int)*0.75), 
                         cutoff = "farness", 
                         cutoff_lvl = 0.9)

# Detect outliers using farness cutoff
credit_card_outliers <- int_outliers(credit_card_IMCD$robust_dist, 
                                     cutoff = "farness", 
                                     cutoff_lvl = 0.9)

# Compute Shapley values
credit_card_shapley <- int_Shapley(credit_card_int, 
                                   mean_c = credit_card_IMCD$mean_IMCD_c,
                                   mean_r = credit_card_IMCD$mean_IMCD_r, 
                                   cov = credit_card_IMCD$cov_IMCD)

# colors
outliers_colors <- rep('black',credit_card_int@NObs)
names(outliers_colors) <- rownames(credit_card_int)
outliers_colors[credit_card_outliers$outliers_names] = '#009de0'

plot_radar_int_Shapley(credit_card_shapley, palette = outliers_colors)
```
