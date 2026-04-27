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
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the macrodata/interval data

- cov:

  The symbolic covariance matrix

## Value

A matrix with the squared Interval-Mahalanobis distance of each pair of
observations.

## Details

The squared Interval-Mahalanobis distance is defined according to the
`LatentCase`:

- `"U_id_symmetric"`: The latent variables are identically distributed
  and symmetric:
  \$\$d\_{IMah}(\boldsymbol{x}\_i,\boldsymbol{x}\_j)^2=(\boldsymbol{c}\_i-\boldsymbol{c}\_j)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}\_i-\boldsymbol{c}\_j)+\delta(\boldsymbol{r}\_i-\boldsymbol{r}\_j)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{r}\_i-\boldsymbol{r}\_j),\$\$
  where \\\delta=\mathbb{E}(U^2)/4\\ is the parameter of the latent
  variables.

- `"U_id"`: The latent variables are identically distributed:
  \$\$d\_{IMah}(\boldsymbol{x}\_i,\boldsymbol{x}\_j)^2=(\boldsymbol{c}\_i-\boldsymbol{c}\_j)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}\_i-\boldsymbol{c}\_j)+\delta(\boldsymbol{r}\_i-\boldsymbol{r}\_j)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{r}\_i-\boldsymbol{r}\_j)\\
  +\dfrac{\mathbb{E}(U)}{2}(\boldsymbol{c}\_i-\boldsymbol{c}\_j)^\top\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{r}\_i-\boldsymbol{r}\_j)+\dfrac{\mathbb{E}(U)}{2}(\boldsymbol{r}\_i-\boldsymbol{r}\_j)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}\_i-\boldsymbol{c}\_j),\$\$
  where \\\delta=\mathbb{E}(U^2)/4\\ and \\\mathbb{E}(U)\\ are the
  parameter of the latent variables.

- `"General"`: The latent variables do not have any nice properties:
  \$\$d\_{IMah}(\boldsymbol{x}\_i,\boldsymbol{x}\_j)^2=(\boldsymbol{c}\_i-\boldsymbol{c}\_j)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}\_i-\boldsymbol{c}\_j)+\dfrac{1}{4}(\boldsymbol{r}\_i-\boldsymbol{r}\_j)^{\top}\left(\boldsymbol{\mathfrak{E}}\_{UU}\bullet\boldsymbol{\Sigma}\_{B}^{-1}\right)(\boldsymbol{r}\_i-\boldsymbol{r}\_j)\\
  +\dfrac{1}{2}(\boldsymbol{c}\_i-\boldsymbol{c}\_j)^{\top}\boldsymbol{\Sigma}\_{B}^{-1}\boldsymbol{\Psi}(\boldsymbol{r}\_i-\boldsymbol{r}\_j)+\dfrac{1}{2}(\boldsymbol{r}\_i-\boldsymbol{r}\_j)^{\top}\boldsymbol{\Psi}\boldsymbol{\Sigma}\_{B}^{-1}(\boldsymbol{c}\_i-\boldsymbol{c}\_j),\$\$
  where:

  - \\\boldsymbol{\Psi}=\text{diag}(\mathbb{E}(U_1),\dots,\mathbb{E}(U_p))\\,

  - \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{ij}=\mathcal{E}(U_i,U_j)\\,
    \\i\neq j\\, with \\\mathcal{E}(U_i,U_j)=\int_0^1 F\_{U_i}^{-1}(t)
    F\_{U_j}^{-1}(t) \\ dt\\,

  - \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{ii}=\mathbb{E}(U_i^2)\\,
    \\i,j=1,\dots,p\\,

  - \\\bullet\\ denotes the Schur (or entrywise) product of matrices.

## Examples

``` r
data(creditcard)
credit_card_int <- creditcard$intData

credit_card_dist<-IMah_dist_pairs(credit_card_int)
```
