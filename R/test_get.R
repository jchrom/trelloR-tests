#' Test GET plus wrappers
#'
#' Get data from models.
#' @param model_data Model data
#' @importFrom httr content
#' @export

test_get = function(model_data) {

  token = read_token()

  pop_env(model_data)

  test.type = c(
    "addMemberToCard", "addChecklistToCard", "commentCard", "createCard",
    "createList", "createList", "createBoard"
  )

  b.notflat = get_model(
    parent = "board",
    id = unlist(strsplit(board$shortUrl, "/"))[5],
    token = token,
    query = list(fields = "name"),
    add.class = FALSE
  )

  b.actions = get_model(
    parent = "board", child = "actions",
    id = b.notflat$id,
    token = token,
    query = list(limit = 0)
  )

  message(
    "Action type returned matches actual action type: ",
    identical(b.actions$type, test.type)
  )

  b.actions = get_model(
    parent = "board", child = "actions",
    id = b.notflat$id,
    token = token,
    query = list(limit = 0),
    response = "response"
  )

  message(
    "Action type returned matches actual action type: ",
    identical(
      test.type,
      vapply(content(b.actions), `[[`, character(1), "type")
    )
  )

  b.id = get_id_board(board$url, token)
  b.actions = get_board_actions(b.id, token, limit = 0)
  c.id = get_id_card(card$url, token)
  c.actions = get_card_actions(c.id, token, limit = 0)

  no.comment = get_card_comments(card_empty$id, token = token)

  message(
    "Test NULL response: ", is.null(no.comment)
  )

  mget(ls()[!grepl("token", ls())])
}
