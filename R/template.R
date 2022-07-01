# template <- function() {
#   switch(ext)
#   list(accessibility,
#        accuracy,
#        clarity,
#        completeness,
#        conciseness, 
#        consistency,
#        documentation,
#        encryption,
#        frequency,
#        integrity, 
#        longevity,
#        objectivity,
#        ownership,
#        precision,
#        relevance, 
#        scalability,
#        scarcity,
#        security,
#        sensitivity,
#        timeliness, 
#        usability,
#        validity,
#        volume)
# }

# completeness <- function(x) x
# reliability <- function(x) x
# volume <- function(x) x
# integrity <- function(x) x
# 
# 
# 
# "Ownership"
# "Longevity"
# "Encryption"
# "Documentation"
# "Precision"
# "Objectivity"
# "Frequency"
# "Scarcity"
# "Relevance"
# "Validity"
# "Clarity"
# "Conciseness"
# "Volume"
# "Usability"
# "Consistency"
# "Accuracy"
# "Accessibility"
# "Completeness"
# "Timeliness"
# "Integrity"
# 
# 
# x = c("Frequency", "Scarcity", "Scalability", "Relevance", "Longevity", "Encryption", "Documentation", "Completeness", "Conciseness", "Volume", "Usability", "Sensitivity", "Security", "Ownership", "Consistency", "Accessibility", "Timeliness", "Integrity")
# 
# y = c("Ownership", "Longevity", "Encryption", "Documentation", "Precision", "Objectivity", "Frequency", "Scarcity", "Relevance", "Validity", "Clarity", "Conciseness", "Volume", "Usability", "Consistency", "Accuracy", "Accessibility", "Completeness", "Timeliness", "Integrity")
# z <- c("Frequency", "Scarcity", "Scalability", "Relevance", "Longevity", 
#        "Encryption", "Documentation", "Completeness", "Conciseness", 
#        "Volume", "Usability", "Sensitivity", "Security", "Ownership", 
#        "Consistency", "Accessibility", "Timeliness", "Integrity", "Precision", 
#        "Objectivity", "Validity", "Clarity", "Accuracy")
# setdiff(y, x)
# union(x, y) |> tolower() |> as.list() |> lapply(str2lang) |> dput()
# 
# library(dplyr)
# tibble(
#   attribute = union(x, y) |> tolower(),
#   abbreviation = union(x, y) |> tolower() |> vapply(function(x) substr(x, 1, 3), "", USE.NAMES = F)
# )
# 
# f <- function() 1
# g <- function() 2

# #' Compute the degree of identical occurrences of values
# #' 
# #' @param data data set
# #' @return numeric in unit interval
# freq <- function(data) {
#  
#}
# 
# permissions <- function(data) {
#   f <- file.info(data)
#   
#   modef$mode
# }
