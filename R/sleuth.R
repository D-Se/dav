#' investigate and document file metadata
#' 
#' \code{dav::sleuth} investigates the context in which data is valued.
#' 
#' @usage \special{dav::sleuth(file)}
#' 
#' @param file filepath
#' @return list of file metadata descriptors
#' 
#' @details 
#' \code{sleuth} investigates and collects information on the \emph{thing\(s\)} to be
#' valued and the \emph{system} on which it is evaluated.
sleuth <- function(file) {
  if(is.object(file)) {
    # data set is in random access memory
    return(0)
  }
  if(is.character(file) && file.exists(file)) {
    type <- classify(file)
  }
}

user_info <- function() {
  list(
    format = if(Sys.getenv("RSTUDIO") == "1") {
      fmt = Sys.getenv(
        c("RSTUDIO_CONSOLE_COLOR","RSTUDIO_CONSOLE_WIDTH"), names = FALSE
      )
      list(color = fmt[1L], width = fmt[2L])
    } else NULL,
    os = {
      info = Sys.info()
      c(
        type = .Platform[["OS.type"]],
        Sys.info()[c("sysname", "release", "version")] |> as.list()
      )
    },
    system = .Machine,
    software = list(
      R = R.version.string
    )
    #hardware = benchmarkme::get_cpu()
  )
}

file_info <- function(file) {
  info = file.info(file, extra_cols = T) |> as.list()
  info
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