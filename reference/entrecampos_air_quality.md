# Entrecampos Air Quality Dataset

This dataset contains interval data of air pollutants' concentrations,
including min-max values and microdata. This air quality dataset was
obtained from a monitoring station in Entrecampos, Lisbon. It is
composed of 9 pollutants' concentration measures in µg/m3 during the
years 2019, 2020, and 2021: sulphur dioxide (SO2), particles \< 10µm,
ozone (O3), nitrogen dioxide (NO2), carbon monoxide (CO), benzene
(C6H6), particles \< 2.5µm, nitrogen oxides (NOx), and nitrogen monoxide
(NO). For the `microdata_transformed`, `min_max`, and `intData`, the
pollutant "benzene" was removed due to a high number of missing values.
The aggregation of the microdata was done by day.

## Usage

``` r
data(entrecampos_air_quality)
```

## Format

A list with the following components:

- `microdata_raw`:

  A data frame with `26304` rows and `11` columns. It contains the raw
  microdata, with individual measurements of each variable for all
  observations.

- `microdata_transformed`:

  A data frame with `26304` rows and `10` columns. It contains the
  microdata, with individual measurements of each variable for all
  observations. Logarithmic transformations were applied to all
  variables and interpolation to deal with missing values.

- `min_max`:

  A data frame with `1096` rows and `17` columns. Each row corresponds
  to a different observation, and each column gives the minimum and
  maximum values for each variable. The first column corresponds to the
  day, the next 8 to the minimum and the last 8 to the maximum.

- `intData`:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object, constructed using KDE for estimating the parameters of the
  latent distributions.

## References

This data was retrieved from the Portuguese Environment Agency database
available at <https://qualar.apambiente.pt/>.

## Examples

``` r
data(entrecampos_air_quality)
head(entrecampos_air_quality$microdata_raw)
#>             Timestamp Sulphur Dioxide (µg/m3) Particles < 10 µm (µg/m3)
#> 1 2019-01-01 00:00:00                     1.8                      59.4
#> 2 2019-01-01 01:00:00                     1.2                      63.9
#> 3 2019-01-01 02:00:00                     2.1                      65.5
#> 4 2019-01-01 03:00:00                     2.0                      75.1
#> 5 2019-01-01 04:00:00                     1.7                      73.6
#> 6 2019-01-01 05:00:00                     1.6                      64.2
#>   Ozone (µg/m3) Nitrogen Dioxide (µg/m3) Carbon Monoxide (µg/m3)
#> 1             2                       NA                    1050
#> 2             2                       NA                    1227
#> 3             3                       NA                    1325
#> 4             2                       NA                    1340
#> 5             2                       NA                    1070
#> 6             2                       NA                     931
#>   Benzene (µg/m3) Particles < 2.5 µm (µg/m3) Nitrogen Oxides (µg/m3)
#> 1             4.7                       50.5                      NA
#> 2             5.1                       57.6                      NA
#> 3             5.6                       58.4                      NA
#> 4             6.0                       63.0                      NA
#> 5             5.9                       61.9                      NA
#> 6             4.5                       54.9                      NA
#>   Nitrogen Monoxide (µg/m3)        Day
#> 1                        NA 2019-01-01
#> 2                        NA 2019-01-01
#> 3                        NA 2019-01-01
#> 4                        NA 2019-01-01
#> 5                        NA 2019-01-01
#> 6                        NA 2019-01-01
head(entrecampos_air_quality$microdata_transformed)
#>             Timestamp        Day Carbon Monoxide (µg/m3)
#> 1 2019-01-01 00:00:00 2019-01-01                3.021603
#> 2 2019-01-01 01:00:00 2019-01-01                3.089198
#> 3 2019-01-01 02:00:00 2019-01-01                3.122544
#> 4 2019-01-01 03:00:00 2019-01-01                3.127429
#> 5 2019-01-01 04:00:00 2019-01-01                3.029789
#> 6 2019-01-01 05:00:00 2019-01-01                2.969416
#>   Nitrogen Dioxide (µg/m3) Nitrogen Monoxide (µg/m3) Nitrogen Oxides (µg/m3)
#> 1                       NA                        NA                      NA
#> 2                       NA                        NA                      NA
#> 3                       NA                        NA                      NA
#> 4                       NA                        NA                      NA
#> 5                       NA                        NA                      NA
#> 6                       NA                        NA                      NA
#>   Ozone (µg/m3) Particles < 10 µm (µg/m3) Particles < 2.5 µm (µg/m3)
#> 1     0.4771213                  1.781037                   1.711807
#> 2     0.4771213                  1.812245                   1.767898
#> 3     0.6020600                  1.822822                   1.773786
#> 4     0.4771213                  1.881385                   1.806180
#> 5     0.4771213                  1.872739                   1.798651
#> 6     0.4771213                  1.814248                   1.747412
#>   Sulphur Dioxide (µg/m3)
#> 1               0.4471580
#> 2               0.3424227
#> 3               0.4913617
#> 4               0.4771213
#> 5               0.4313638
#> 6               0.4149733
head(entrecampos_air_quality$min_max)
#>          Day Min. Carbon Monoxide (µg/m3) Min. Nitrogen Dioxide (µg/m3)
#> 1 2019-01-01                     2.501059                      1.705008
#> 2 2019-01-02                     2.485721                      1.705008
#> 3 2019-01-03                     2.432969                      1.705008
#> 4 2019-01-04                     2.397940                      1.705008
#> 5 2019-01-05                     2.428135                      1.705008
#> 6 2019-01-06                     2.770852                      1.705008
#>   Min. Nitrogen Monoxide (µg/m3) Min. Nitrogen Oxides (µg/m3)
#> 1                       1.133539                     1.850033
#> 2                       1.133539                     1.850033
#> 3                       1.133539                     1.850033
#> 4                       1.133539                     1.850033
#> 5                       1.133539                     1.850033
#> 6                       1.133539                     1.850033
#>   Min. Ozone (µg/m3) Min. Particles < 10 µm (µg/m3)
#> 1          0.4771213                       1.255273
#> 2          0.4771213                       1.457882
#> 3          0.4771213                       1.235528
#> 4          0.4771213                       1.287802
#> 5          0.3010300                       1.322219
#> 6          0.4771213                       1.603144
#>   Min. Particles < 2.5 µm (µg/m3) Min. Sulphur Dioxide (µg/m3)
#> 1                        1.204120                      0.00000
#> 2                        1.204120                      0.20412
#> 3                        1.235528                      0.00000
#> 4                        1.252853                      0.00000
#> 5                        1.262451                      0.00000
#> 6                        1.542825                      0.00000
#>   Max. Carbon Monoxide (µg/m3) Max. Nitrogen Dioxide (µg/m3)
#> 1                     3.127429                      2.069947
#> 2                     3.114944                      2.066073
#> 3                     3.191171                      2.060975
#> 4                     3.028571                      2.058084
#> 5                     3.069298                      2.068539
#> 6                     3.155640                      2.086712
#>   Max. Nitrogen Monoxide (µg/m3) Max. Nitrogen Oxides (µg/m3)
#> 1                       2.223975                     2.592285
#> 2                       2.208498                     2.581509
#> 3                       2.197570                     2.572845
#> 4                       2.188447                     2.567192
#> 5                       2.221703                     2.592849
#> 6                       2.264924                     2.626779
#>   Max. Ozone (µg/m3) Max. Particles < 10 µm (µg/m3)
#> 1           1.623249                       1.881385
#> 2           1.740363                       1.745855
#> 3           1.556303                       1.824776
#> 4           1.662758                       1.744293
#> 5           1.740363                       1.778874
#> 6           1.462398                       1.898725
#>   Max. Particles < 2.5 µm (µg/m3) Max. Sulphur Dioxide (µg/m3)
#> 1                        1.806180                    0.4913617
#> 2                        1.572872                    0.6720979
#> 3                        1.729974                    0.5682017
#> 4                        1.600973                    0.6434527
#> 5                        1.716838                    0.6334685
#> 6                        1.826075                    0.8388491
head(entrecampos_air_quality$intData)
#>                  Carbon Monoxide       Nitrogen Dioxide      Nitrogen Monoxide        Nitrogen Oxides                  Ozone        Particles <10µm       Particles <2.5µm        Sulphur Dioxide
#> 2019-01-01   [2.501059, 3.127429]  [1.705008, 2.069947]  [1.133539, 2.223975]  [1.850033, 2.592285]  [0.4771213, 1.623249]  [1.255273, 1.881385]  [1.204120, 1.806180]  [0.00000 , 0.4913617]  
#> 2019-01-02   [2.485721, 3.114944]  [1.705008, 2.066073]  [1.133539, 2.208498]  [1.850033, 2.581509]  [0.4771213, 1.740363]  [1.457882, 1.745855]  [1.204120, 1.572872]  [0.20412 , 0.6720979]  
#> 2019-01-03   [2.432969, 3.191171]  [1.705008, 2.060975]  [1.133539, 2.197570]  [1.850033, 2.572845]  [0.4771213, 1.556303]  [1.235528, 1.824776]  [1.235528, 1.729974]  [0.00000 , 0.5682017]  
#> 2019-01-04   [2.397940, 3.028571]  [1.705008, 2.058084]  [1.133539, 2.188447]  [1.850033, 2.567192]  [0.4771213, 1.662758]  [1.287802, 1.744293]  [1.252853, 1.600973]  [0.00000 , 0.6434527]  
#> 2019-01-05   [2.428135, 3.069298]  [1.705008, 2.068539]  [1.133539, 2.221703]  [1.850033, 2.592849]  [0.3010300, 1.740363]  [1.322219, 1.778874]  [1.262451, 1.716838]  [0.00000 , 0.6334685]  
#> 2019-01-06   [2.770852, 3.155640]  [1.705008, 2.086712]  [1.133539, 2.264924]  [1.850033, 2.626779]  [0.4771213, 1.462398]  [1.603144, 1.898725]  [1.542825, 1.826075]  [0.00000 , 0.8388491]  
```
