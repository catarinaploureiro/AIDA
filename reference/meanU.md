# Compute Mean Latent Variables

Obtain the mean of the latent variables inherent to the macrodata.

## Usage

``` r
meanU(
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

Either a diagonal matrix with the mean of each variable or a value if
the variables are identically distributed.
