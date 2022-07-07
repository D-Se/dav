test_that("asset is identified as such", {
  # assets are 
  expect_equal(is.asset(iris), TRUE)
  
  
  expect_equal(is.asset(1), FALSE)
})
