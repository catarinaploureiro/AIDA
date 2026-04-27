# Compute Cal.E Latent Variables

Computes \\\boldsymbol{\mathfrak{E}}\_{UU}\\ for the latent variables
inherent to the macrodata.

## Usage

``` r
cal.E.UU(
  LatentDist = c("Unif", "Triang", "TNorm", "InvTri", "Beta", "KDE", "Degenerated"),
  TriangParam = 0,
  BetaParam.a = 1,
  BetaParam.b = 1,
  Umicro = NULL,
  p = NULL
)
```

## Arguments

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

  Latent microdata observations. Needed if `LatentDist="KDE"`.

- p:

  Number of variables.

## Value

A \\p\times p\\ matrix.

## Details

The matrix \\\boldsymbol{\mathfrak{E}}\_{UU}\\ is defined as follows:

- \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{ij}=\mathcal{E}(U_i,U_j)\\ ,
  \\i\neq j\\, with \\\mathcal{E}(U_i,U_j)=\int_0^1 F\_{U_i}^{-1}(t)
  F\_{U_j}^{-1}(t) \\ dt\\

- \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{ii}=\mathbb{E}(U_i^2)\\,
  \\i,j=1,\dots,p\\.
