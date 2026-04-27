# Farness Estimation

Estimate farness from a distance vector in order to identify outlier
observations.

## Usage

``` r
farness(dist, cutoff_value = NULL)
```

## Arguments

- dist:

  Vector of distances of each observation.

- cutoff_value:

  Optional cutoff value between 0 and 1 to flag outliers. If provided,
  the function returns both the farness probabilities and the cutoff
  distance value in the original distance scale.

## Value

Farness of each observation. Values between 0 and 1. If `cutoff_value`
is provided, a list with the farness probabilities and the cutoff
distance value in the original distance scale is returned.

## References

J. Raymaekers and P.J. Rousseeuw (2021). Transforming variables to
central normality. Machine Learning.
<https://doi.org/10.1007/s10994-021-05960-5>

Based on the `cellWise` package: Raymaekers J, Rousseeuw P (2023).
*cellWise: Analyzing Data with Cellwise Outliers*. R package version
2.5.3, <https://CRAN.R-project.org/package=cellWise>.

## Examples

``` r
data(creditcard)
credit_card_int <- creditcard$intData

# Compute squared Interval-Mahalanobis distance
z <- rep(1, nrow(credit_card_int))
credit_card_dist<-IMah_dist(credit_card_int,z)

credit_card_farness <- farness(credit_card_dist, 0.9)
```
