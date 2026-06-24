## Test environments

* Local R installation:
  - R version: 4.6.0
  - OS: Windows 11

* GitHub Actions (R CMD check via r-lib/actions):
  - Windows Server (latest release)
  - macOS (latest release)
  - Ubuntu (latest release)
  - Ubuntu (oldrel-1)
  - Ubuntu (devel)

* win-builder (R-devel, Windows Server 2022)

* rhub::rhub_check():
  - Linux Ubuntu (R-devel)
  - Fedora (R-devel)
  - Windows (R-devel)
  - macOS (R-devel)

## R CMD check results

0 errors | 0 warnings | 0 note

## Changes in this version

* Introduced new functionality for explainable outlier detection based on Shapley values.
* Added several plotting functions to visualize Shapley values and interaction indices.
* Added `rbind` method for `intData` class.
* Improvements to documentation and usability.
* Introduced a unit test suite to improve package reliability.
* Removed the dependency on the package `geigen`, which is scheduled for archival on CRAN.

## Notes

* The word "DAta" in the package title is intentionally stylized and not a typo.

## Downstream dependencies

None