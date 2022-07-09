test_that("asset is identified as such", {
  # list-like data assets
  dfr <- data.frame(x = 1)
  lst <- list()
  # TODO unit test for file path & directory identification
  # tempfile() does not have read access

  expect_equal(is.asset(dfr), TRUE)
  expect_equal(is.asset(lst), TRUE)
})

test_that("non-assets are identified as such", {
  # currently unsupported data structures
  expr <- expression(x)
  call <- call("round", 10.5)
  fun <- function(x) x + 1
  atomic <- list(1L, 1, TRUE)
  chr_wrong <- "chr"
  raw <- raw(1)

  expect_equal(is.asset(expr), FALSE)
  expect_equal(is.asset(call), FALSE)
  expect_equal(is.asset(fun), FALSE)
  expect_equal(vapply(atomic, is.asset, TRUE), c(FALSE, FALSE, FALSE))
})
