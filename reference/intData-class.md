# Interval Data Class

A class to represent interval data.

## Slots

- `Centers`:

  A data frame of centers of the intervals.

- `Ranges`:

  A data frame of ranges of the intervals.

- `LatentParam`:

  A list with the parameters of the latent variables' distribution
  defined according to the `LatentCase`:

  - `"U_id_symmetric"`: The latent variables are identically distributed
    and symmetric, so its parameters are:

    - \\\delta=\mathbb{E}(U^2)/4\\

  - `"U_id"`: The latent variables are identically distributed, so its
    parameters are:

    - \\\delta=\mathbb{E}(U^2)/4\\

    - \\\mathbb{E}(U)\\

  - `"General"`: The latent variables do not have any nice properties,
    so its parameters are:

    - \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{j\ell}=\mathcal{E}(U_j,U\_\ell)\\,
      \\j\neq \ell\\, with \\\mathcal{E}(U_j,U\_\ell)=\int_0^1
      F\_{U_j}^{-1}(t) F\_{U\_\ell}^{-1}(t) \\ dt\\, and
      \\\[\boldsymbol{\mathfrak{E}}\_{UU}\]\_{jj}=\mathbb{E}(U_j^2)\\,
      \\j,\ell=1,\dots,p\\

    - \\\boldsymbol{\Psi}=\text{Diag}(\mathbb{E}(U_1),\dots,\mathbb{E}(U_p))\\

- `LatentCase`:

  A string specifying which of the three scenarios applies to the latent
  variables:

  - `"U_id_symmetric"`: The case where the latent variables are
    identically distributed and symmetric.

  - `"U_id"`: The case where the latent variables are identically
    distributed.

  - `"General"`: The case where the latent variables do not have any
    nice properties.

  Defaults to `"U_id_symmetric"`.

- `LatentDist`:

  A string or vector of strings specifying the distribution(s) of the
  latent variables. If the variables are identically distributed it can
  be one of (`"Unif"`, `"Triang"`, `"TNorm"`, `"InvTri"`, `"Beta"`,
  `"KDE"`, `"Degenerated"`), if not, it is a vector with the
  distribution for each variable.

- `ObsNames`:

  A character vector of observation names.

- `VarNames`:

  A character vector of variable names.

- `NObs`:

  A numeric value indicating the number of observations.

- `NIVar`:

  A numeric value indicating the number of interval variables.

- `NbMicroUnits`:

  An integer vector indicating the number of individual observations
  (microdata) aggregated by interval (macrodata).

## References

Oliveira, M. R., Pinheiro, D., & Oliveira, L. (2025). Location and
association measures for interval-valued data based on Mallows'
distance. arXiv preprint arXiv:2407.05105.
<https://arxiv.org/abs/2407.05105>

Adapted from package `MAINT.Data`
(<https://cran.r-project.org/package=MAINT.Data>).
