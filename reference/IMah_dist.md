# Interval-Mahalanobis Distance

Calculate the squared Interval-Mahalanobis distance of all rows in the
data and the barycenter.

## Usage

``` r
IMah_dist(data, z = NULL, mean_c = NULL, mean_r = NULL, cov = NULL)
```

## Arguments

- data:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the macrodata/interval data

- z:

  A vector of 0 and 1, indicating which observations should be
  considered for the calculation. You must provide either `z` or
  (`mean_c`, `mean_r` and `cov`)

- mean_c:

  The mean vector of the centers

- mean_r:

  The mean vector of the ranges

- cov:

  The symbolic covariance matrix

## Value

A vector with the squared Interval-Mahalanobis distance of each
observation.

## Details

The squared Interval-Mahalanobis distance is defined according to the
`LatentCase`:

- `"U_id_symmetric"`: The latent variables are identically distributed
  and symmetric:
  \$\$d\_{IMah}(\boldsymbol{x})^2=(\boldsymbol{c}-\boldsymbol{\mu}\_C)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}-\boldsymbol{\mu}\_C)+\delta(\boldsymbol{r}-\boldsymbol{\mu}\_R)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{r}-\boldsymbol{\mu}\_R),\$\$
  where \\\delta=\mathbb{E}(U^2)/4\\ is the parameter of the latent
  variables.

- `"U_id"`: The latent variables are identically distributed:
  \$\$d\_{IMah}(\boldsymbol{x})^2=(\boldsymbol{c}-\boldsymbol{\mu}\_C)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}-\boldsymbol{\mu}\_C)+\delta(\boldsymbol{r}-\boldsymbol{\mu}\_R)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{r}-\boldsymbol{\mu}\_R)\\
  +\dfrac{\mathbb{E}(U)}{2}(\boldsymbol{c}-\boldsymbol{\mu}\_C)^\top\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{r}-\boldsymbol{\mu}\_R)+\dfrac{\mathbb{E}(U)}{2}(\boldsymbol{r}-\boldsymbol{\mu}\_R)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}-\boldsymbol{\mu}\_C),\$\$
  where \\\delta=\mathbb{E}(U^2)/4\\ and \\\mathbb{E}(U)\\ are the
  parameter of the latent variables.

- `"General"`: The latent variables do not have any nice properties:
  \$\$d\_{IMah}(\boldsymbol{x})^2=(\boldsymbol{c}-\boldsymbol{\mu}\_C)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}-\boldsymbol{\mu}\_C)+\dfrac{1}{4}(\boldsymbol{r}-\boldsymbol{\mu}\_R)^{\top}\left(\boldsymbol{\mathfrak{E}}\_{UU}\bullet\boldsymbol{\Sigma}\_{B}^{-1}\right)(\boldsymbol{r}-\boldsymbol{\mu}\_R)\\
  +\dfrac{1}{2}(\boldsymbol{c}-\boldsymbol{\mu}\_C)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}\boldsymbol{\Psi}(\boldsymbol{r}-\boldsymbol{\mu}\_R)+\dfrac{1}{2}(\boldsymbol{r}-\boldsymbol{\mu}\_R)^{\top}\boldsymbol{\Psi}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}-\boldsymbol{\mu}\_C),\$\$
  where:

  - \\\boldsymbol{\Psi}=\text{diag}(\mathbb{E}(U_1),\dots,\mathbb{E}(U_p))\\,

  - \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{ij}=\mathcal{E}(U_i,U_j)\\,
    \\i\neq j\\, with \\\mathcal{E}(U_i,U_j)=\int_0^1 F\_{U_i}^{-1}(t)
    F\_{U_j}^{-1}(t) \\ dt\\,

  - \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{ii}=\mathbb{E}(U_i^2)\\,
    \\i,j=1,\dots,p\\,

  - \\\bullet\\ denotes the Schur (or entrywise) product of matrices.

## References

Loureiro, C. P., Oliveira, M. R., Brito, P., & Oliveira, L. (2026).
Minimum Covariance Determinant Estimator and Outlier Detection for
Interval-valued Data. arXiv preprint arXiv:2604.26769.
<https://arxiv.org/abs/2604.26769>

## Examples

``` r
data(creditcard)
credit_card_int <- creditcard$intData

z <- rep(1, nrow(credit_card_int))
credit_card_dist<-IMah_dist(credit_card_int,z)
```
