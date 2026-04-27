# Choose the 10 best estimates after iterating twice through initial sets

Choose the 10 best estimates after iterating twice through initial sets

## Usage

``` r
pick10(z_all, m, data)
```

## Arguments

- z_all:

  A 2D matrix where each row specifies a subset of observations

- m:

  An integer specifying number of observations to use

- data:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the macrodata/interval data

## Value

A list of z, covariance, barycenter and robust distances
