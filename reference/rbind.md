# Row Bind for [`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)

Combine multiple
[`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
objects by rows.

## Usage

``` r
rbind(..., deparse.level = 1)

# S4 method for class 'intData'
rbind(..., deparse.level = 1)
```

## Arguments

- ...:

  [`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  objects to combine.

- deparse.level:

  An integer controlling the construction of labels in the result
  (default is `1`).

## Value

An
[`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
object with rows combined from the input
[`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
objects.
