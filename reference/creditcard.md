# Credit Card Dataset

This dataset contains interval data of credit card expenses, including
min-max values, centers and ranges, microdata, and an
[intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
object. It is composed of 5 variables: Food, Social, Travel, Gas, and
Clothes. It was aggregated by person-month.

## Usage

``` r
data(creditcard)
```

## Format

A list with the following components:

- `microdata`:

  A data frame with `1000` rows and `7` columns. It contains the
  microdata, with individual measurements of each variable for all
  observations.

- `min_max`:

  A data frame with `36` rows and `10` columns. Each row corresponds to
  a different observation, and each column gives the minimum and maximum
  values for each variable.

- `centers_ranges`:

  A data frame with `36` rows and `10` columns. Each row corresponds to
  the centers and ranges of the interval data.

- `intData`:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object with `36` interval-valued observations and `5` variables,
  constructed assuming the microdata follow symmetric triangular
  distributions.

## References

This data was retrieved from Billard, L. and Diday, E. (2006). Symbolic
Data Analysis: Conceptual Statistics and Data Mining. John Wiley & Sons.
[doi:10.1002/9780470090183](https://doi.org/10.1002/9780470090183) .

## Examples

``` r
data(creditcard)
head(creditcard$min_max)
#>     Food min Food max Social min Social max Travel min Travel max Gas min
#> 1_1    20.81    29.38       9.74      18.86     192.33     205.23   13.01
#> 1_2    21.44    29.18      10.86      18.01     214.98     229.63   16.08
#> 1_3    20.78    29.09      11.19      19.87     183.12     197.17   17.96
#> 1_4    20.82    29.18       4.48      15.15     169.49     185.75   13.83
#> 1_5    21.72    28.48       8.24      18.88     132.71     146.96   13.97
#> 1_6    19.90    28.63       6.88      19.71     134.48     146.11   16.50
#>     Gas max Clothes min Clothes max
#> 1_1   24.42       44.28       53.82
#> 1_2   22.86       40.51       53.57
#> 1_3   27.65       42.97       58.62
#> 1_4   23.73       44.93       55.08
#> 1_5   26.59       64.96       74.60
#> 1_6   24.64       40.91       55.80
head(creditcard$microdata)
#>   Name Month  Food Social Travel   Gas Clothes
#> 1    1     1 25.94  12.38 197.90 20.06   47.09
#> 2    1     1 26.56  15.92 202.06 22.90   45.66
#> 3    1     1 22.41  11.54 200.74 20.57   53.02
#> 4    1     1 29.13  13.80 204.18 21.93   51.69
#> 5    1     1 24.10   9.86 199.57 18.17   48.34
#> 6    1     1 22.18  12.24 200.21 21.14   50.70
head(creditcard$intData)
#>                Food                Social                Travel                   Gas               Clothes
#> 1_1   [ 20.81  ,  29.38  ]  [  9.74  ,  18.86  ]  [ 192.33 ,  205.23 ]  [ 13.01  ,  24.42  ]  [ 44.28  ,  53.82  ]  
#> 1_2   [ 21.44  ,  29.18  ]  [ 10.86  ,  18.01  ]  [ 214.98 ,  229.63 ]  [ 16.08  ,  22.86  ]  [ 40.51  ,  53.57  ]  
#> 1_3   [ 20.78  ,  29.09  ]  [ 11.19  ,  19.87  ]  [ 183.12 ,  197.17 ]  [ 17.96  ,  27.65  ]  [ 42.97  ,  58.62  ]  
#> 1_4   [ 20.82  ,  29.18  ]  [  4.48  ,  15.15  ]  [ 169.49 ,  185.75 ]  [ 13.83  ,  23.73  ]  [ 44.93  ,  55.08  ]  
#> 1_5   [ 21.72  ,  28.48  ]  [  8.24  ,  18.88  ]  [ 132.71 ,  146.96 ]  [ 13.97  ,  26.59  ]  [ 64.96  ,  74.60  ]  
#> 1_6   [ 19.90  ,  28.63  ]  [  6.88  ,  19.71  ]  [ 134.48 ,  146.11 ]  [ 16.50  ,  24.64  ]  [ 40.91  ,  55.80  ]  
```
