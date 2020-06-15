#' @title Create ToxPi score rank plots
#' @description Create ToxPi score rank plots
#' @param res res matrix from [computeToxpi]
#' @param posChems vector of codes to color "active" chemcials orange
#' @param negChems vector of codes to color "negative" chemicals purple
#' @param coff numeric value, the score cutoff for positive vs negative
#' @export

rankPlot <- function(res, posChems = NULL, negChems = NULL, coff = NULL) {
  par(mar = c(4, 2, 1, 1))
  ordr <- order(res[ , "Rank"])
  plot(res[ordr, "Rank"] ~ res[ordr, "Score"],
       col = "gray40",
       pch = 16,
       cex = 0.4,
       axes = FALSE,
       ann = FALSE,
       lwd = 1.5)
  if (!is.null(coff)) {
    abline(v = coff, lty = "dashed", col = "gray60", lwd = 1.5)
  }
  axis(side = 1)
  title(xlab = "ToxPi Score")
  mtext("Rank", side = 2, line = 1)
  if (!is.null(posChems)) {
    points(y = res[rownames(res) %in% posChems, "Rank"],
           x = res[rownames(res) %in% posChems, "Score"],
           pch = 3,
           cex = 1,
           lwd = 3,
           col = "darkorange2")
  }
  if (!is.null(negChems)) {
    points(y = res[rownames(res) %in% negChems, "Rank"],
           x = res[rownames(res) %in% negChems, "Score"],
           pch = 4,
           cex = 1,
           lwd = 3,
           col = "purple3")
  }
}


