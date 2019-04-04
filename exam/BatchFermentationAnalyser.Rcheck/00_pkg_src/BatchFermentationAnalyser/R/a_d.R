#' a_d
#'
#' A list containing dataframes.
#'
#'  @format
#'  A list of 8 dataframes.
#'
#'  @name
#'  a_d
NULL


# readBatchDatasets <- function(x) {
#   mylist <- vector(mode = "list", length = length(x))
#   e = 1
#   for (i in x) {
#     mylist[[e]] <- read.table(i,
#                               header = TRUE,
#                               colClasses = "numeric")
#     e = e + 1
#   }
#   return(mylist)
# }
# 
# basis_dir <- getwd()
# a <- paste(basis_dir, "/inst/extdata/A/A", 1:8, ".txt", sep="")
# a_d <- readBatchDatasets(a)
# save(file="data/a_d.rda", list="a_d")

