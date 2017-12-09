#' Run all tests
#'
#' Run all tests.
#' @param log If \code{TRUE}, console output will be captured in a file in working directory
#' @param RData If \code{TRUE}, RData will be saved in working directory
#' @export

run_tests = function(log = TRUE, RData = FALSE) {

  tests = paste(
    "test", c("post", "get", "search", "put", "delete", "get_limit"),
    sep = "_"
  )

  if (log) {
    log_file = paste0("log ", gsub(":", "", Sys.time()), ".txt")
    file.create(log_file)
    sink(log_file)
  }

  model_data = NULL

  for (test in tests) {

    message("\nRunning ", test)
    message("\n-----------------------------------------------------------\n")

    model_data = do.call(test, args = list(model_data = model_data))

    if (RData) {
      file_name = paste0(toupper(test), " ", gsub(":", "", Sys.time()), ".RData")
      save(model_data, file = file_name)
    }
  }

  sink()
}
