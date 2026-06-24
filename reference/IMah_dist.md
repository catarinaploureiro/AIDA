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
  [`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the macrodata/interval data

- z:

  (Optional) A vector of 0 and 1, indicating which observations should
  be considered for the calculation. If `z` is not `NULL`, `mean_c`,
  `mean_r`, and `cov` will be computed using only the observations with
  `z=1` (see
  [`int_mean_z`](https://catarinaploureiro.github.io/AIDA/reference/int_mean_z.md)
  and
  [`int_cov_z`](https://catarinaploureiro.github.io/AIDA/reference/int_cov_z.md)).
  Defaults to `NULL`.

- mean_c:

  (Optional) A vector specifying the mean of centers. Defaults to
  `NULL`, in which case it will be computed using the
  [`IMCD`](https://catarinaploureiro.github.io/AIDA/reference/IMCD.md)
  function, if `z` is also `NULL`.

- mean_r:

  (Optional) A vector specifying the mean of ranges. Defaults to `NULL`,
  in which case it will be computed using the
  [`IMCD`](https://catarinaploureiro.github.io/AIDA/reference/IMCD.md)
  function, if `z` is also `NULL`.

- cov:

  (Optional) A covariance matrix. Defaults to `NULL`, in which case it
  will be computed using the
  [`IMCD`](https://catarinaploureiro.github.io/AIDA/reference/IMCD.md)
  function, if `z` is also `NULL`.

## Value

A vector with the squared Interval-Mahalanobis distance of each
observation.

## Details

The squared Interval-Mahalanobis distance between
\\\boldsymbol{x}=(\boldsymbol{c}^\top,\boldsymbol{r}^\top)^\top\\ and
the barycenter
\\\boldsymbol{\mu}\_B=(\boldsymbol{\mu}\_C^\top,\boldsymbol{\mu}\_R^\top)^\top\\
of a population with symbolic covariance matrix
\\\boldsymbol{\Sigma}\_B\\ (see
[`int_cov`](https://catarinaploureiro.github.io/AIDA/reference/int_cov.md))
is defined according to the `LatentCase`:

- `"U_id_symmetric"`: The latent variables are identically distributed
  and symmetric:
  \$\$d\_\mathrm{IMah}(\boldsymbol{x})^2=(\boldsymbol{c}-\boldsymbol{\mu}\_C)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}-\boldsymbol{\mu}\_C)+\delta(\boldsymbol{r}-\boldsymbol{\mu}\_R)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{r}-\boldsymbol{\mu}\_R),\$\$
  where \\\delta=\mathbb{E}(U^2)/4\\ is the parameter of the latent
  variables.

- `"U_id"`: The latent variables are identically distributed:
  \$\$\begin{aligned}
  d\_\mathrm{IMah}(\boldsymbol{x})^2&=(\boldsymbol{c}-\boldsymbol{\mu}\_C)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}-\boldsymbol{\mu}\_C)+\delta(\boldsymbol{r}-\boldsymbol{\mu}\_R)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{r}-\boldsymbol{\mu}\_R)\\
  &\quad+\mathbb{E}(U)(\boldsymbol{c}-\boldsymbol{\mu}\_C)^\top\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{r}-\boldsymbol{\mu}\_R),
  \end{aligned}\$\$ where \\\delta=\mathbb{E}(U^2)/4\\ and
  \\\mathbb{E}(U)\\ are the parameter of the latent variables.

- `"General"`: The latent variables do not have any nice properties:
  \$\$\begin{aligned}
  d\_\mathrm{IMah}(\boldsymbol{x})^2&=(\boldsymbol{c}-\boldsymbol{\mu}\_C)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}-\boldsymbol{\mu}\_C)+\dfrac{1}{4}(\boldsymbol{r}-\boldsymbol{\mu}\_R)^{\top}\left(\boldsymbol{\mathfrak{E}}\_{UU}\bullet\boldsymbol{\Sigma}\_{B}^{-1}\right)(\boldsymbol{r}-\boldsymbol{\mu}\_R)\\
  &\quad+(\boldsymbol{c}-\boldsymbol{\mu}\_C)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}\boldsymbol{\Psi}(\boldsymbol{r}-\boldsymbol{\mu}\_R),
  \end{aligned}\$\$ where:

  - \\\boldsymbol{\Psi}=\text{diag}(\mathbb{E}(U_1),\dots,\mathbb{E}(U_p))\\,

  - \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{j\ell}=\mathcal{E}(U_j,U\_\ell)\\,
    \\j\neq \ell\\, with \\\mathcal{E}(U_j,U\_\ell)=\int_0^1
    F\_{U_j}^{-1}(t) F\_{U\_\ell}^{-1}(t) \\ dt\\,

  - \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{jj}=\mathbb{E}(U_j^2)\\,
    \\j,\ell=1,\dots,p\\,

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

# Compute squared Interval-Mahalanobis distance using IMCD estimates of mean and covariance
credit_card_dist <- IMah_dist(credit_card_int)
```
