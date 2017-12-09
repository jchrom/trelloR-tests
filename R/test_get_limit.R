#' Test GET limit
#'
#' Test GET limit.
#' @param url Public board URL
#' @export

test_get_limit = function(url = NULL) {

  if (is.null(url))
    url = "https://trello.com/b/nC8QJJoZ/trello-development-roadmap"

  board.id  = get_id_board(url)

  # Test limits: df
  df.5     = get_board_actions(board.id, limit = 5)
  df.1005  = get_board_actions(board.id, limit = 1005)
  df.0     = get_board_actions(board.id, limit = 0)
  df.minus = tryCatch(
    get_board_actions(board.id, limit = -5),
    error = function(e) message(e$message)
  )

  # Test limits: response
  rs.5     = get_board_actions(board.id, limit = 5, response = "response")
  rs.1005  = get_board_actions(board.id, limit = 1005, response = "response")
  rs.0     = get_board_actions(board.id, limit = 0, response = "response")
  rs.minus = tryCatch(
    get_board_actions(board.id, limit = -5, response = "response"),
    error = function(e) message(e$message)
  )

  model_list = ls(pattern = "^(df\\.|rs\\.).+")
  model_file = paste0("dev/", gsub(":", "", Sys.time()), " GET limit.RData")
  save(list = model_list, file = model_file)
}
