library(testthat)

setup_plot_data <- function() {
  Data <- data.frame(
    L1 = c(1, 2, 3, 4, 5, 6), U1 = c(3, 4, 5, 6, 7, 8),
    L2 = c(0, 1, 0, -1, -1, 1), U2 = c(2, 3, 3, 2, 3, 2)
  )
  intData(Data, Seq = "LbUb_VarbyVar", VarNames = c("X", "Y"),
          LatentParam = list(0.25), LatentCase = "U_id_symmetric", LatentDist = "Unif")
}

with_null_device <- function(code) {
  pdf(file = tempfile(fileext = ".pdf"))
  on.exit(dev.off(), add = TRUE)
  force(code)
}

test_that("SYMB.biplot works for all supported types", {
  obj <- setup_plot_data()
  expect_error(with_null_device(SYMB.biplot(obj[, 1:2])), NA)
  expect_error(with_null_device(SYMB.biplot(obj[, 1:2], type = "crosses")), NA)
  expect_error(with_null_device(SYMB.biplot(obj[, 1:2], type = "crosses2")), NA)
})

test_that("SYMB.biplot highlights outliers without error", {
  obj <- setup_plot_data()
  outliers <- c(TRUE, FALSE, TRUE)
  expect_error(with_null_device(SYMB.biplot(obj[, 1:2], is_outlier = outliers)), NA)
})

test_that("SYMB.pairs.panels works with and without corr", {
  obj <- setup_plot_data()
  cov_mat <- int_cov(obj)
  corr_mat <- cov2cor(cov_mat)

  expect_error(with_null_device(SYMB.pairs.panels(obj, type = "rectangles")), NA)
  expect_error(with_null_device(SYMB.pairs.panels(obj, type = "crosses", corr = corr_mat)), NA)
})

test_that("SYMB.biplot and SYMB.pairs.panels validate intData input", {
  expect_error(SYMB.biplot(mtcars), "Argument data is not an object of class intData")
  expect_error(SYMB.pairs.panels(mtcars), "Argument data is not an object of class intData")
})

test_that("SYMB.pairs.panels supports crosses2 and corr matrix", {
  obj <- setup_plot_data()
  cov_mat <- int_cov(obj)
  corr_mat <- cov2cor(cov_mat)

  expect_error(with_null_device(SYMB.pairs.panels(obj, type = "crosses2", corr = corr_mat)), NA)
})

test_that("plot_dist_dist returns a ggplot object when ggplotly is FALSE", {
  testthat::skip_if_not_installed("ggplot2")
  class_dist <- c(1, 2, 3)
  rob_dist <- c(1, 4, 9)

  res <- plot_dist_dist(class_dist, rob_dist = rob_dist, ggplotly = FALSE)

  expect_s3_class(res, "ggplot")
})

test_that("plot_dist_dist errors on mismatched lengths", {
  testthat::skip_if_not_installed("ggplot2")
  class_dist <- c(1, 2, 3)
  rob_dist <- c(1, 4, 9)

  expect_error(plot_dist_dist(class_dist, rob_dist = rob_dist, color_class = c("a", "b")), "must match length")
  expect_error(plot_dist_dist(class_dist, rob_dist = rob_dist, shape_class = c("a", "b")), "must match length")
  expect_error(plot_dist_dist(class_dist, rob_dist = c(1, 4)), "`class_dist` and `rob_dist` must match in length")
})

test_that("plot_dist_dist supports label_obs and cutoff lines", {
  testthat::skip_if_not_installed("ggplot2")
  class_dist <- c(1, 2, 3)
  rob_dist <- c(1, 4, 9)
  obs_names <- c("one", "two", "three")

  res <- plot_dist_dist(
    class_dist,
    rob_dist = rob_dist,
    obs_names = obs_names,
    ggplotly = FALSE,
    label_obs = c("one", "three"),
    class_cutoff = 2,
    rob_cutoff = 5,
    color_class = c("a", "b", "a"),
    palette = c("red", "blue")
  )

  expect_s3_class(res, "ggplot")
  expect_true(any(vapply(res$layers, function(x) class(x$geom)[1] %in% c("GeomVline", "GeomHline"), logical(1))))
})

test_that("plot_interval_dist returns ggplot and supports label_obs", {
  testthat::skip_if_not_installed("ggplot2")
  dist <- c(1, 2, 3)
  obs <- c("a", "b", "c")

  res <- plot_interval_dist(dist, obs_names = obs, label_obs = "b")
  expect_s3_class(res, "ggplot")
  expect_true(any(vapply(res$layers, function(x) inherits(x$geom, "GeomTextRepel"), logical(1))))
})

test_that("plot_interval_dist returns plotly", {
  testthat::skip_if_not_installed("plotly")
  class_dist <- c(1, 2, 3)
  rob_dist <- c(1, 4, 9)
  res <- plot_dist_dist(class_dist, rob_dist = rob_dist, ggplotly = TRUE)

  expect_s3_class(res, "plotly")
})

test_that("plot_dist_dist supports color_class, shape_class, cutoffs, and palette", {
  testthat::skip_if_not_installed("ggplot2")
  class_dist <- c(1, 2, 3)
  rob_dist <- c(1, 4, 9)

  res <- plot_dist_dist(
    class_dist,
    rob_dist = rob_dist,
    color_class = c("a", "a", "b"),
    shape_class = c("x", "y", "x"),
    class_cutoff = 2,
    rob_cutoff = 5,
    color_label = "Group",
    shape_label = "Shape",
    palette = c("a" = "purple", "b" = "orange"),
    ggplotly = FALSE
  )

  expect_s3_class(res, "ggplot")
  expect_true("GeomPoint" %in% vapply(res$layers, function(x) class(x$geom)[1], character(1)))
  expect_true("ScaleDiscrete" %in% vapply(res$scales$scales, function(x) class(x)[1], character(1)))
})


test_that("plot_interval_dist returns ggplot and supports label_obs", {
  testthat::skip_if_not_installed("ggplot2")
  dist <- c(1, 2, 3)
  obs <- c("a", "b", "c")

  res <- plot_interval_dist(dist, obs_names = obs, label_obs = "b")
  expect_s3_class(res, "ggplot")
  expect_true(!is.null(res$theme$axis.text.x))
  expect_true(any(vapply(res$layers, function(x) inherits(x$geom, "GeomTextRepel"), logical(1))))
})


test_that("plot_interval_dist supports cutoffs, default labels, and sort.obs FALSE", {
  testthat::skip_if_not_installed("ggplot2")
  dist <- c(1, 4, 2)
  obs <- c("one", "two", "three")

  res <- plot_interval_dist(
    dist,
    cutoff = c(2, 3),
    obs_names = obs,
    sort.obs = FALSE,
    color_class = c("A", "B", "A"),
    shape_class = c("x", "y", "x"),
    palette = c("A" = "red", "B" = "blue")
  )

  expect_s3_class(res, "ggplot")
  expect_true(any(vapply(res$layers, function(x) inherits(x$geom, "GeomHline"), logical(1))))
  expect_true(any(vapply(res$scales$scales, function(x) inherits(x, "ScaleDiscrete"), logical(1))))
})


test_that("plot_interval_dist supports color_class and shape_class with custom palette", {
  testthat::skip_if_not_installed("ggplot2")
  dist <- c(1, 3, 2)
  obs <- c("x", "y", "z")

  res <- plot_interval_dist(
    dist,
    obs_names = obs,
    color_class = c("red", "blue", "red"),
    shape_class = c("A", "B", "A"),
    color_label = "Group",
    shape_label = "Symbol",
    palette = c("red" = "green", "blue" = "yellow"),
    label_obs = c("x", "y")
  )

  expect_s3_class(res, "ggplot")
  expect_true("GeomPoint" %in% vapply(res$layers, function(x) class(x$geom)[1], character(1)))
})


test_that("plot_interval_dist errors on mismatched color or shape classes", {
  testthat::skip_if_not_installed("ggplot2")
  dist <- c(1, 2, 3)
  color_class <- c("a", "b")
  expect_error(plot_interval_dist(dist, color_class = c("a", "b")), "must match length")
  expect_error(plot_interval_dist(dist, shape_class = c("a", "b")), "must match length")
})
