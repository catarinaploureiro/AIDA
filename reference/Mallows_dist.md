# Mallows Distance

Calculate the squared Mallows distance between all rows in data and the
barycenter.

## Usage

``` r
Mallows_dist(data, mean_c = NULL, mean_r = NULL)
```

## Arguments

- data:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the macrodata/interval data

- mean_c:

  The mean vector of the centers

- mean_r:

  The mean vector of the ranges

## Value

A vector with the squared Mallows distance of each observation.

## Details

The squared Mallows distance is defined according to the `LatentCase`:

- `"U_id_symmetric"`: The latent variables are identically distributed
  and symmetric:
  \$\$d\_{M}(\boldsymbol{x})^2=(\boldsymbol{c}-\boldsymbol{\mu}\_C)^{\top}(\boldsymbol{c}-\boldsymbol{\mu}\_C)+\delta(\boldsymbol{r}-\boldsymbol{\mu}\_R)^{\top}(\boldsymbol{r}-\boldsymbol{\mu}\_R),\$\$
  where \\\delta=\mathbb{E}(U^2)/4\\ is the parameter of the latent
  variables.

- `"U_id"`: The latent variables are identically distributed:
  \$\$d\_{M}(\boldsymbol{x})^2=(\boldsymbol{c}-\boldsymbol{\mu}\_C)^{\top}(\boldsymbol{c}-\boldsymbol{\mu}\_C)+\delta(\boldsymbol{r}-\boldsymbol{\mu}\_R)^{\top}(\boldsymbol{r}-\boldsymbol{\mu}\_R)
  +\mathbb{E}(U)(\boldsymbol{c}-\boldsymbol{\mu}\_C)^\top(\boldsymbol{r}-\boldsymbol{\mu}\_R),\$\$
  where \\\delta=\mathbb{E}(U^2)/4\\ and \\\mathbb{E}(U)\\ are the
  parameter of the latent variables.

- `"General"`: The latent variables do not have any nice properties:
  \$\$d\_{M}(\boldsymbol{x})^2=(\boldsymbol{c}-\boldsymbol{\mu}\_C)^{\top}(\boldsymbol{c}-\boldsymbol{\mu}\_C)+(\boldsymbol{r}-\boldsymbol{\mu}\_R)^{\top}\boldsymbol{\Delta}(\boldsymbol{r}-\boldsymbol{\mu}\_R)
  +(\boldsymbol{c}-\boldsymbol{\mu}\_C)^{\top}\boldsymbol{\Psi}(\boldsymbol{r}-\boldsymbol{\mu}\_R),\$\$
  where:

  - \\\boldsymbol{\Psi}=\text{diag}(\mathbb{E}(U_1),\dots,\mathbb{E}(U_p))\\,

  - \\\boldsymbol{\Delta}=\text{diag}(\mathbb{E}(U^2_1),\dots,\mathbb{E}(U^2_p))/4\\.

## References

Oliveira, M. R., Pinheiro, D., & Oliveira, L. (2025). Location and
association measures for interval-valued data based on Mallows'
distance. arXiv preprint arXiv:2407.05105.
<https://arxiv.org/abs/2407.05105>

## Examples

``` r
data(creditcard)
credit_card_int <- creditcard$intData

credit_card_dist<-Mallows_dist(credit_card_int)
```
