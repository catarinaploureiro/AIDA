# Changelog

## AIDA 0.1.0

- Initial GitHub commit.

### AIDA 0.1.1

- Fix vignette rendering issue.

### AIDA 0.1.2

- Add pre-built vignettes.

### AIDA 0.1.3

- First CRAN submission.
- Minor fixes for CRAN compliance.

### AIDA 0.1.4

- Compress included datasets to reduce package size.

### AIDA 0.1.5

- Missing entries added; graphical parameter handling fixed.

### AIDA 0.1.6

- Add `rbind` method for `intData` class.

## AIDA 0.2.0

- Introduced functionality for explainable outlier detection using
  Shapley values.
- Added functions to compute feature contributions and interaction
  effects:
  [`int_Shapley()`](https://catarinaploureiro.github.io/AIDA/reference/int_Shapley.md),
  [`int_Shapley_decomp()`](https://catarinaploureiro.github.io/AIDA/reference/int_Shapley_decomp.md),
  and
  [`int_Shapley_interaction()`](https://catarinaploureiro.github.io/AIDA/reference/int_Shapley_interaction.md).
- Added visualization functions for Shapley values and Shapley
  interaction indices:
  [`barplot_int_Shapley_decomp()`](https://catarinaploureiro.github.io/AIDA/reference/barplot_int_Shapley_decomp.md),
  [`barplot_int_Shapley()`](https://catarinaploureiro.github.io/AIDA/reference/barplot_int_Shapley.md),
  [`beeswarm_int_Shapley()`](https://catarinaploureiro.github.io/AIDA/reference/beeswarm_int_Shapley.md),
  [`plot_int_Shapley_inter()`](https://catarinaploureiro.github.io/AIDA/reference/plot_int_Shapley_inter.md),
  and
  [`radarplot_int_Shapley()`](https://catarinaploureiro.github.io/AIDA/reference/radarplot_int_Shapley.md).
- Improvements to documentation and usability.
- Added a unit test suite.
- Removed the dependency on the package `geigen`.
