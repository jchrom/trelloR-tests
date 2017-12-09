# UTILS

test_token = function(appname = "trelloRtests", key = "key", secret = "secret") {
  get_token(
    key = secrettool::password_lookup("trello", key),
    secret = secrettool::password_lookup("trello", secret),
    appname = appname,
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
