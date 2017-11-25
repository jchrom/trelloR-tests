#' Test add_
#'
#' Setup a new board for testing, with two lists and one card; return as a new
#' environment
#' @param token token
#' @return testing environment
#' @export

test_add = function(token) {

  board = add_board(
    name = new_string("add_board"),
    body = list(defaultLists = "false"),
    token = token
  )

  list_a = add_list(
    board = board$id,
    name = new_string("add_list position: top"),
    position = "top",
    token = token
  )

  list_b = add_list(
    board = board$id,
    name = new_string("add_list position: bottom"),
    position = "bottom",
    token = token
  )

  card = add_card(
    list = list_a$id,
    body = list(name = new_string("add_card")),
    token = token
  )

  comment = add_comment(
    card = card$id,
    text = new_string("add_comment"),
    token = token
  )

  label = add_label(
    card = card$id,
    color = "purple",
    token = token
  )

  checklist = add_checklist(
    card = card$id,
    name = new_string("add_checklist"),
    token = token
  )

  checkitem = add_checkitem(
    checklist = checklist$id,
    name = new_string("add_checkitem"),
    checked = TRUE,
    token = token
  )

  member = add_member(
    card = card$id,
    member = get_board_members(board$id, token = token)$id[1],
    token = token
  )

  environment()

}
