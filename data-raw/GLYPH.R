#' Non-informative byte list
#' 
#' Different file types define offsets or formatting bytes that carry little
#'    meaning. This list is a specification of such known noise-heavy values in
#'    popular file formats and miscellaneous use cases, such as OS differences.
#'  
#'
#' @author Donald Seinen
#' @keywords internal
GLYPH <- list(
  OS_glyphs = list(
    # \r\n = CR + LF → new line character in Windows
    windows = c(0x0d, 0x0a),
    # \r = CR (Carriage Return) new line character in Mac OS before X
    # \n = LF (Line Feed) new line character in Unix/Mac OS X
    unix = c(0x0d)
  )
)
