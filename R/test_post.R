#' Test POST wrappers
#'
#' Create a board with two lists, and a card with a label, a checklist and
#' a member on it.
#' @importFrom httr BROWSE
#' @export

test_post = function() {

  token = test_token()

  message("\n\nAdding board")
  board = add_board(
    name = model_name("add_board"),
    body = list(defaultLists = "false"),
    token = token
  )

  message("\n\nAdding a top list")
  list_top = add_list(
    board = board$id,
    name = model_name("add_list position: top"),
    position = "top",
    token = token
  )

  message("\n\nAdding a bottom list")
  list_bottom = add_list(
    board = board$id,
    name = model_name("add_list position: bottom"),
    position = "bottom",
    token = token
  )

  message("\n\nAdding a card to the top list")
  card = add_card(
    list = list_top$id,
    body = list(name = model_name("add_card")),
    token = token
  )

  message("\n\nAdding a card to the bottom list")
  card_empty = add_card(
    list = list_top$id,
    body = list(name = model_name("add_empty_card"), pos = "bottom"),
    token = token
  )

  message("\n\nAdding a comment")
  comment = add_comment(
    card = card$id,
    text = model_name("add_comment"),
    token = token
  )

  message("\n\nAdding a purple label")
  label = add_label(
    card = card$id,
    color = "purple",
    token = token
  )

  message("\n\nAdding a checklist")
  checklist = add_checklist(
    card = card$id,
    name = model_name("add_checklist"),
    token = token
  )

  message("\n\nAdding a checklist item")
  checkitem = add_checkitem(
    checklist = checklist$id,
    name = model_name("add_checkitem"),
    checked = TRUE,
    token = token
  )

  message("\n\nAdding a member")
  member = add_member(
    card = card$id,
    member = get_board_members(board$id, token = token)$id[1],
    token = token
  )

  model_list = ls()[!grepl("token", ls())]
  model_file = paste0("dev/", gsub(":", "", Sys.time()), " POST.RData")
  save(list = model_list, file = model_file)

  BROWSE(url = board$url)
  board$url
}
