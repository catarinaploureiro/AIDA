# Relative Frobenius Error

Computes the relative Frobenius error between an estimated covariance
matrix and the ground truth.

## Usage

``` r
frobenius_error(est_cov, ground_truth_cov)
```

## Arguments

- est_cov:

  Estimated covariance matrix.

- ground_truth_cov:

  Ground truth covariance matrix.

## Value

Frobenius error between the two matrices.

## Details

The relative Frobenius error is given by: \$\$\dfrac{\\\boldsymbol{A} -
\boldsymbol{B}\\\_F}{\\\boldsymbol{B}\\\_F}=\dfrac{\sqrt{\sum\limits\_{i=1}^{p}\sum\limits\_{j=1}^{p}\|\[\boldsymbol{A}\]\_{ij}-\[\boldsymbol{B}\]\_{ij}\|^2}}{\sqrt{\sum\limits\_{i=1}^{p}\sum\limits\_{j=1}^{p}\|\[\boldsymbol{B}\]\_{ij}\|^2}},\$\$
where \\\boldsymbol{A}\\ and \\\boldsymbol{B}\\ are the estimated and
ground truth covariance matrices, respectively.
