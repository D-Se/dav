test_that("xxhash output is known", {
  expect_equal(hash(mtars), "4e53d263399fe064")
  expect_equal(hash(mtcars), "d2264969c3aae7044e53d263399fe064")
})
