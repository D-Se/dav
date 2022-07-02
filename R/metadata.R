#' get a file description based on the file
#' 
#' 
#' @param file filepath
#' @return list of file metadata descriptors
describe <- function(file) {
  if(is.object(file)) {
    # data set is in random access memory
  }
  if(is.character(file) && file.exists(file)) {
    type <- classify(file)
  }
}

classify <- function(file) {
  ext <- grab_ext(file)
  grab_mime(ext) %||% grab_magic(file) %||% ext
}

grab_ext <- function(x) {
  # tools::file_ext and base::ifelse
  pos <- regexpr("\\.([[:alnum:]]+)$", x)
  y <- which(pos > -1L)
  n <- which(!pos > -1L)
  #ans <- x
  x[y] <- substring(x, pos + 1L)[y]
  x[n] <- ""
  x
}

grab_mime <- function(file) {
  mime[["file"]]
}

grab_magic <- function(file) {
  # endianness can't be inferred from binary file
  # .Platform$endian
  header <- readBin(file, "raw", n = 12)
  # reading trailing byte is problematic and slow
  # system(paste0("trail -n 2 ", file), intern = TRUE) |> charToRaw()
}

# source: https://www.garykessler.net/library/file_sigs.html
# library(tidyverse)
# df <- read.csv("C:\\Users\\D\\Desktop\\file signatures\\file_sigs_RAW.txt", header = F) %>%
#   as_tibble() %>%
#   setNames(
#     c(
#       "Description","Header","Extension","FileClass","Header_offset","Trailer"
#     ) |> snakecase::to_snake_case()
#   ) %>%
#   janitor::clean_names()
# 
# 
# # iris tail hex
# # 69 63 61 22 0d 0a
# 
# # number of hex (4 bit) chunks in magic bytes 
# # 0   1   2   3   4   5   6   7   8   9  10  11  12  13  15  16  18  19  20  23  27  29  33  55 
# # 16  50  31 198  48  30  17 160   6   2   2   6   2   3  24   1   5   1   1   1   1   1   1   1 
# hex <- function(...) {
#   switch(...length())
# }

