# UTILS

model_name = function(title = "", time = FALSE) {
  paste0(
    "Test: ", title,
    if(time) paste0(", ", Sys.time()) else NULL
  )
}

pop_env = function(env, to = parent.frame()) {
  as.environment(env)
  for (this_name in names(env))
    assign(
      x = this_name,
      value = env[[this_name]],
      pos = to
    )
}

#' Read token
#'
#' Read cached token
#' @param loc File to read the token from
#' @export

read_token = function(loc = ".httr-oauth") {
  tryCatch(
    readRDS(loc)[[1]],
    error = function(e) {
      message(e$message)
      message("Please call trelloR::get_token() to make a new token")
    }
  )
}
