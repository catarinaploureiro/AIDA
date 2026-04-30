# Outlier Detection for Interval-Valued Data Based on Robust Distances

Identifies potential outliers in interval-valued data using robust
distance-based methods with customizable cutoff criteria.

## Usage

``` r
int_outliers(
  robust_dist,
  cutoff = c("farness", "adjbox", "chi-squared", "F-dist"),
  cutoff_lvl = NULL,
  p = NULL,
  z = NULL
)
```

## Arguments

- robust_dist:

  A numeric vector containing the robust distances for each observation.

- cutoff:

  A character string specifying the method for setting the outlier
  cutoff threshold. Options include:

  - `"chi-squared"`: Outliers are identified based on a specified
    Chi-Squared quantile.

  - `"adjbox"`: Uses adjusted boxplot statistics (from `robustbase`) to
    classify outliers.

  - `"F-dist"`: Applies a cutoff derived from the F and Beta
    distributions for robust outlier detection.

  - `"farness"`: Identifies outliers based on a "farness" threshold,
    determined by the robust distance distribution.

  Default is `"farness"`.

- cutoff_lvl:

  A numeric value specifying the level of the cutoff to be used.

  - If `cutoff="chi-squared"`, `cutoff_lvl` is the quantile of the
    Chi-squared distribution (default is 0.975).

  - If `cutoff="adjbox"`, `cutoff_lvl` is the coefficient for the
    adjusted boxplot (default is 1.5).

  - If `cutoff="F-dist"`, `cutoff_lvl` is the significance level for
    identifying outliers (default is 0.95).

  - If `cutoff="farness"`, `cutoff_lvl` represents the threshold for
    farness, with a default of 0.99.

  If no value is provided, the function uses the default values
  associated with each cutoff method.

- p:

  The number of variables in the data. Required for `"chi-squared"` and
  `"F-dist"` cutoff methods.

- z:

  A binary vector indicating the subset of observations used for initial
  robust estimation. Required for the `"F-dist"` cutoff method.

## Value

A list with the following components:

- `outliers_names`:

  Character vector of names for observations classified as outliers.

- `is_outlier`:

  Logical vector indicating whether each observation is an outlier
  (TRUE) or not (FALSE).

- `cutoff`:

  The cutoff method used for detecting outliers.

- `cutoff_value`:

  Cutoff value used for detecting outliers.

- `farness_probs`:

  Numeric vector of farness probabilities for each observation (only if
  `cutoff` is set to `"farness"`).

## Details

This function classifies observations as outliers based on robust
distances and user-defined cutoff methods. It supports various
approaches, including Chi-Squared quantiles, adjusted boxplots, F
distribution quantiles, and farness probabilities.

## References

Loureiro, C. P., Oliveira, M. R., Brito, P., & Oliveira, L. (2026).
Minimum Covariance Determinant Estimator and Outlier Detection for
Interval-valued Data. arXiv preprint arXiv:2604.26769.
<https://arxiv.org/abs/2604.26769>

Case `cutoff=="F-dist"` is adapted from package
`CerioliOutlierDetection`
(<https://cran.r-project.org/package=CerioliOutlierDetection>).

## Examples

``` r
# Example of detecting outliers using robust distances
set.seed(42)
robust_dist <- abs(rnorm(100))
result <- int_outliers(robust_dist, cutoff="chi-squared", p=5)

# Example using creditcard dataset
data(creditcard)
credit_card_int <- creditcard$intData

credit_card_IMCD <- IMCD(credit_card_int, floor(0.75*credit_card_int@NObs), "farness", 0.9)
credit_card_outliers <- int_outliers(credit_card_IMCD$robust_dist, "farness", 0.9)
```
