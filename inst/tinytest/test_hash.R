# suppressMessages(library(dav))
data <- charToRaw("a test string")

# expect_equal(dav:::hash(data, "xxh3"), "4e53d263399fe064")
# expect_equal(dav:::hash(data, "128"), "d2264969c3aae7044e53d263399fe064")
expect_equal(dav:::hash(data, "xxh3"), "1bcf3089d866d150")
expect_equal(dav:::hash(data, "128"), "ed039fa8fe316fab4a0b7ef411ea9c04")