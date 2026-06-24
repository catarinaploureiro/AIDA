# Interval-Mahalanobis distance for all pairs

Calculate the squared Interval-Mahalanobis distance of all pairs of
observations in the data.

## Usage

``` r
IMah_dist_pairs(data, cov = NULL)
```

## Arguments

- data:

  An
  [`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the macrodata/interval data

- cov:

  (Optional) A covariance matrix. Defaults to `NULL`, in which case it
  will be computed using the
  [`IMCD`](https://catarinaploureiro.github.io/AIDA/reference/IMCD.md)
  function.

## Value

A matrix with the squared Interval-Mahalanobis distance of each pair of
observations.

## Details

The squared Interval-Mahalanobis distance between
\\\boldsymbol{x}\_1=(\boldsymbol{c}\_1^\top,\boldsymbol{r}\_1^\top)^\top\\
and
\\\boldsymbol{x}\_2=(\boldsymbol{c}\_2^\top,\boldsymbol{r}\_2^\top)^\top\\
of a population with symbolic covariance matrix
\\\boldsymbol{\Sigma}\_B\\ (see
[`int_cov`](https://catarinaploureiro.github.io/AIDA/reference/int_cov.md))
is defined according to the `LatentCase`:

- `"U_id_symmetric"`: The latent variables are identically distributed
  and symmetric:
  \$\$d\_\mathrm{IMah}(\boldsymbol{x}\_1,\boldsymbol{x}\_2)^2=(\boldsymbol{c}\_1-\boldsymbol{c}\_2)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}\_1-\boldsymbol{c}\_2)+\delta(\boldsymbol{r}\_1-\boldsymbol{r}\_2)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{r}\_1-\boldsymbol{r}\_2),\$\$
  where \\\delta=\mathbb{E}(U^2)/4\\ is the parameter of the latent
  variables.

- `"U_id"`: The latent variables are identically distributed:
  \$\$\begin{aligned}
  d\_\mathrm{IMah}(\boldsymbol{x}\_1,\boldsymbol{x}\_2)^2&=(\boldsymbol{c}\_1-\boldsymbol{c}\_2)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}\_1-\boldsymbol{c}\_2)+\delta(\boldsymbol{r}\_1-\boldsymbol{r}\_2)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{r}\_1-\boldsymbol{r}\_2)\\
  &\quad+\mathbb{E}(U)(\boldsymbol{c}\_1-\boldsymbol{c}\_2)^\top\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{r}\_1-\boldsymbol{r}\_2),
  \end{aligned}\$\$ where \\\delta=\mathbb{E}(U^2)/4\\ and
  \\\mathbb{E}(U)\\ are the parameter of the latent variables.

- `"General"`: The latent variables do not have any nice properties:
  \$\$\begin{aligned}
  d\_\mathrm{IMah}(\boldsymbol{x}\_1,\boldsymbol{x}\_2)^2&=(\boldsymbol{c}\_1-\boldsymbol{c}\_2)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}\_1-\boldsymbol{c}\_2)+\dfrac{1}{4}(\boldsymbol{r}\_1-\boldsymbol{r}\_2)^{\top}\left(\boldsymbol{\mathfrak{E}}\_{UU}\bullet\boldsymbol{\Sigma}\_{B}^{-1}\right)(\boldsymbol{r}\_1-\boldsymbol{r}\_2)\\
  &\quad+(\boldsymbol{c}\_1-\boldsymbol{c}\_2)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}\boldsymbol{\Psi}(\boldsymbol{r}\_1-\boldsymbol{r}\_2),
  \end{aligned}\$\$ where:

  - \\\boldsymbol{\Psi}=\text{diag}(\mathbb{E}(U_1),\dots,\mathbb{E}(U_p))\\,

  - \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{j\ell}=\mathcal{E}(U_j,U\_\ell)\\,
    \\j\neq \ell\\, with \\\mathcal{E}(U_j,U\_\ell)=\int_0^1
    F\_{U_j}^{-1}(t) F\_{U\_\ell}^{-1}(t) \\ dt\\,

  - \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{jj}=\mathbb{E}(U_j^2)\\,
    \\j,\ell=1,\dots,p\\,

  - \\\bullet\\ denotes the Schur (or entrywise) product of matrices.

If `cov` is not provided, it will be computed using the
[`IMCD`](https://catarinaploureiro.github.io/AIDA/reference/IMCD.md)
function. Additionally, if `cov` is set as the identity matrix, the
computed distance is the Mallows distance between pairs of observations.

## References

Loureiro, C. P., Oliveira, M. R., Brito, P., & Oliveira, L. (2026).
Minimum Covariance Determinant Estimator and Outlier Detection for
Interval-valued Data. arXiv preprint arXiv:2604.26769.
<https://arxiv.org/abs/2604.26769>

## Examples

``` r
data(creditcard)
credit_card_int <- creditcard$intData

credit_card_dist <- IMah_dist_pairs(credit_card_int)
```
