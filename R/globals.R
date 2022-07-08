#' package internal mime data
#' 
#' @description 
#' A hash table to identify media type of a data asset. See
#' \href{https://www.iana.org/assignments/media-types/media-types.xhtml}{mime}
#'
#' @details
#' A MIME (Multipurpose Internet Mail Extension) describes the nature and format
#' of a document, file, or assortment of bytes. MIME types are defined and
#' standardized in IETF's RFC 6838. The Internet Assigned Numbers Authority
#' (IANA) is responsible for all official MIME types
#'
#' @keywords dataset
#' @name mime
utils::globalVariables("mime")


#' ASJC field
#'
#' based on https://bartoc.org/en/node/20290
#' @details
#' the All Science Journal Classification \(ASJC\) is
#' @keywords dataset
#' @name ASJC
utils::globalVariables("ASJC")

SEED <- 1L
