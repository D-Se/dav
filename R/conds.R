E <- function(x) {
  x = as.character(x)
  switch(x,
         file_path = "unknown file specfication", #1
         "unknown error") |>
    stop(call. = F)
}

W <- function(x, ...) {
  x = as.character(x)
  switch(x,
         "1" = paste0("unsupported file type: ", ...), #1
         "unknown warning") |>
    warning(call. = F)
}

M <- function(x) {
  x = as.character(x)
  switch(x, 
         message = "first",
        "unknown message"
         ) |>
    message()
}

