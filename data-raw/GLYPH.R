#' a list of glpyhs that are part of formatting instead of valuable data.
GLYPH <- list(
  OS_glyphs = list(
    # \r\n = CR + LF → new line character in Windows
    windows = c(0x0d, 0x0a),
    # \r = CR (Carriage Return) new line character in Mac OS before X
    # \n = LF (Line Feed) new line character in Unix/Mac OS X
    unix = c(0x0d)
  )
)