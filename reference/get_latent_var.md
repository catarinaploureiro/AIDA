# Compute Latent Variables

Obtain the latent variables inherent to the macrodata.

## Usage

``` r
get_latent_var(
  microdata,
  macrodata,
  agrby,
  agrlevels,
  Seq = c("AllLb_AllUb", "AllCen_AllRng", "LbUb_VarbyVar", "CenRng_VarbyVar")
)
```

## Arguments

- microdata:

  A matrix containing the microdata.

- macrodata:

  A data frame, matrix or
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object containing the macrodata/interval data.

- agrby:

  A factor used to specify the grouping of the microdata.

- agrlevels:

  The categories/levels on which the microdata was aggregated.

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

## Value

A matrix with the same size as the microdata.

## Details

The latent variables, \\U\_{ij}\\, are defined according to the
following model:

Let \\X_j=(C_j,R_j)^\top=\left\[C_j-\dfrac{R_j}{2},
C_j+\dfrac{R_j}{2}\right\]\\ represent the **macrodata** and
\$\$V\_{ij}=C_j+U\_{ij}\dfrac{R_j}{2},\quad j=1,\dots,p,\\
i=1,\dots,m_j\$\$ the **microdata** with \\U\_{ij}\\ being random
variables with support on \\\[-1,1\]\\, uncorrelated with \\(C_j,R_j)\\.

## References

Oliveira, M.R., Azeitona, M., Pacheco, A., Valadas, R.. Association
measures for interval variables. Advances in Data Analysis and
Classification 16, 491–520 (2022).
<https://doi.org/10.1007/s11634-021-00445-8>

## Examples

``` r
data(creditcard)
CreditCard_min_max <- creditcard$min_max
CreditCard_microdata <- creditcard$microdata
credit_agrby<-paste(CreditCard_microdata$Name,CreditCard_microdata$Month,sep = "_")
credit_card_U<-get_latent_var(CreditCard_microdata[,3:7], CreditCard_min_max, credit_agrby, 
                              agrlevels = row.names(CreditCard_min_max), Seq="LbUb_VarbyVar")
```
