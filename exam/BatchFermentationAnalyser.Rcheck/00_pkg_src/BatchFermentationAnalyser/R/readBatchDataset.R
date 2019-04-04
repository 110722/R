#' readBatchDatasets
#'
#' reads List with input-filnames and gets content of these files in a list of
#' dataframes. Outputs a List of dataframes.
#'
#' @param A vector of filenames
#'
#' @return A list of dataframes
#' @export
#'
#' @examples
#' readBatchDatasets(a)


readBatchDatasets <- function(x) {
  mylist <- vector(mode = "list", length = length(x))
  e = 1
  for (i in x) {
    mylist[[e]] <- read.table(i,
                              header = TRUE,
                              colClasses = "numeric")
    e = e + 1
  }
  return(mylist)
}
