# UTILS

test_token = function(appname = "trelloRtests", key = NULL, secret = NULL) {

  if (is.null(key))
    key = secrettool::password_lookup("trello", "key")

  if (is.null(secret))
    secret = secrettool::password_lookup("trello", "secret")

  get_token(
    key = key, secret = secret, appname = appname,
    scope = c("read", "write"),
    expiration = "never"
  )
}

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

