# Interval Data Class

A class to represent interval data.

## Slots

- `Centers`:

  A data frame of centers of the intervals.

- `Ranges`:

  A data frame of ranges of the intervals.

- `LatentParam`:

  A list with the parameters of the latent variables.

- `LatentCase`:

  A string specifying which of the three scenarios applies to the latent
  variables:

  - `"General"`: The case where the latent variables do not have any
    nice properties.

  - `"U_id"`: The case where the latent variables are identically
    distributed.

  - `"U_id_symmetric"`: The case where the latent variables are
    identically distributed and symmetric.

  Defaults to `"U_id_symmetric"`.

- `LatentDist`:

  A string or vector of strings specifying the distribution(s) of the
  latent variables. If the variables are identically distributed it can
  be one of
  (`"Unif"`,`"Triang"`,`"TNorm"`,`"InvTri"`,`"Beta"`,`"KDE"`,`"Degenerated"`),
  if not, it is a vector with the distribution for each variable.

- `ObsNames`:

  A character vector of observation names.

- `VarNames`:

  A character vector of variable names.

- `NObs`:

  A numeric value indicating the number of observations.

- `NIVar`:

  A numeric value indicating the number of interval variables.

- `NbMicroUnits`:

  An integer indicating the number of micro units.

## References

Oliveira, M. R., Pinheiro, D., & Oliveira, L. (2025). Location and
association measures for interval-valued data based on Mallows'
distance. arXiv preprint arXiv:2407.05105.
<https://arxiv.org/abs/2407.05105>

Adapted from package `MAINT.Data`
(<https://cran.r-project.org/package=MAINT.Data>).
