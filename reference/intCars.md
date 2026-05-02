# Cars Dataset

This dataset contains interval data of car specifications, including
min-max values. It is composed of 5 variables: Engine Capacity, Top
Speed, Acceleration, Price and Class. The aggregation of the microdata
was done by car model.

## Usage

``` r
data(intCars)
```

## Format

A list with the following components:

- `min_max`:

  A data frame with `27` rows and `9` columns. It contains the lower and
  upper bounds for each variable.

- `intData`:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object with `27` interval-valued observations and `4` variables. The
  variable "Price" was log-transformed into "lnPrice". The microdata are
  not available, thus the default parameters of the latent distributions
  were used assuming a uniform distribution.

## References

This data was retrieved from the `MAINT.Data` package, available at
<https://cran.r-project.org/package=MAINT.Data>.

## Examples

``` r
data(intCars)
head(intCars$min_max)
#> NULL
head(intCars$intData)
#>                  lnPrice                EngCap             Top Speed          Acceleration
#> Alfa145   [10.23301, 10.42216]  [  1370  ,   1910  ]  [  185   ,   211   ]  [  8.3   ,   11.2  ]  
#> Alfa156   [10.63569, 11.03957]  [  1598  ,   2492  ]  [  200   ,   227   ]  [  8.5   ,   10.5  ]  
#> Alfa166   [11.07440, 11.39369]  [  1970  ,   2959  ]  [  204   ,   211   ]  [  9.8   ,    9.9  ]  
#> AudiA3    [10.60237, 11.13951]  [  1595  ,   1781  ]  [  189   ,   238   ]  [  6.8   ,   10.9  ]  
#> AudiA6    [11.13043, 11.85129]  [  1781  ,   4172  ]  [  216   ,   250   ]  [  6.7   ,    9.7  ]  
#> AudiA8    [11.72682, 12.05185]  [  2771  ,   4172  ]  [  232   ,   250   ]  [  5.4   ,   10.1  ]  
```
