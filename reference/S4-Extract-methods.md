# Subset an [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md) Object

Extract a subset of rows and columns from an
[intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
object.

## Usage

``` r
# S4 method for class 'intData'
x[i, j, ..., drop = TRUE]
```

## Arguments

- x:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object.

- i:

  Row indices or names to subset. Defaults to all rows.

- j:

  Column indices or names to subset. Defaults to all columns.

- ...:

  Additional arguments (not used).

- drop:

  Logical, passed to the underlying `[`. Defaults to `TRUE`.

## Value

An
[intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
object containing the specified subset of rows and columns.
