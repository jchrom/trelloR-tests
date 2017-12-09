#' Test SEARCH
#'
#' Test search.
#' @param model_data Model data
#' @export

test_search = function(model_data) {

  token = test_token()

  pop_env(model_data)

  s.mod = search_model("add", partial = TRUE, token = token, boards = board$id)
  s.act = search_actions("add", partial = TRUE, token = token, boards = board$id)
  s.brd = search_boards("add", partial = TRUE, token = token, boards = board$id)
  s.crd = search_cards("add", partial = TRUE, token = token, boards = board$id)
  s.mem = search_members("Jakub", partial = TRUE, token = token, boards = board$id)

  mget(ls()[!grepl("token", ls())])
}
