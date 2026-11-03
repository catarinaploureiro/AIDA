# Sample Mean for Interval-valued Data

Calculate the sample barycenter of an
[`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
object.

## Usage

``` r
int_mean(data)
```

## Arguments

- data:

  An
  [`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the macrodata/interval data.

## Value

An
[`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
object representing the sample barycenter of the interval-valued data.

## Details

Let \\\boldsymbol{x}\_1,\dots,\boldsymbol{x}\_n\\ be interval-valued
observations, the sample barycenter is defined as:

\$\$\underset{\boldsymbol{x}}{\mathrm{arg\\min}}
\sum\_{h=1}^{n}{\frac{1}{n}d\_\mathrm{M}^2(\boldsymbol{x}\_h,\boldsymbol{x})},\$\$

where \\d\_\mathrm{M}^2()\\ is the squared Mallows distance (see
[`Mallows_dist`](https://catarinaploureiro.github.io/AIDA/reference/Mallows_dist.md)).

This function calculates the barycenter of an
[`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
object, which is the hyperrectangle whose center and range are the
expected values of the centers (\\\boldsymbol{\mu}\_C\\) and ranges
(\\\boldsymbol{\mu}\_R\\), respectively:

\$\$\boldsymbol{\mu}\_B =
\left(\boldsymbol{\mu}\_C,\boldsymbol{\mu}\_R\right),\$\$

with the same `LatentParam`, `LatentCase`, and `LatentDist` as the
original
[`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
object.

## References

A. Irpino and R. Verde. Basic statistics for distributional symbolic
variables: a new metric-based approach. Advances in Data Analysis and
Classification, 9(2):143–175, Jun 2015. ISSN 1862-5355.
[doi:10.1007/s11634-014-0176-4](https://doi.org/10.1007/s11634-014-0176-4)

Oliveira, M. R., Pinheiro, D., & Oliveira, L. (2025). Location and
association measures for interval-valued data based on Mallows'
distance. arXiv preprint arXiv:2407.05105.
<https://arxiv.org/abs/2407.05105>

## Examples

``` r
data(creditcard)
credit_card_mean <- int_mean(creditcard$intData)
```
