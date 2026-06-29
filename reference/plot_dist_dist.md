# Distance-Distance plot for interval-valued data.

Distance-Distance plot for interval-valued data.

## Usage

``` r
plot_dist_dist(
  class_dist,
  class_cutoff = NULL,
  class_cutoff_label = NULL,
  rob_dist,
  rob_cutoff = NULL,
  rob_cutoff_label = NULL,
  obs_names = NULL,
  ggplotly = FALSE,
  color_class = NULL,
  color_label = NULL,
  palette = NULL,
  shape_class = NULL,
  shape_label = NULL,
  label_obs = NULL
)
```

## Arguments

- class_dist:

  A numeric vector containing the classical distances for each
  observation.

- class_cutoff:

  Numeric. The cutoff value for the classical distances.

- class_cutoff_label:

  Character. Label for the classical cutoff. If NULL (default), no
  legend for the classical cutoff is shown.

- rob_dist:

  A numeric vector containing the robust distances for each observation.

- rob_cutoff:

  Numeric. The cutoff value for the robust distances.

- rob_cutoff_label:

  Character. Label for the robust cutoff. If NULL (default), no legend
  for the robust cutoff is shown.

- obs_names:

  A character vector containing the names of the observations. If NULL
  (default), the names are taken from the names of class_dist.

- ggplotly:

  Logical. If `TRUE` (default), the plot is converted to an interactive
  [plotly](https://rdrr.io/pkg/plotly/man/plotly.html) object.

- color_class:

  A vector indicating the color class of each observation. If NULL
  (default), all points have the same color.

- color_label:

  Character. Label for the color class. If NULL (default), no legend for
  the color class is shown.

- palette:

  A vector with colors for each color class. If NULL (default), default
  [ggplot2](https://ggplot2.tidyverse.org/reference/ggplot2-package.html)
  colors are used.

- shape_class:

  A vector indicating the shape class of each observation. If NULL
  (default), all points have the same shape.

- shape_label:

  Character. Label for the shape class. If NULL (default), no legend for
  the shape class is shown.

- label_obs:

  A vector with the names of the observations to be labeled in the plot
  when `ggplotly = FALSE`. Default is NULL.

## Value

Returns a Distance-Distance plot that displays the classical distances
against the robust distances for each observation, highlighting
outliers.

## Examples

``` r
# Create intData object
data(creditcard)
credit_card_int <- creditcard$intData

# Compute robust distances using IMCD estimates of mean and covariance
credit_card_dist <- IMah_dist(credit_card_int)

# Detect outliers using farness cutoff
credit_card_outliers <- int_outliers(credit_card_dist, 
                                     cutoff = "farness", 
                                     cutoff_lvl = 0.9)

# Compute classical distances and outliers
class_dist <- IMah_dist(credit_card_int, z = rep(1,credit_card_int@NObs))
class_outliers <- int_outliers(class_dist, 
                               cutoff = "chi-squared", 
                               p = credit_card_int@NIVar)

# Create a vector indicating if the observations are outliers or inliers 
# based on the robust distance outlier detection
credit_card_is_outliers <- as.character(credit_card_outliers$is_outlier)
credit_card_is_outliers[credit_card_outliers$is_outlier] <- "Outlier"
credit_card_is_outliers[!credit_card_outliers$is_outlier] <- "Inlier"

# Plot Distance-Distance plot 
plot_dist_dist(class_dist, 
               class_cutoff = class_outliers$cutoff_value, 
               class_cutoff_label = "0.975 chi-squared",
               rob_dist = credit_card_dist, 
               rob_cutoff = credit_card_outliers$cutoff_value, 
               rob_cutoff_label = "0.9 farness",
               color_class = credit_card_is_outliers, 
               palette = c("grey50", "red"))
```
