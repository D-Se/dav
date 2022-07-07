E <- function(x) {
  switch(
    x,
    not_asset = "Input is not a data asset. To see supported see ?assets",
    file_type = "Unsupported file type.",
    "unknown error") |>
    stop(call. = FALSE)
}

W <- function(x, ...) {
  x <- as.character(x)
  switch(
    x,
    "1" = paste0("unsupported file type: ", ...), #1
    "unknown warning") |>
    warning(call. = FALSE)
}

M <- function(x) {
  x <- as.character(x)
  switch(
    x,
    message = "first",
    "unknown message"
  ) |>
    message()
}
