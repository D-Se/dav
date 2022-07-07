#' investigate and document file metadata
#'
#' \code{dav::sleuth} investigates the context in which data is valued, and
#' lays the foundation for comparison of data assets based on a unified data
#' asset metadata schema.
#'
#' @usage \special{dav::sleuth(file)}
#' @usage \special{dav::sleuth(dir, pattern = ".csv")}
#'
#' @param asset a data asset. A \emph{filepath} or an R object.
#' @param \dots arguments passed from and to methods.
#' @return list of file metadata descriptors
#'
#' @details
#' \code{sleuth} investigates and collects information on the \emph{thing\(s\)}
#' to be valued and the \emph{system} on which it is evaluated. A comparison of
#' data.
#'
#' filepaths are case sensitive.
#'
#' @section Data semantics:
#' An approximation of data value is limited by the ability to distinguish
#' noise from data and the truthfulness of their content. In \code{sleuth} files
#' are documented based on raw inputs and generally accepted practices.
#'
#' @examples
#' \dontrun{
#' sleuth(iris)
#' }
#' @importFrom stats alias
#' @importFrom utils osVersion
#' @export
sleuth <- function(asset, ...) {
  res <- list()
  if (is.asset(asset)) {
    res$context <- sleuth_context()
    res$asset <- sleuth_asset(asset)
    # asset is a file path
    #res$asset <- classify(asset)
  } else {
    # data asset is in random access memory
    return(0)
  }
}

#' get user and context
#' 
#' Several data attributes require detailed information on the who, what, where
#' and when of data assets. Additionally to facilitate metric reproducibility,
#' some hard- nd software specifications are \(temporarily\) gathered
sleuth_context <- function() {
  res <- unclass(R.version)
  res$platform <- paste0(res$platform, " (",
                         8 * .Machine$sizeof.pointer, "-bit)")
  res <- res[c("platform", "version.string")]
  res$os <- osVersion
  # reproducibility of ANFIS states
  res$RNG <- RNGkind()
  # multi-byte character set in use?
  res$time <- Sys.time() |> `attr<-`("tzone", "UTC")
  # Latin-1 is ISO/IEC 8859-1
  res$locale <- unlist(l10n_info())[1:3]
  # res$software_versions <- extSoftVersion()[c(1, 2)]
  res
}

#' find relevant information on the asset
sleuth_asset <- function(asset) {
  res <- list()
  if(is.asset(asset)) {
    res$type <- get_asset_type(asset)
    res$info <- file_info(asset)
  } else {
    E("not_asset")
  }
}


file_info <- function(asset, ...) {
  if (!utils::file_test("-f", asset)) {
    # asset is a single file
    file.info(asset, extra_cols = TRUE) |> as.list()
  } else {
    # asset is a diretory
    files <- list.files(asset, ...)
    lapply(files, file_info, ...)
  }
}

#' classify a given data asset
#'
#' @param asset a data asset
#'
#' @return \strong{chr}: a platform and domain independent classification.
classify <- function(asset) {
  ext <- grab_ext(asset)
  grab_mime(ext) %||% grab_magic(asset) %||% ext
}

grab_ext <- function(x) {
  # tools::file_ext and base::ifelse
  pos <- regexpr("\\.([[:alnum:]]+)$", x)
  y <- which(pos > -1L)
  n <- which(!pos > -1L)
  x[y] <- substring(x, pos + 1L)[y]
  x[n] <- ""
  x
}

grab_mime <- function(file) {
  MIME[["file"]]
}

grab_magic <- function(file) {
  # endianness can't be inferred from binary file
  # .Platform$endian
  header <- readBin(file, "raw", n = 12)
  # reading trailing byte is problematic and slow
  # system(paste0("trail -n 2 ", file), intern = TRUE) |> charToRaw()
}

get_asset_type <- function(x) {
  switch(
    typeof(x),
    character = {
      if (!utils::file_test(x)) "directory" else "file"
    },
    list = {
      class <- class(x)
      if (length(class) > 1L) {
        if (inherits(x, "data.frame")) {
          "data.frame"
        } else {
          "custom format"
        }
      } else { # actual list
        if (vapply(x, function(t) any(class(t) == "list"), TRUE)) {
          "nested list"
        } else {
          "singular list"
        }
      }
    },
    S4 = {
      "S4"
    },
    E("file_type")
  )
}

#' checking if R object or file is a trade-able data asset
#' @param x R object or file path
#' @param ... arguments passed to or from other methods
#' @details
#' a data asset is a collection of relata that carries semantic value in a
#' context.
#' @note \code{is.asset(x)} does not test if the asset is \emph{sensible}.
#' @return boolean
#' @export
is.asset <- function(x, ...) {
  # lgl, int, num, cmpl, chr
  if (!is.atomic(x)) {
    is.recursive(x) && !is.language(x)
  } else {
    # file path and readable
    is.character(x) && file.access(x, 4L) == 0L
  }
}