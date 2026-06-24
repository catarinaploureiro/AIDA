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
  [`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the macrodata/interval data. If `data` is provided,
  the covariance matrix is calculated based on the the sample covariance
  of the centers and ranges and the sample covariance between centers
  and ranges, and the parameters of the latent variables contained in
  the `intData` object. If `data` is not provided, the covariance matrix
  is calculated based on `sigma_cc`, `sigma_rr`, `sigma_cr`,
  `LatentParam`, and `LatentCase`.

- sigma_cc:

  Covariance matrix of the centers.

- sigma_rr:

  Covariance matrix of the ranges.

- sigma_cr:

  Covariance matrix between the centers and ranges.

- LatentParam:

  A list with the parameters of the latent variables. Expects a list
  with a single number if `LatentCase` is `"U_id_symmetric"`, a list of
  two numbers if `LatentCase` is `"U_id"`, and a list of two matrices if
  `LatentCase` is `"General"`.

- LatentCase:

  A string specifying which of the three scenarios applies to the latent
  variables:

  - `"U_id_symmetric"`: The case where the latent variables are
    identically distributed and symmetric.

  - `"U_id"`: The case where the latent variables are identically
    distributed.

  - `"General"`: The case where the latent variables do not have any
    nice properties.

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

  - \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{j\ell}=\mathcal{E}(U_j,U\_\ell)\\,
    \\j\neq \ell\\, with \\\mathcal{E}(U_j,U\_\ell)=\int_0^1
    F\_{U_j}^{-1}(t) F\_{U\_\ell}^{-1}(t) \\ dt\\,

  - \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{jj}=\mathbb{E}(U_j^2)\\,
    \\j,\ell=1,\dots,p\\,

  - \\\bullet\\ denotes the Schur (or entrywise) product of matrices.

The covariance matrix can be calculated either based on the covariance
matrices of the centers and ranges or based on the data. If the data is
provided, the covariance matrices are calculated using the sample
covariance of the centers and ranges and the sample covariance between
centers and ranges. For the robust estimation of the covariance matrix,
see
[`IMCD`](https://catarinaploureiro.github.io/AIDA/reference/IMCD.md).

## References

Oliveira, M. R., Pinheiro, D., & Oliveira, L. (2025). Location and
association measures for interval-valued data based on Mallows'
distance. arXiv preprint arXiv:2407.05105.
<https://arxiv.org/abs/2407.05105>

## Examples

``` r
data(creditcard)
credit_card_int <- creditcard$intData

credit_card_cov <- int_cov(credit_card_int)
```
