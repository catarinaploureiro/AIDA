# Perform single iteration of C-step

Perform single iteration of C-step

## Usage

``` r
c_step(z, m, data)
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

## Value

A list of z, covariance, barycenter and robust distances
