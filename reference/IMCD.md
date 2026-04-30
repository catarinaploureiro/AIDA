# Interval-valued data Minimum Covariance Determinant (IMCD) estimation

Applies an adaptation of the FAST-MCD algorithm to estimate location and
scatter for interval-valued data.

## Usage

``` r
IMCD(
  data,
  m = 0,
  cutoff = c("farness", "adjbox", "chi-squared", "F-dist", "raw"),
  cutoff_lvl = NULL
)
```

## Arguments

- data:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the interval-valued dataset (macrodata).

- m:

  An integer specifying the subset size to use for the estimation.
  Defaults to `floor(0.75*n)`.

- cutoff:

  Indicates which cutoff should be considered for reweighting the
  estimates:

  - `"chi-squared"`: The traditional 97.5\\

  - `"raw"`: No reweighting.

  - `"adjbox"`: Adjusted Boxplots (package `robustbase`).

  - `"F-dist"`: The quantile of the scaled F distribution (adapted from
    package `CerioliOutlierDetection`).

  - `"farness"`: "Farness" is estimated from the robust distance
    (adapted from package `cellWise`).

  Defaults to `"farness"`.

- cutoff_lvl:

  A numeric value specifying the level of the cutoff to be used.

  - If `cutoff="chi-squared"`, `cutoff_lvl` is the quantile of the
    Chi-squared distribution (default is 0.975).

  - If `cutoff="adjbox"`, `cutoff_lvl` is the coefficient for the
    adjusted boxplot (default is 1.5).

  - If `cutoff="F-dist"`, `cutoff_lvl` is the quantile of the
    F-distribution (default is 0.975).

  - If `cutoff="farness"`, `cutoff_lvl` represents the threshold for
    farness, with a default of 0.99.

  - If `cutoff="raw"`, `cutoff_lvl` is ignored.

  If no value is provided, the function uses the default values
  associated with each cutoff method.

## Value

A list containing the robustly estimated parameters:

- `mean_IMCD_c`:

  Estimated mean of the centers of the interval data.

- `mean_IMCD_r`:

  Estimated mean of the ranges of the interval data.

- `cov_IMCD`:

  Estimated covariance (scatter) matrix
  ([`int_cov`](https://catarinaploureiro.github.io/AIDA/reference/int_cov.md))
  for the data.

- `final_z`:

  Binary vector indicating the inclusion of each observation in the
  reweighted subset.

- `cutoff`:

  The cutoff method used for reweighting.

- `cutoff_value`:

  Cutoff value used for reweighting.

- `robust_dist`:

  Robust distances
  ([`IMah_dist`](https://catarinaploureiro.github.io/AIDA/reference/IMah_dist.md))
  for each observation.

- `farness_probs`:

  Farness probabilities (if `cutoff` is set to `"farness"`).

## References

Loureiro, C. P., Oliveira, M. R., Brito, P., & Oliveira, L. (2026).
Minimum Covariance Determinant Estimator and Outlier Detection for
Interval-valued Data. arXiv preprint arXiv:2604.26769.
<https://arxiv.org/abs/2604.26769>

Adapted from <https://github.com/frankp-0/fastMCD>.

The case `cutoff=="F-dist"` is adapted from package
`CerioliOutlierDetection`
(<https://cran.r-project.org/package=CerioliOutlierDetection>).

## Examples

``` r
# Example using creditcard dataset
data(creditcard)
credit_card_int <- creditcard$intData

credit_card_IMCD <- IMCD(credit_card_int, floor(0.75*credit_card_int@NObs), "farness", 0.9)
```
