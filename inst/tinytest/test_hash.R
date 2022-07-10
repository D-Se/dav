# suppressMessages(library(dav))

expect_equal(dav:::hash(mtcars), "4e53d263399fe064")
expect_equal(dav:::hash(mtcars, "128"), "d2264969c3aae7044e53d263399fe064")