# AIDA 0.1.0

* Initial GitHub commit.

## AIDA 0.1.1

* Fix vignette rendering issue.

## AIDA 0.1.2

* Add pre-built vignettes.

## AIDA 0.1.3

* First CRAN submission.
* Minor fixes for CRAN compliance.

## AIDA 0.1.4

* Compress included datasets to reduce package size.

## AIDA 0.1.5

* Missing \value entries added; graphical parameter handling fixed.

## AIDA 0.1.6

* Add `rbind` method for `intData` class.

# AIDA 0.2.0

* Introduced functionality for explainable outlier detection using Shapley values.
* Added functions to compute feature contributions and interaction effects: `int_Shapley()`, `int_Shapley_decomp()`, and `int_Shapley_interaction()`. 
* Added visualization functions for Shapley values and Shapley interaction indices: `barplot_int_Shapley_decomp()`, `barplot_int_Shapley()`, `beeswarm_int_Shapley()`, `plot_int_Shapley_inter()`, and `radarplot_int_Shapley()`.
* Improvements to documentation and usability.
* Added a unit test suite.