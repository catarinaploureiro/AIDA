# Plot Method for Two [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md) Objects

Plots one
[intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
object against another, with options to visualize the intervals as
crosses or rectangles.

Plots a single
[intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
object, either in a vertical or horizontal layout.

## Usage

``` r
# S4 method for class 'intData,intData'
plot(
  x,
  y,
  type = c("crosses", "rectangles", "crosses2"),
  append = FALSE,
  palette = rainbow(x@NObs),
  ...
)

# S4 method for class 'intData,missing'
plot(
  x,
  casen = NULL,
  layout = c("vertical", "horizontal"),
  append = FALSE,
  ...
)
```

## Arguments

- x:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object.

- y:

  An
  [intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
  object to plot on the y-axis.

- type:

  The type of plot to generate: "crosses" or "rectangles" or "crosses2".
  Default is "crosses".

- append:

  Logical, if `TRUE`, the plot is added to the current plot.

- palette:

  A vector with colors for each observation.

- ...:

  Additional graphical parameters.

- casen:

  A vector specifying the case numbers to plot. Default is `NULL`.

- layout:

  The layout of the plot: "vertical" or "horizontal".

## Value

A plot showing the relationship between the two
[intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
objects.

A plot showing the intervals of the
[intData](https://catarinaploureiro.github.io/AIDA/reference/intData-class.md)
object.
