#' Test PUT
#'
#' Test PUT.
#' @param model_data Model data
#' @export

test_put = function(model_data) {

  token = read_token()

  pop_env(model_data)

  if (is.null(model_data)) {
    RData = dir("dev", pattern = "[0-9]+.+\\POST.RData", full.names = T)
    load(RData[order(RData, decreasing = TRUE)][1])
  }

  card_upd = update_card(
    card = card$id,
    body = list(name = model_name("update_card")),
    token = token
  )

  label_upd = update_card_labels(
    card = card$id,
    labels = get_board_labels(board$id, token = token)$id[2:4],
    token = token
  )

  members_upd = update_card_members(
    card = card$id,
    members = "",
    token = token
  )

  item_upd = update_checkitem(
    card = card$id,
    checkitem = checkitem$id,
    body = list(state = "incomplete", name = model_name("update_item")),
    token = token
  )

  card_mov = move_card(
    card = card$id,
    list = list_bottom$id,
    token = token
  )

  mget(ls()[!grepl("token", ls())])
}

