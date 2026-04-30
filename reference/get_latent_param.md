# Compute Latent Variables Parameters

Obtain the parameters of the latent variables inherent to the macrodata.

## Usage

``` r
get_latent_param(
  LatentCase = c("U_id_symmetric", "U_id", "General"),
  LatentDist = c("Unif", "Triang", "TNorm", "InvTri", "Beta", "KDE", "Degenerated"),
  TriangParam = 0,
  BetaParam.a = 1,
  BetaParam.b = 1,
  Umicro = NULL,
  p = NULL,
  estimate.DistParam = FALSE
)
```

## Arguments

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

- LatentDist:

  A string or vector of strings specifying the distribution(s) of the
  latent variables. If the variables are identically distributed it can
  be one of
  (`"Unif"`,`"Triang"`,`"TNorm"`,`"InvTri"`,`"Beta"`,`"KDE"`,`"Degenerated"`),
  if not a vector must be provided with the distribution for each
  variable.

- TriangParam:

  Mode of the triangular distribution. If the latent variables are
  identically distributed, it is only necessary to provide a number, if
  not a vector is needed. The default is `0`.

- BetaParam.a:

  Parameter alpha of the Beta distribution. If the latent variables are
  identically distributed, it is only necessary to provide a number, if
  not a vector is needed. The default is `1`.

- BetaParam.b:

  Parameter beta of the Beta distribution. If the latent variables are
  identically distributed, it is only necessary to provide a number, if
  not a vector is needed. The default is `1`.

- Umicro:

  Latent microdata observations. Needed if `LatentDist="KDE"` or
  `estimate.DistParam=TRUE`.

- p:

  Number of variables.

- estimate.DistParam:

  Logical parameter indicating if estimation of the parameters of the
  latent distributions should be performed. Can only be set to TRUE if
  `LatentCase="General"`. The default is `FALSE`.

## Value

A list with the parameters of the latent variables.

## Details

The parameters of the latent variables inherent to the macrodata are
defined according to the `LatentCase`:

- `"U_id_symmetric"`: The latent variables are identically distributed
  and symmetric, so its parameters are:

  - \\\delta=\mathbb{E}(U^2)/4\\

- `"U_id"`: The latent variables are identically distributed, so its
  parameters are:

  - \\\delta=\mathbb{E}(U^2)/4\\

  - \\\mathbb{E}(U)\\

- `"General"`: The latent variables do not have any nice properties, so
  its parameters are:

  - \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{ij}=\mathcal{E}(U_i,U_j)\\,
    \\i\neq j\\, with \\\mathcal{E}(U_i,U_j)=\int_0^1 F\_{U_i}^{-1}(t)
    F\_{U_j}^{-1}(t) \\ dt\\, and
    \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{ii}=\mathbb{E}(U_i^2)\\,
    \\i,j=1,\dots,p\\

  - \\\boldsymbol{\Psi}=\text{Diag}(\mathbb{E}(U_1),\dots,\mathbb{E}(U_p))\\

## References

Oliveira, M. R., Pinheiro, D., & Oliveira, L. (2025). Location and
association measures for interval-valued data based on Mallows'
distance. arXiv preprint arXiv:2407.05105.
<https://arxiv.org/abs/2407.05105>

## Examples

``` r
data(creditcard)
CreditCard_min_max <- creditcard$min_max
CreditCard_microdata <- creditcard$microdata
credit_agrby<-paste(CreditCard_microdata$Name,CreditCard_microdata$Month,sep = "_")
credit_card_U<-get_latent_var(CreditCard_microdata[,3:7], CreditCard_min_max, credit_agrby, 
                              agrlevels = row.names(CreditCard_min_max), Seq="LbUb_VarbyVar")
credit_card_param<-get_latent_param(LatentCase="General",LatentDist="KDE",Umicro=credit_card_U)
```
