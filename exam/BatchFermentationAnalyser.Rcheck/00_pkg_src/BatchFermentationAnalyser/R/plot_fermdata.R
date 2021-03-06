#' plot_fermdata
#'
#' Takes a list of Dataframes, containing Batch-relevant information, which substance
#' gets cumulated (co2 per default) and if type and filename are given, saves the results
#' as a png or jpeg.
#' @param x a list of dataframes
#' @param cumulate a name of a column
#' @param type the type of saved format
#' @param filename the filename
#' @param width picture width
#' @param height picture height
#' @param res picture resolution
#'
#' @return plot
#' @export
#'
#' @examples
#' plot_fermdata(a_wo_outlier, cumulate="co2", type = NA, filename = NA)

plot_fermdata <-
  function(x,
           cumulate = "co2",
           type = NA,
           filename = NA,
           width = 480,
           height = 480,
           res = 72) {
    only_plot_fermdata(x = x, cumulate = cumulate)
    if (!(is.na(type))){
      if (type=="png") {
        cex<-1.5
        png(filename,
            width = width,
            height = height,
            res = res)
        only_plot_fermdata(x = x, cumulate = cumulate, cex=cex)
        dev.off()
      }
      if (type=="jpeg"){
        cex<-1.5
        jpeg(filename,
             width = width,
             height = height,
             res = res)
        only_plot_fermdata(x = x, cumulate = cumulate, cex=cex)
        dev.off()
      } else { print("Please choose png or jpeg")}
    }
  }
