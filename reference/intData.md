# Interval Data Constructor

Constructs an interval data object.

## Usage

``` r
intData(
  macrodata,
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
  ObsNames = row.names(macrodata),
  NMicro = integer(0)
)
```

## Arguments

- macrodata:

  A data frame or matrix containing the macrodata.

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

  A list with the parameters of the latent variables. Expects a list
  with a single number if `LatentCase` is `"U_id_symmetric"`, a list of
  two numbers if `LatentCase` is `"U_id"`, and a list of two matrices if
  `LatentCase` is `"General"`.

- LatentCase:

  A string specifying which of the three scenarios applies to the latent
  variables:

  - `"U_id_symmetric"`: The case where the latent variables are
    identically distributed and symmetric.

  - `"U_id"`: The case where the latent variables are identically
    distributed.

  - `"General"`: The case where the latent variables do not have any
    nice properties.

  Defaults to `"U_id_symmetric"`.

- LatentDist:

  A string or vector of strings specifying the distribution(s) of the
  latent variables. If the variables are identically distributed it can
  be one of (`"Unif"`, `"Triang"`, `"TNorm"`, `"InvTri"`, `"Beta"`,
  `"KDE"`, `"Degenerated"`), if not a vector must be provided with the
  distribution for each variable. The default is `"Unif"` if
  `LatentCase="U_id_symmetric"` or if `Umicro` is not provided, and
  `"KDE"` if `LatentCase="General"`.

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

  Latent microdata observations. Needed if `estimate.DistParam` is
  `TRUE` or `LatentDist` is `"KDE"`.

- estimate.DistParam:

  Logical parameter indicating if estimation of the parameters of the
  latent distributions should be performed. Can only be set to TRUE if
  `LatentCase="General"`. The default is `FALSE`.

- VarNames:

  A character vector of variable names.

- ObsNames:

  A character vector of observation names.

- NMicro:

  An integer vector indicating the number of individual observations
  (microdata) aggregated by interval (macrodata).

## Value

An object of class
[`intData`](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md).

## References

Oliveira, M. R., Pinheiro, D., & Oliveira, L. (2025). Location and
association measures for interval-valued data based on Mallows'
distance. arXiv preprint arXiv:2407.05105.
<https://arxiv.org/abs/2407.05105>

Adapted from package `MAINT.Data`
(<https://cran.r-project.org/package=MAINT.Data>).

## Examples

``` r
# Load microdat and macrodata
data(creditcard)
CreditCard_microdata <- creditcard$microdata
CreditCard_min_max <- creditcard$min_max

# Create an intData object using the min_max component of the dataset 
# Assume a continuous uniform distribution for the latent variables 
# This corresponds to LatentCase="U_id_symmetric"
# This is the default setting for the intData class
credit_card_int_unif <- intData(CreditCard_min_max, 
                                Seq = "LbUb_VarbyVar", 
                                VarNames = colnames(CreditCard_microdata)[3:7])
```
