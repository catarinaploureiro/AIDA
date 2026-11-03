# Sample Correlation Matrix for Interval-valued Data

Calculate the sample correlation matrix based on the covariance matrix.

## Usage

``` r
int_cor(
  data = NULL,
  sigma_cc = NULL,
  sigma_rr = NULL,
  sigma_cr = NULL,
  LatentParam = NULL,
  LatentCase = c("U_id_symmetric", "U_id", "General"),
  cov = NULL
)
```

## Arguments

- data:

  An
  [`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the macrodata/interval data. If `cov` is not
  provided but `data` is provided, the covariance matrix is calculated
  based on the the sample covariance of the centers and ranges and the
  sample covariance between centers and ranges, and the parameters of
  the latent variables contained in the `intData` object. If `cov` and
  `data` are not provided, the covariance matrix is calculated based on
  `sigma_cc`, `sigma_rr`, `sigma_cr`, `LatentParam`, and `LatentCase`.

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
  `LatentCase` is `"General"`, as in:

  - `"U_id_symmetric"`: The latent variables are identically distributed
    and symmetric, so its parameters are:

    - \\\delta=\mathbb{E}(U^2)/4\\

  - `"U_id"`: The latent variables are identically distributed, so its
    parameters are:

    - \\\delta=\mathbb{E}(U^2)/4\\

    - \\\mathbb{E}(U)\\

  - `"General"`: The latent variables do not have any nice properties,
    so its parameters are:

    - \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{j\ell}=\mathcal{E}(U_j,U\_\ell)\\,
      \\j\neq \ell\\, with \\\mathcal{E}(U_j,U\_\ell)=\int_0^1
      F\_{U_j}^{-1}(t) F\_{U\_\ell}^{-1}(t) \\ dt\\, and
      \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{jj}=\mathbb{E}(U_j^2)\\,
      \\j,\ell=1,\dots,p\\

    - \\\boldsymbol{\Psi}=\text{Diag}(\mathbb{E}(U_1),\dots,\mathbb{E}(U_p))\\

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

- cov:

  Covariance matrix of the interval-valued data. If `cov` is provided,
  the correlation matrix is calculated based on it. If `cov` is not
  provided, the correlation matrix is calculated based on the data or
  the covariance matrices of the centers and ranges.

## Value

The symbolic correlation matrix.

## Details

This function calculates the correlation matrix based on the covariance
matrix using the [`cov2cor`](https://rdrr.io/r/stats/cor.html) function.
The correlation matrix can be calculated either based on the data, the
symbolic covariance matrix, or the covariance matrices of the centers
and ranges. For more details, see
[`int_cov`](https://catarinaploureiro.github.io/AIDA/reference/int_cov.md).

## References

Oliveira, M. R., Pinheiro, D., & Oliveira, L. (2025). Location and
association measures for interval-valued data based on Mallows'
distance. arXiv preprint arXiv:2407.05105.
<https://arxiv.org/abs/2407.05105>

## Examples

``` r
data(creditcard)
credit_card_cor <- int_cor(creditcard$intData)
```
