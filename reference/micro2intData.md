# Aggregate Microdata into Interval-Valued Data

Aggregates microdata from a data frame into interval-valued data using
various criteria and latent distribution settings.

## Usage

``` r
micro2intData(
  MicDtDF,
  agrby,
  agrcrt = "minmax",
  LatentParam = NULL,
  LatentCase = c("U_id_symmetric", "U_id", "General"),
  LatentDist = c("Unif", "Triang", "TNorm", "InvTri", "Beta", "KDE", "Degenerated"),
  TriangParam = 0,
  BetaParam.a = 1,
  BetaParam.b = 1,
  estimate.DistParam = FALSE
)
```

## Arguments

- MicDtDF:

  A data frame containing the microdata. All columns should be numeric.

- agrby:

  A factor used to specify the grouping of the microdata for
  aggregation.

- agrcrt:

  A string or numeric vector of length 2 specifying the aggregation
  criterion. The default is `"minmax"`, which takes the minimum and
  maximum values for each variable. If a numeric vector is provided, it
  should specify the lower and upper percentiles for aggregation (e.g.,
  `c(0.05, 0.95)`).

- LatentParam:

  Optional latent parameter used for certain types of latent
  distributions.

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
  variable. The default is `"KDE"` if `LatentCase="General"`.

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

- estimate.DistParam:

  Logical parameter indicating if estimation of the parameters of the
  latent distributions should be performed. Can only be set to TRUE if
  `LatentCase="General"`. The default is `FALSE`.

## Value

An
[intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
object containing the aggregated interval-valued data, or `NULL` if all
units lead to degenerate intervals.

## Details

This function processes a data frame of microdata and aggregates it into
interval-valued data according to the specified grouping factor and
aggregation criteria. It can handle different latent distribution cases
and parameter settings.

If some rows contain invalid (non-finite or missing) values, those rows
are removed before aggregation. If all rows in the resulting
interval-valued data are degenerate (i.e., the lower bound equals the
upper bound), the function will return `NULL`.

## References

Adapted from package `MAINT.Data`
(<https://cran.r-project.org/package=MAINT.Data>).

## Examples

``` r
data(creditcard)
CreditCard_microdata <- creditcard$microdata
credit_agrby<-factor(paste(CreditCard_microdata$Name,CreditCard_microdata$Month,sep = "_"))
credit_agr<-micro2intData(CreditCard_microdata[,3:7],credit_agrby,LatentCase = "General")
```
