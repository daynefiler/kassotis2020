#' @title Create ToxPi score rank plots
#' @description Create ToxPi score rank plots
#' @param res res matrix from [computeToxpi]
#' @param posChems vector of codes to color "active" chemcials orange
#' @param negChems vector of codes to color "negative" chemicals purple
#' @export

rankPlot <- function(res, posChems = NULL, negChems = NULL) {
  par(mar = c(4, 1, 1, 1))
  plot(res[ , "Rank"] ~ res[ , "Score"],
       pch = 16,
       cex = 0.75,
       col = "gray40",
       axes = FALSE,
       ann = FALSE)
  axis(side = 1)
  title(xlab = "ToxPi Score")
  if (!is.null(posChems)) {
    points(y = res[rownames(res) %in% posChems, "Rank"],
           x = res[rownames(res) %in% posChems, "Score"],
           pch = 16,
           cex = 0.75,
           col = "darkorange2")
  }
  if (!is.null(negChems)) {
    points(y = res[rownames(res) %in% negChems, "Rank"],
           x = res[rownames(res) %in% negChems, "Score"],
           pch = 16,
           cex = 0.75,
           col = "purple3")
  }
}


