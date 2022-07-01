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

file_info("testdata/iris.csv")


tmp <- tempfile(pattern = "iris", fileext = ".csv")
write.csv(iris, tmp)

file.info(tmp)
