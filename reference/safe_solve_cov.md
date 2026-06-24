# Safely invert a covariance matrix with Moore-Penrose generalized inverse fallback

Computes a numerically stable inverse of a covariance matrix. The
function:

1.  Attempts standard inversion via
    [`solve()`](https://rdrr.io/r/base/solve.html).

2.  If the matrix is ill-conditioned, falls back to a Moore-Penrose
    generalized inverse.

## Usage

``` r
safe_solve_cov(cov, verbose = TRUE)
```

## Arguments

- cov:

  A numeric covariance matrix.

- verbose:

  Logical; if `TRUE` (default), emits warnings when fallback method is
  used.

## Value

A matrix representing:

- The inverse of `cov` if well-conditioned

- A Moore–Penrose generalized inverse if inversion fails

## Details

When the covariance matrix is singular or nearly singular, direct
inversion may fail or produce unstable results. This function ensures
robustness by using Moore-Penrose generalized inverse (via
[`MASS::ginv()`](https://rdrr.io/pkg/MASS/man/ginv.html)).

The pseudo-inverse effectively ignores directions with negligible
variance, which may slightly affect interpretations (e.g., Mahalanobis
distances or Shapley values).

## Examples

``` r
set.seed(1)

# Example where inversion fails
X <- matrix(rnorm(20), ncol = 5)
cov_X <- cov(X)

#solve(cov_X)  # Standard inversion fails
safe_solve_cov(cov_X) # Returns a generalized inverse
#> Warning: Covariance matrix inversion failed, using Moore-Penrose generalized inverse.
#>             [,1]        [,2]        [,3]       [,4]       [,5]
#> [1,]  0.74346130  0.01998086 -0.06793993  0.1601427  0.3557837
#> [2,]  0.01998086  0.99836120 -0.21963456 -0.2284294 -1.6228953
#> [3,] -0.06793993 -0.21963456  0.14132852  0.2043512  0.4346143
#> [4,]  0.16014269 -0.22842938  0.20435116  0.4117634  0.6701536
#> [5,]  0.35578373 -1.62289530  0.43461430  0.6701536  2.9811412

# Example where inversion does not fail
Y <- cbind(rnorm(20), rnorm(20, mean=1, sd=2))
cov_Y <- cov(Y)
solve(cov_Y)  # Standard inversion succeeds
#>           [,1]      [,2]
#> [1,] 1.4325876 0.2189129
#> [2,] 0.2189129 0.4147518
safe_solve_cov(cov_Y)  # Returns same result
#>           [,1]      [,2]
#> [1,] 1.4325876 0.2189129
#> [2,] 0.2189129 0.4147518
```
