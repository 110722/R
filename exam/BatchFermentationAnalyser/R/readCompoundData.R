#' readCompoundData
#'
#' @param a file
#'
#' @return a dataframe
#' @export
#'
#' @examples
#'


readCompoundData <- function(x) {
  mycompounds <- read.table(x)
  return(mycompounds)
}
