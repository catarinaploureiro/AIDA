# Sample Interval-valued Covariance

Calculate the interval-valued covariance matrix in function of z

## Usage

``` r
int_cov_z(z, data)
```

## Arguments

- z:

  A vector of 0 and 1, indicating which observations should be
  considered for the calculation

- data:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the macrodata/interval data

## Value

The symbolic covariance matrix

## Details

Let \\\boldsymbol{z}\in\\0,1\\^n\\ be a vector indicating which \\m\\
observations are “active”. This function calculates the sample
interval-valued covariance matrix in function of \\\boldsymbol{z}\\:
\\\boldsymbol{S}\_B(\boldsymbol{z})\\. Let \\\boldsymbol{C}\\,
\\\boldsymbol{R}\\ be the matrices of centers and ranges, respectively.
Additionally, set:
\$\$\overline{\boldsymbol{c}}\_B(\boldsymbol{z})=\dfrac{1}{m}\boldsymbol{C}^{\top}\boldsymbol{z},
\qquad
\overline{\boldsymbol{r}}\_B(\boldsymbol{z})=\dfrac{1}{m}\boldsymbol{R}^{\top}\boldsymbol{z}.\$\$
The sample interval-valued covariance matrix is obtained according to
the `LatentCase`:

- `"U_id_symmetric"`: The latent variables are identically distributed
  and symmetric:
  \$\$\boldsymbol{S}\_B(\boldsymbol{z})=\left(\dfrac{1}{m}\sum\limits\_{h=1}^{n}z\_{h}\boldsymbol{c}\_{h}\boldsymbol{c}\_{h}^{\top}\right)-\overline{\boldsymbol{c}}\_B(\boldsymbol{z})\overline{\boldsymbol{c}}\_B(\boldsymbol{z})^\top+\left(\dfrac{\delta}{m}\sum\limits\_{h=1}^{n}z\_{h}\boldsymbol{r}\_{h}\boldsymbol{r}\_{h}^{\top}\right)-\delta\overline{\boldsymbol{r}}\_B(\boldsymbol{z})\overline{\boldsymbol{r}}\_B(\boldsymbol{z})^\top,\$\$
  where \\\delta=\mathbb{E}(U^2)/4\\ is the parameter of the latent
  variables.

- `"U_id"`: The latent variables are identically distributed:
  \$\$\boldsymbol{S}\_B(\boldsymbol{z})=\left(\dfrac{1}{m}\sum\limits\_{h=1}^{n}z\_{h}\boldsymbol{c}\_{h}\boldsymbol{c}\_{h}^{\top}\right)-\overline{\boldsymbol{c}}\_B(\boldsymbol{z})\overline{\boldsymbol{c}}\_B(\boldsymbol{z})^\top+\left(\dfrac{\delta}{m}\sum\limits\_{h=1}^{n}z\_{h}\boldsymbol{r}\_{h}\boldsymbol{r}\_{h}^{\top}\right)-\delta\overline{\boldsymbol{r}}\_B(\boldsymbol{z})\overline{\boldsymbol{r}}\_B(\boldsymbol{z})^\top\\
  +\left(\dfrac{\mathbb{E}(U)}{2m}\sum\limits\_{h=1}^{n}z\_{h}\boldsymbol{c}\_{h}\boldsymbol{r}\_{h}^{\top}\right)-\dfrac{\mathbb{E}(U)}{2}\overline{\boldsymbol{c}}\_B(\boldsymbol{z})\overline{\boldsymbol{r}}\_B(\boldsymbol{z})^\top+\left(\dfrac{\mathbb{E}(U)}{2m}\sum\limits\_{h=1}^{n}z\_{h}\boldsymbol{r}\_{h}\boldsymbol{c}\_{h}^{\top}\right)-\dfrac{\mathbb{E}(U)}{2}\overline{\boldsymbol{r}}\_B(\boldsymbol{z})\overline{\boldsymbol{c}}\_B(\boldsymbol{z})^\top,\$\$
  where \\\delta=\mathbb{E}(U^2)/4\\ and \\\mathbb{E}(U)\\ are the
  parameters of the latent variables.

- `"General"`: The latent variables do not have any nice properties:
  \$\$\boldsymbol{S}\_B(\boldsymbol{z})=\left(\dfrac{1}{m}\sum\limits\_{h=1}^{n}z\_{h}\boldsymbol{c}\_{h}\boldsymbol{c}\_{h}^{\top}\right)-\overline{\boldsymbol{c}}\_B(\boldsymbol{z})\overline{\boldsymbol{c}}\_B(\boldsymbol{z})^\top+\left(\dfrac{1}{4m}\boldsymbol{\mathfrak{E}}\_{UU}\bullet\sum\limits\_{h=1}^{n}z\_{h}\boldsymbol{r}\_{h}\boldsymbol{r}\_{h}^{\top}\right)-\dfrac{1}{4}\boldsymbol{\mathfrak{E}}\_{UU}\bullet\left\[\overline{\boldsymbol{r}}\_B(\boldsymbol{z})\overline{\boldsymbol{r}}\_B(\boldsymbol{z})^\top\right\]\\
  +\left(\dfrac{1}{2m}\sum\limits\_{h=1}^{n}z\_{h}\boldsymbol{c}\_{h}\boldsymbol{r}\_{h}^{\top}\right)\boldsymbol{\Psi}-\dfrac{1}{2}\overline{\boldsymbol{c}}\_B(\boldsymbol{z})\overline{\boldsymbol{r}}\_B(\boldsymbol{z})^\top\boldsymbol{\Psi}+\boldsymbol{\Psi}\left(\dfrac{1}{2m}\sum\limits\_{h=1}^{n}z\_{h}\boldsymbol{r}\_{h}\boldsymbol{c}\_{h}^{\top}\right)-\dfrac{1}{2}\boldsymbol{\Psi}\overline{\boldsymbol{r}}\_B(\boldsymbol{z})\overline{\boldsymbol{c}}\_B(\boldsymbol{z})^\top,\$\$
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

z <- rep(1, nrow(credit_card_int))
credit_card_cov<-int_cov_z(z,credit_card_int)
```
