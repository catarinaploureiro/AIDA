# Tileplot of Shapley values for interval-valued data.

Tileplot of Shapley values for interval-valued data.

## Usage

``` r
plot_tile_int_Shapley(
  shapley,
  outliers = NULL,
  rotate_x = TRUE,
  abbrev.var = FALSE,
  abbrev.obs = FALSE,
  sort.var = FALSE,
  sort.obs = FALSE,
  show_values = FALSE
)
```

## Arguments

- shapley:

  A \\n \times p\\ matrix containing the Shapley values of \\n\\
  observations and \\p\\ variables.

- outliers:

  A list containing the outliers' names as returned by
  [`int_outliers`](https://catarinaploureiro.github.io/AIDA/reference/int_outliers.md).
  If `outliers` is not `NULL` (default), only the outliers are
  highlighted in the plot.

- rotate_x:

  Logical. If `TRUE` (default), the x-axis labels are rotated.

- abbrev.var:

  Integer. If `abbrev.var` \\\> 0\\, column names are abbreviated using
  abbreviate with `minlenght = abrev.var`.

- abbrev.obs:

  Integer. If `abbrev.obs` \\\> 0\\, row names are abbreviated using
  abbreviate with `minlenght = abrev.obs`.

- sort.var:

  Logical. If `TRUE`, variables are sorted according to the distance.

- sort.obs:

  Logical. If `TRUE`, observations are sorted according to their squared
  Interval-Mahalanobis distance.

- show_values:

  Logical. If `TRUE`, the Shapley values are displayed in each tile.

## Value

Returns a tileplot that displays the Shapley values
([`int_Shapley`](https://catarinaploureiro.github.io/AIDA/reference/int_Shapley.md))
for each observation and variable. Optionally, only the outliers are
highlighted in the plot.

## References

Adapted from package `ShapleyOutlier`
(<https://CRAN.R-project.org/package=ShapleyOutlier>).

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

plot_tile_int_Shapley(credit_card_shapley, 
                     outliers = credit_card_outliers, 
                     sort.var = TRUE, 
                     sort.obs = TRUE)
```
