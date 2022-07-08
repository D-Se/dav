#' Developer-user interaction tools
#' 
#' Informative condition handling for known situations and unexpected input
#'    or behavior.
#' @param x `chr` - condition name
#' @param \dots further custom message specifications
#' 
#' @keywords internal
#' @name user_interaction
E <- function(x, ...) {
  # IDEA convert to rlang error handling?
  f <- sys.call(-2L)[[1L]]
  args <- list(...)
  msg <- switch(
    x,
    #### Error: User Input ####
    # user input is not of the type expected by the function
    wrong_type = c("Expected a", args[[1L]], ". Received: ", args[[2L]]),
    # computational method for data structure is not yet implemented
    not_asset = "Input is not a data asset. To see supported see ?assets",
    # file type not in MIME list or identifiable by magic bytes
    file_type = "Unsupported file type.",
    
    #### Error: Dev Shortcoming ####
    "unknown error")
  stop(msg, call. = FALSE)
}

#' @rdname user_interaction
#' @keywords internal
W <- function(x, ...) {
  switch(
    x,
    "unknown warning") |>
    warning(call. = FALSE)
}

#' @rdname user_interaction
#' @keywords internal
M <- function(x, ...) {
  switch(
    x,
    "unknown message"
  ) |>
    message()
}
