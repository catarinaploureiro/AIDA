# Compute Shapley Decomposition into contributions of (Centers, Ranges, and CrossCentersRanges) for Interval-valued Data

Decomposes the squared interval-valued Mahalanobis distance of each
observation into outlyingness contributions of (Centers, Ranges, and
CrossCentersRanges) per variable for interval-valued data.

## Usage

``` r
int_Shapley_decomp(data, mean_c = NULL, mean_r = NULL, cov = NULL)
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

A list containing the matrix of Shapley value decomposition into
contributions of (Centers, Ranges, and CrossCentersRanges) per variable
for each observation.

## Details

Let
\\\boldsymbol{\mu}\_B=(\boldsymbol{\mu}\_C^\top,\boldsymbol{\mu}\_R^\top)^\top\\
be the barycenter and \\\boldsymbol{\Sigma}\_B\\ the symbolic covariance
matrix (see
[`int_cov`](https://catarinaploureiro.github.io/AIDA/reference/int_cov.md)).
Based on the Shapley value (see
[`int_Shapley`](https://catarinaploureiro.github.io/AIDA/reference/int_Shapley.md)),
we can further decompose the Interval-Mahalanobis distance of an
interval-valued observation
\\\boldsymbol{x}=(\boldsymbol{c}^\top,\boldsymbol{r}^\top)^\top\\ into
contributions of the centers, ranges and cross-centers-ranges of the
variables. The decomposition is defined according to the `LatentCase`:

- `"U_id_symmetric"`: The latent variables are identically distributed
  and symmetric:

  - Centers contribution:
    \$\$(\boldsymbol{c}-\boldsymbol{\mu}\_C)\bullet\left\[\boldsymbol{\Sigma}\_B^{-1}(\boldsymbol{c}-\boldsymbol{\mu}\_C)\right\],\$\$

  - Ranges contribution:
    \$\$\delta(\boldsymbol{r}-\boldsymbol{\mu}\_R)\bullet\left\[\boldsymbol{\Sigma}\_B^{-1}(\boldsymbol{r}-\boldsymbol{\mu}\_R)\right\],\$\$

  where \\\delta=\mathbb{E}(U^2)/4\\ is the parameter of the latent
  variables.

- `"U_id"`: The latent variables are identically distributed:

  - Centers contribution:
    \$\$(\boldsymbol{c}-\boldsymbol{\mu}\_C)\bullet\left\[\boldsymbol{\Sigma}\_B^{-1}(\boldsymbol{c}-\boldsymbol{\mu}\_C)\right\],\$\$

  - Ranges contribution:
    \$\$\delta(\boldsymbol{r}-\boldsymbol{\mu}\_R)\bullet\left\[\boldsymbol{\Sigma}\_B^{-1}(\boldsymbol{r}-\boldsymbol{\mu}\_R)\right\],\$\$

  - CrossCentersRanges contribution:
    \$\$\dfrac{\mathbb{E}(U)}{2}(\boldsymbol{c}-\boldsymbol{\mu}\_C)\bullet\left\[\boldsymbol{\Sigma}\_B^{-1}(\boldsymbol{r}-\boldsymbol{\mu}\_R)\right\]+\dfrac{\mathbb{E}(U)}{2}(\boldsymbol{r}-\boldsymbol{\mu}\_R)\bullet\left\[\boldsymbol{\Sigma}\_B^{-1}(\boldsymbol{c}-\boldsymbol{\mu}\_C)\right\],\$\$

  where \\\delta=\mathbb{E}(U^2)/4\\ and \\\mathbb{E}(U)\\ are the
  parameter of the latent variables.

- `"General"`: The latent variables do not have any nice properties:

  - Centers contribution:
    \$\$(\boldsymbol{c}-\boldsymbol{\mu}\_C)\bullet\left\[\boldsymbol{\Sigma}\_B^{-1}(\boldsymbol{c}-\boldsymbol{\mu}\_C)\right\],\$\$

  - Ranges contribution:
    \$\$\dfrac{1}{4}(\boldsymbol{r}-\boldsymbol{\mu}\_R)\bullet\left\[\left(\boldsymbol{\mathfrak{E}}\_{UU}\bullet\boldsymbol{\Sigma}\_B^{-1}\right)(\boldsymbol{r}-\boldsymbol{\mu}\_R)\right\],\$\$

  - CrossCentersRanges contribution:
    \$\$\dfrac{1}{2}(\boldsymbol{c}-\boldsymbol{\mu}\_C)\bullet\left\[\boldsymbol{\Sigma}\_B^{-1}\boldsymbol{\Psi}(\boldsymbol{r}-\boldsymbol{\mu}\_R)\right\]+\dfrac{1}{2}(\boldsymbol{r}-\boldsymbol{\mu}\_R)\bullet\left\[\boldsymbol{\Psi}\boldsymbol{\Sigma}\_B^{-1}(\boldsymbol{c}-\boldsymbol{\mu}\_C)\right\],\$\$

  where:

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

# Compute Shapley decomposition into contributions of (Centers, Ranges, and CrossCentersRanges) 
# based on IMCD estimates of mean and covariance
credit_card_shap_decomp <- int_Shapley_decomp(credit_card_int)
```
