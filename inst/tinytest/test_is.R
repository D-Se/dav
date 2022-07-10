suppressMessages(library(dav))
## asset is identified as such

dfr <- data.frame(x = 1)
lst <- list()
expr <- expression(x)
call <- call("round", 10.5)
fun <- function(x) x + 1
atomic <- list(1L, 1, TRUE)
chr_wrong <- "chr"
raw <- raw(1)

expect_true(is.asset(dfr))
expect_true(is.asset(lst))


## non-assets are identified as such
expect_false(is.asset(expr))
expect_false(is.asset(call))
expect_false(is.asset(fun))
expect_equal(vapply(atomic, is.asset, TRUE), c(FALSE, FALSE, FALSE))
