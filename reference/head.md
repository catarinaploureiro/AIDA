# Head Method for [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)

Returns the first `n` rows of an
[intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
object.

## Usage

``` r
# S4 method for class 'intData'
head(x, n = min(nrow(x), 6L))
```

## Arguments

- x:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object.

- n:

  The number of rows to return.

## Value

A subset of the
[intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
object.
