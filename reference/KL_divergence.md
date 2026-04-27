# Kullback-Leibler (KL) Divergence

Computes the Kullback-Leibler (KL) divergence between an estimated
covariance matrix and the ground truth. Assumes normal multivariate
distributions.

## Usage

``` r
KL_divergence(est_cov, ground_truth_cov)
```

## Arguments

- est_cov:

  Estimated covariance matrix.

- ground_truth_cov:

  Ground truth covariance matrix.

## Value

KL divergence between the two matrices.

## Details

The KL divergence between two \\p\\-dimensional Gaussians
\\\mathcal{N}(\boldsymbol{\mu}, \hat{\boldsymbol{\Sigma}})\\ and
\\\mathcal{N}(\boldsymbol{\mu}, \boldsymbol{\Sigma})\\ is given by:
\$\$\dfrac{1}{2}\left(\text{tr}(\boldsymbol{\Sigma}^{-1}\hat{\boldsymbol{\Sigma}}) +
\log\left(\dfrac{\det(\boldsymbol{\Sigma})}{\det(\hat{\boldsymbol{\Sigma}})}\right) -
p\right),\$\$ where \\\hat{\boldsymbol{\Sigma}}\\ and
\\\boldsymbol{\Sigma}\\ are the estimated and ground truth covariance
matrices, respectively.

## References

Yufeng Zhang, Wanwei Liu, Zhenbang Chen, Ji Wang, and Kenli Li. On the
properties of Kullback-Leibler divergence between multivariate gaussian
distributions, 2023. <https://arxiv.org/abs/2102.05485>
