#' only_plot_fermdata
#'
#' Auxiliary Function for plot_fermdata. Takes List of Dataframes, calculates the
#' means, cumulates (default value) Co2, and optimizes output for RStudio.
#' @param x a list of dataframes
#' @param cumulate name of a column
#' @param cex
#'
#' @return plot
#' @export
#'
#' @examples
#' only_plot_fermdata(a_wo_outlier, cumulate="co2", cex=0.5)

only_plot_fermdata <- function(x, cumulate="co2", cex=0.5){
  x_means <- getBatchMeans(x)
  x_means[cumulate] <- cumsum(x_means[cumulate])
  x_sd <- getBatchSd(x)
  gHigh <- x_means + abs(x_sd)
  gLow <- x_means - abs(x_sd)

  plot(rownames(x_means), x_means$glucose,
       type="l", ylab = "[g]", xlab= "hours", las=1, ylim=c(min(gLow), max(gHigh)),
       main="Batch Data")
  cls <- 2:length(colnames(x_means))
  for (i in cls){
    lines(rownames(x_means), x_means[,i], col=i, type="l")
  }
  legend("topright",
         legend= colnames(x_means),
         col= 1:length(colnames(x_means)),
         lwd=1,
         title ="substances",
         horiz=F,
         title.col=1,
         ncol=4,
         cex=cex)
  clrs <- 1:length(colnames(x_means))
  for (i in 1:length(colnames(x_means))){
    arrows((as.numeric(rownames(x_means))), gHigh[,i], (as.numeric(rownames(x_means))), gLow[,i],
           col=clrs[i],
           angle=90,
           length=0.025,
           code=3)
  }
}
