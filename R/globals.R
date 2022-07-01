# ALIAS <- c(
#   "com", "rel"
# )

# library(tidyverse)
# library(rvest)
# urls <- list(
#   "https://en.wikipedia.org/wiki/List_of_filename_extensions_(0%E2%80%939)",
#   "https://en.wikipedia.org/wiki/List_of_filename_extensions_(A%E2%80%93E)",
#   "https://en.wikipedia.org/wiki/List_of_filename_extensions_(F%E2%80%93L)",
#   "https://en.wikipedia.org/wiki/List_of_filename_extensions_(M%E2%80%93R)",
#   "https://en.wikipedia.org/wiki/List_of_filename_extensions_(S%E2%80%93Z)"
# )
# 
# grab_tables <- function(url) {
#   read_html(url) %>%
#     html_table() %>%
#     {.[-1]} %>%
#     purrr::reduce(dplyr::bind_rows)
# }
# 
# exts <- purrr::map_dfr(urls, grab_tables)
# 
# exts <- exts %>%
#   select(1:3) %>%
#   rename(extension = Ext., description = Description, user = `Used by`) %>%
#   mutate(extension = str_replace_all(extension, "^\\.mw-parser.*\\}|\\[.*\\]", "")) 
# 
# exts <- exts %>%
#   separate_rows(extension, sep = ", ")
# exts <- exts %>%
#   mutate(extension = trimws(extension))
# 
# x = exts$extension |>
#   sort() |> 
#   str_remove_all("[[:punct:]]") |> 
#   trimws() |>
#   unique() |>
#   (\(.) .[. != ""])()
# 
# 
# y = tbl$extension |> sort() |> unique()
# 
# all_exts = union(x, y) |> str_remove_all("[[:punct:]]")
# all_exts = all_exts[!all_exts == ""]
# 
# 
# tail(all_exts, 1000)
# Even though NTFS and the POSIX subsystem each handle case-sensitivity well,
# 16-bit Windows-based, MS-DOS-based, OS/2-based, and Win32-based applications do not.



