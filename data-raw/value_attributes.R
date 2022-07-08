business <- c("Ownership", "Longevity", "Encryption", "Documentation",
      "Precision", "Objectivity", "Frequency", "Scarcity", "Relevance",
      "Validity", "Clarity", "Conciseness", "Volume", "Usability",
      "Consistency", "Accuracy", "Accessibility", "Completeness",
      "Timeliness", "Integrity")

scholar <- c("Frequency", "Scarcity", "Scalability", "Relevance", "Longevity",
      "Encryption", "Documentation", "Completeness", "Conciseness",
      "Volume", "Usability", "Sensitivity", "Security", "Ownership",
      "Consistency", "Accessibility", "Timeliness", "Integrity")

attributes <- sort(union(business, scholar))

enframe <- function(...) {
 string <- as.character(substitute(...()))
 gsub("`", "", string)
}

#' Human expert opinion related data value attributes
#' 
#' Semantic value components perceived by human operators. The non-divisible
#'    components of latter part of the phrase Data + Meaning.
#'
#' @source Donald Seinen
#' @keywords datasets
dav_attributes_subj <- enframe(
  accessible, acce, `A long description of the attribute here             `, 1,
  consistent, con,  `A long description of the attribute here             `, 1,
  accurate,   accu, `A long description of the attribute here             `, 1,
  clear,      cla, `A long description of the attribute here             `, 1,
  objective,  obj, `A long description of the attribute here             `, 1,
  relevant,   rel, `A long description of the attribute here             `, 1,
  scarce,     sca, `A long description of the attribute here             `, 1,
  secure,     sec, `A long description of the attribute here             `, 1,
  sensitive,  sen, `A long description of the attribute here             `, 1,
  timely,     tim, `A long description of the attribute here             `, 1,
  usable,     usa, `A long description of the attribute here             `, 1,
  valid,      val, `A long description of the attribute here             `, 1
)  |> matrix(ncol = 4, byrow = TRUE, dimnames = list(
  NULL, c("Attribute", "Abbreviation", "Description", "Publications"))
) |>
  as.data.frame()

#' Objective data asset value attriutes
#' 
#' Computable or inferable from a file or context.
#' 
#' @source Donald Seinen
#' @keywords datasets
dav_attributes_obj <- enframe(
  integrity,  int, `A long description of the attribute here              `, 1,
  longevity,  lon, `A long description of the attribute here              `, 1,
  metadata,   met, `A long description of the attribute here              `, 1,
  ownership,  own, `A long description of the attribute here              `, 1,
  volume,     vol, `A long description of the attribute here              `, 1,
  complete,   com, `A long description of the attribute here              `, 1,
  encrypted,  enc, `A long description of the attribute here              `, 1,
  frequent,   fre, `A long description of the attribute here              `, 1,
  concise,    con, `A long description of the attribute here              `, 1,
  precise,    pre, `A long description of the attribute here              `, 1,
  
  scalable,   sca, `A long description of the attribute here              `, 1
) |>
  matrix(ncol = 4, byrow = TRUE, dimnames = list(
    NULL, c("Attribute", "Abbreviation", "Description", "Publications"))
    ) |>
  as.data.frame()

