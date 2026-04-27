# Sample Mean

Calculate the mean of X in function of z

## Usage

``` r
int_mean_z(z, X)
```

## Arguments

- z:

  A vector of 0 and 1, indicating which observations should be
  considered for the calculation

- X:

  A matrix where the rows correspond to observations and the columns to
  variables

## Value

A vector where each element is the mean for each variable

## Details

This function calculates the mean of \\\boldsymbol{X}\\ in function of
\\\boldsymbol{z}\\. If \\\boldsymbol{z}\\ is a vector of 0 and 1, the
mean is calculated for the \\m\\ observations that are equal to 1:
\$\$\bar{\boldsymbol{x}}(\boldsymbol{z}) = \dfrac{1}{m}
\boldsymbol{X}^\top \boldsymbol{z}.\$\$

## Examples

``` r
n <- 100
p <- 4
X <- matrix(rnorm(n * p), ncol = p)
#if we consider all the observations the result obtained is the same as colMeans()
z <- c(rep(1, n))
int_mean_z(z, X)
#> [1]  0.1329703 -0.2032027  0.0440559  0.0096461
colMeans(X)
#> [1]  0.1329703 -0.2032027  0.0440559  0.0096461
```
