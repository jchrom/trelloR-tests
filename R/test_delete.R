#' Test DELETE
#'
#' Test DELETE.
#' @param model_data Model data
#' @export

test_delete = function(model_data) {

  token = read_token()

  pop_env(model_data)

  if (is.null(model_data)) {
    RData = dir("dev", pattern = "[0-9]+.+\\POST.RData", full.names = T)
    load(RData[order(RData, decreasing = TRUE)][1])
  }

  item_del = delete_checkitem(
    checklist = checklist$id,
    checkitem = checkitem$id,
    token = token
  )

  checklist_del = delete_checklist(
    checklist = checklist$id,
    token = token
  )

  card_del = delete_card(
    card = card$id,
    token = token
  )

  mget(ls()[!grepl("token", ls())])
}
