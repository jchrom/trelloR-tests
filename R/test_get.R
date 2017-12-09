#' Test GET plus wrappers
#'
#' Get data from models.
#' @importFrom httr content
#' @export

test_get = function(model_data = NULL) {

  token = test_token()

  if (is.null(model_data)) {
    RData = dir("dev", pattern = "[0-9]+.+\\POST.RData", full.names = T)
    load(RData[order(RData, decreasing = TRUE)][1])
  }

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

  # Test NULL response
  message(
    "Test NULL response: ", is.null(no.comment)
  )

  model_list = ls(pattern = "^(c\\.|b\\.).+")
  model_file = paste0("dev/", gsub(":", "", Sys.time()), " GET.RData")
  save(list = model_list, file = model_file)
}
