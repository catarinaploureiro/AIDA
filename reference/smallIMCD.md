# Obtain unweighted estimates for data with \<= 600 observations

Obtain unweighted estimates for data with \<= 600 observations

## Usage

``` r
smallIMCD(m, data)
```

## Arguments

- m:

  An integer specifying the number of observations to use

- data:

  An
  [`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the macrodata/interval data

## Value

A list of z (`updated_z`), estimated symbolic covariance (`S`),
barycenter (`mean_c`, `mean_r`) and robust distances (`robust_dist`)
