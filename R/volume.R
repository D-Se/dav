
# Calculate data cmpression ratio

#' Compute file entropy of an ASCII encoded file
#' 
#' @param file path to file
#' @return numeric length 1: the entropy of the file.
#' @export
#' @examples 
#' \dontrun{
#' ascii("testdata/iris.csv")
#' }
ascii <- function(file) {
  # remove " , \r \n and null string from files
  remove <- as.raw(c(0x22, 0x2c, 0x0d, 0x0a, 0x00))
  x <- readr::read_file_raw(file)
  x <- x[!x %in% remove] # sanitize csv, meaningfully compressible  part
  # total number of bytes in file
  total <- length(x)
  counts <- table(as.integer(x))
  # https://stackoverflow.com/questions/990477/how-to-calculate-the-entropy-of-a-file
  # base 256 to normalize 0-1 in bytes, not conventional base 2 for bits.
  H = -1*sum(counts / total * log(counts / total, 256))
  H
}

#' guess file encoding based on probability measures
#' 
#' @importFrom utils tail
#' @noRd
guess_encoding <- function(data, language = "unknown") {
  switch(language,
         unknown = stringi::stri_enc_detect(data, T),
         stringi::stri_enc_detect2(data, locale = NULL))
}


compress <- function(file) {
  fileext <- tail(strsplit(file, "\\.")[[1]], 1)
  # pre-compressed files
  avoid <- c(".png", ".jpg", ".mov", ".pdf", ".zip")
  tempfile("data", fileext = fileext)
  
  # get number of rows of data
  system("grep -c ^ testdata/iris.csv", intern = T) |> as.integer()
}

