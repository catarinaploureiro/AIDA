# Compute Shapley interaction indices for Interval-valued Data

Obtains a \\p \times p\\ matrix containing pairwise outlyingness scores
based on Shapley interaction indices for each observation. Decomposes
the squared interval-valued Mahalanobis distance of each observation
into outlyingness contributions of pairs of variables.

## Usage

``` r
int_Shapley_interaction(data, mean_c = NULL, mean_r = NULL, cov = NULL)
```

## Arguments

- data:

  An
  [`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the interval-valued dataset (macrodata).

- mean_c:

  (Optional) A vector specifying the mean of centers. Defaults to
  `NULL`, in which case it will be computed using the
  [`IMCD`](https://catarinaploureiro.github.io/AIDA/reference/IMCD.md)
  function.

- mean_r:

  (Optional) A vector specifying the mean of ranges. Defaults to `NULL`,
  in which case it will be computed using the
  [`IMCD`](https://catarinaploureiro.github.io/AIDA/reference/IMCD.md)
  function.

- cov:

  (Optional) A covariance matrix. Defaults to `NULL`, in which case it
  will be computed using the
  [`IMCD`](https://catarinaploureiro.github.io/AIDA/reference/IMCD.md)
  function.

## Value

A list containing the matrix of Shapley interaction indices for each
observation.

## Details

Let
\\\boldsymbol{\mu}\_B=(\boldsymbol{\mu}\_C^\top,\boldsymbol{\mu}\_R^\top)^\top\\
be the barycenter and \\\boldsymbol{\Sigma}\_B\\ the symbolic covariance
matrix (see
[`int_cov`](https://catarinaploureiro.github.io/AIDA/reference/int_cov.md)).
Let also \\\boldsymbol{\phi}(\boldsymbol{x})\\ be the Shapley value of
\\\boldsymbol{x}\\ (see
[`int_Shapley`](https://catarinaploureiro.github.io/AIDA/reference/int_Shapley.md))
and \\\mathrm{diag}(\boldsymbol{v})\\ be the diagonal matrix whose main
diagonal is the vector \\\boldsymbol{v}\\. The Shapley interaction index
of an interval-valued observation
\\\boldsymbol{x}=(\boldsymbol{c}^\top,\boldsymbol{r}^\top)^\top\\, for
the Interval-Mahalanobis distance, is defined according to the
`LatentCase`:

- `"U_id_symmetric"`: The latent variables are identically distributed
  and symmetric:
  \$\$\boldsymbol{\Phi}(\boldsymbol{x})=2(\boldsymbol{c}-\boldsymbol{\mu}\_C)(\boldsymbol{c}-\boldsymbol{\mu}\_C)^\top\bullet\boldsymbol{\Sigma}\_B^{-1} +
  2\delta(\boldsymbol{r}-\boldsymbol{\mu}\_R)(\boldsymbol{r}-\boldsymbol{\mu}\_R)^\top\bullet\boldsymbol{\Sigma}\_B^{-1}-\mathrm{diag}\left(\boldsymbol{\phi}(\boldsymbol{x})\right),\$\$
  where \\\delta=\mathbb{E}(U^2)/4\\ is the parameter of the latent
  variables.

- `"U_id"`: The latent variables are identically distributed:
  \$\$\begin{aligned}
  \boldsymbol{\Phi}(\boldsymbol{x})&=2(\boldsymbol{c}-\boldsymbol{\mu}\_C)(\boldsymbol{c}-\boldsymbol{\mu}\_C)^\top\bullet\boldsymbol{\Sigma}\_B^{-1} +
  2\delta(\boldsymbol{r}-\boldsymbol{\mu}\_R)(\boldsymbol{r}-\boldsymbol{\mu}\_R)^\top\bullet\boldsymbol{\Sigma}\_B^{-1}\\
  &\quad+\mathbb{E}(U)(\boldsymbol{c}-\boldsymbol{\mu}\_C)(\boldsymbol{r}-\boldsymbol{\mu}\_R)^\top\bullet\boldsymbol{\Psi} +
  \mathbb{E}(U)(\boldsymbol{r}-\boldsymbol{\mu}\_R)(\boldsymbol{c}-\boldsymbol{\mu}\_C)^\top\bullet\boldsymbol{\Sigma}\_B^{-1}-\mathrm{diag}\left(\boldsymbol{\phi}(\boldsymbol{x})\right),
  \end{aligned}\$\$ where \\\delta=\mathbb{E}(U^2)/4\\ and
  \\\mathbb{E}(U)\\ are the parameter of the latent variables.

- `"General"`: The latent variables do not have any nice properties:
  \$\$\begin{aligned}
  \boldsymbol{\Phi}(\boldsymbol{x})&=2(\boldsymbol{c}-\boldsymbol{\mu}\_C)(\boldsymbol{c}-\boldsymbol{\mu}\_C)^\top\bullet\boldsymbol{\Sigma}\_B^{-1} +
  \dfrac{1}{2}(\boldsymbol{r}-\boldsymbol{\mu}\_R)(\boldsymbol{r}-\boldsymbol{\mu}\_R)^\top\bullet\boldsymbol{\mathfrak{E}}\_{UU}\bullet\boldsymbol{\Sigma}\_B^{-1}\\
  &\quad+(\boldsymbol{c}-\boldsymbol{\mu}\_C)(\boldsymbol{r}-\boldsymbol{\mu}\_R)^\top\bullet\boldsymbol{\Sigma}\_B^{-1}\boldsymbol{\Psi} +
  (\boldsymbol{r}-\boldsymbol{\mu}\_R)(\boldsymbol{c}-\boldsymbol{\mu}\_C)^\top\bullet\boldsymbol{\Psi}\boldsymbol{\Sigma}\_B^{-1}-\mathrm{diag}\left(\boldsymbol{\phi}(\boldsymbol{x})\right),
  \end{aligned}\$\$ where:

- \\\boldsymbol{\Psi}=\text{Diag}(\mathbb{E}(U_1),\dots,\mathbb{E}(U_p))\\,

- \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{j\ell}=\mathcal{E}(U_j,U\_\ell)\\,
  \\j\neq \ell\\, with \\\mathcal{E}(U_j,U\_\ell)=\int_0^1
  F\_{U_j}^{-1}(t) F\_{U\_\ell}^{-1}(t) \\ dt\\,

- \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{jj}=\mathbb{E}(U_j^2)\\,
  \\j,\ell=1,\dots,p\\,

- \\\bullet\\ denotes the Schur (or entrywise) product of matrices.

## References

Loureiro, C. P., Oliveira, M. R., Brito, P., & Oliveira, L. (2026).
Explainable Outlier Detection for Interval-valued Data. arXiv preprint
arXiv:2606.26307. <https://arxiv.org/abs/2606.26307>

## Examples

``` r
# Create intData object
data(creditcard)
credit_card_int <- creditcard$intData

# Compute Shapley interaction indices based on the mean and covariance matrix estimated by IMCD
credit_card_shap_inter <- int_Shapley_interaction(credit_card_int)
```
