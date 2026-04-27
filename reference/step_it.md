# Iterate through C-step

Iterate through C-step

## Usage

``` r
step_it(z, m, data, it = 0)
```

## Arguments

- z:

  A vector of 0 and 1, indicating which observations should be
  considered for the calculation

- m:

  An integer specifying number of observations to use

- data:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the macrodata/interval data

- it:

  An optional integer specifying the number of C-steps to perform. With
  it = 0, C-step will be performed until convergence

## Value

A list of z, covariance, barycenter and robust distances
