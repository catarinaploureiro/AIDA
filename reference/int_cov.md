# Interval-valued Covariance

Calculate the interval-valued covariance matrix based on the covariance
matrices of the centers and ranges or data.

## Usage

``` r
int_cov(
  data = NULL,
  sigma_cc = NULL,
  sigma_rr = NULL,
  sigma_cr = NULL,
  LatentParam = NULL,
  LatentCase = c("U_id_symmetric", "U_id", "General")
)
```

## Arguments

- data:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the macrodata/interval data.

- sigma_cc:

  Covariance matrix of the centers.

- sigma_rr:

  Covariance matrix of the ranges.

- sigma_cr:

  Covariance matrix between the centers and ranges.

- LatentParam:

  A list with the parameters of the latent variables.

- LatentCase:

  A string specifying which of the three scenarios applies to the latent
  variables:

  - `"General"`: The case where the latent variables do not have any
    nice properties.

  - `"U_id"`: The case where the latent variables are identically
    distributed.

  - `"U_id_symmetric"`: The case where the latent variables are
    identically distributed and symmetric.

  Defaults to `"U_id_symmetric"`.

## Value

The symbolic covariance matrix.

## Details

This function calculates the interval-valued covariance matrix,
\\\boldsymbol{\Sigma}\_B\\, based on the covariance matrices of the
centers, \\\boldsymbol{\Sigma}\_{CC}\\, ranges,
\\\boldsymbol{\Sigma}\_{RR}\\, and the covariance matrix between the
centers and ranges,
\\\boldsymbol{\Sigma}\_{CR}=\boldsymbol{\Sigma}\_{RC}^\top\\. The
covariance matrix is defined according to the `LatentCase`:

- `"U_id_symmetric"`: The latent variables are identically distributed
  and symmetric:
  \$\$\boldsymbol{\Sigma}\_B=\boldsymbol{\Sigma}\_{CC}+\delta\boldsymbol{\Sigma}\_{RR},\$\$
  where \\\delta=\mathbb{E}(U^2)/4\\ is the parameter of the latent
  variables.

- `"U_id"`: The latent variables are identically distributed:
  \$\$\boldsymbol{\Sigma}\_B=\boldsymbol{\Sigma}\_{CC}+\delta\boldsymbol{\Sigma}\_{RR}+\dfrac{\mathbb{E}(U)}{2}\left(\boldsymbol{\Sigma}\_{CR}+\boldsymbol{\Sigma}\_{RC}\right),\$\$
  where \\\delta=\mathbb{E}(U^2)/4\\ and \\\mathbb{E}(U)\\ are the
  parameters of the latent variables.

- `"General"`: The latent variables do not have any nice properties:
  \$\$\boldsymbol{\Sigma}\_B=\boldsymbol{\Sigma}\_{CC}+\dfrac{1}{4}\boldsymbol{\mathfrak{E}}\_{UU}\bullet\boldsymbol{\Sigma}\_{RR}+\dfrac{1}{2}\boldsymbol{\Sigma}\_{CR}\boldsymbol{\Psi}+\dfrac{1}{2}\boldsymbol{\Psi}\boldsymbol{\Sigma}\_{RC}\$\$
  where:

  - \\\boldsymbol{\Psi}=\text{diag}(\mathbb{E}(U_1),\dots,\mathbb{E}(U_p))\\,

  - \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{ij}=\mathcal{E}(U_i,U_j)\\,
    \\i\neq j\\, with \\\mathcal{E}(U_i,U_j)=\int_0^1 F\_{U_i}^{-1}(t)
    F\_{U_j}^{-1}(t) \\ dt\\,

  - \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{ii}=\mathbb{E}(U_i^2)\\,
    \\i,j=1,\dots,p\\,

  - \\\bullet\\ denotes the Schur (or entrywise) product of matrices.

## References

Oliveira, M. R., Pinheiro, D., & Oliveira, L. (2025). Location and
association measures for interval-valued data based on Mallows'
distance. arXiv preprint arXiv:2407.05105.
<https://arxiv.org/abs/2407.05105>

## Examples

``` r
data(creditcard)
credit_card_int <- creditcard$intData

credit_card_cov<-int_cov(credit_card_int)
```
