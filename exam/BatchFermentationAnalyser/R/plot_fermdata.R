#' plot_fermdata
#'
#' @param dataframe
#' @param cumulate
#' @param type
#' @param filename
#' @param width
#' @param height
#' @param res
#'
#' @return plot
#' @export
#'
#' @examples
#'


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
