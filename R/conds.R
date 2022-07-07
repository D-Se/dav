E <- function(x) {
  switch(
    x,
    not_asset = "Input is not a data asset. To see supported see ?assets",
    file_type = "Unsupported file type.",
    "unknown error") |>
    stop(call. = FALSE)
}

W <- function(x, ...) {
  switch(
    x,
    "unknown warning") |>
    warning(call. = FALSE)
}

M <- function(x) {
  switch(
    x,
    "unknown message"
  ) |>
    message()
}
