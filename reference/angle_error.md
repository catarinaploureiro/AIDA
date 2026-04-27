# Angle Error

Computes the angle error between eigenvalues of the estimated covariance
matrix and of the ground truth covariance matrix.

## Usage

``` r
angle_error(est_cov, ground_truth_cov)
```

## Arguments

- est_cov:

  Estimated covariance matrix.

- ground_truth_cov:

  Ground truth covariance matrix.

## Value

Angle error between eigenvalues.

## Details

The angle error is given by:
\$\$1-\dfrac{\hat{\boldsymbol{a}}^\top\boldsymbol{a}}{\sqrt{\hat{\boldsymbol{a}}^\top\hat{\boldsymbol{a}}}\sqrt{\boldsymbol{a}^\top\boldsymbol{a}}},\$\$
where \\\hat{\boldsymbol{a}}\\ and \\\boldsymbol{a}\\ are the
eigenvalues of the estimated and ground truth covariance matrices,
respectively.
