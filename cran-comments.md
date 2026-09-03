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

* Fixed handling of degenerate constant latent samples when computing KDE-based latent moments, improving compatibility with `kde1d 1.2.0` and later.
* Added options and compatibility improvements to several functions.
* Simplified the column names of the `entrecampos_air_quality` dataset.
* Improved documentation.

## Notes

* The word "DAta" in the package title is intentionally stylized and not a typo.

## Downstream dependencies

None