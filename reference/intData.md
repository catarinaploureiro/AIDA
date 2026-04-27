# Interval Data Constructor

Constructs an interval data object.

## Usage

``` r
intData(
  Data,
  Seq = c("AllLb_AllUb", "AllCen_AllRng", "LbUb_VarbyVar", "CenRng_VarbyVar"),
  LatentParam = NULL,
  LatentCase = c("U_id_symmetric", "U_id", "General"),
  LatentDist = c("Unif", "Triang", "TNorm", "InvTri", "Beta", "KDE", "Degenerated"),
  TriangParam = 0,
  BetaParam.a = 1,
  BetaParam.b = 1,
  Umicro = NULL,
  estimate.DistParam = FALSE,
  VarNames = NULL,
  ObsNames = row.names(Data),
  NbMicroUnits = integer(0)
)
```

## Arguments

- Data:

  A data frame or matrix containing the data.

- Seq:

  Format of macrodata if it is a data frame or matrix. Available options
  are:

  - `"AllLb_AllUb"`: All lower bounds followed by all upper bounds, in
    the same variable order.

  - `"AllCen_AllRng"`: All Centers followed by all Ranges, in the same
    variable order.

  - `"LbUb_VarbyVar"`: Lower bounds followed by upper bounds, variable
    by variable.

  - `"CenRng_VarbyVar"`: Centers followed by Ranges, variable by
    variable.

- LatentParam:

  A list with the parameters of the latent variables.

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

- estimate.DistParam:

  Logical parameter indicating if estimation of the parameters of the
  latent distributions should be performed. Can only be set to TRUE if
  `LatentCase="General"`. The default is `FALSE`.

- VarNames:

  A character vector of variable names.

- ObsNames:

  A character vector of observation names.

- NbMicroUnits:

  An integer specifying the number of micro units.

## Value

An object of class
[intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md).

## References

Oliveira, M. R., Pinheiro, D., & Oliveira, L. (2025). Location and
association measures for interval-valued data based on Mallows'
distance. arXiv preprint arXiv:2407.05105.
<https://arxiv.org/abs/2407.05105>

Adapted from package `MAINT.Data`
(<https://cran.r-project.org/package=MAINT.Data>).
