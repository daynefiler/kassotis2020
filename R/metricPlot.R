#' @title Make metric plot
#' @description Make metric plot
#' @param metric character, the metric to plot
#' @param invert logical, highest value is darkest when FALSE
#' @param loadSmryTbl logical, when TRUE load a clean smryTbl to plot results
#' @param pdfFl character, file name/path to save a pdf; do not save to pdf
#' when NULL
#' @details
#' Designed for 9in x 6in device w/ 10pt text. Can specify new metrics and
#' suppress overwriting of standard smryTbl by using \code{loadSmryTbl = FALSE}.
#' @import data.table
#' @importFrom grDevices colorRampPalette palette
#' @importFrom graphics points plot.new plot.window text polygon par lines
#' @export

metricPlot <- function(metric, invert = FALSE, loadSmryTbl = TRUE,
                       pdfFl = NULL) {

  if (loadSmryTbl) data(smryTbl, envir = environment())
  vls <- round(smryTbl[ , get(metric)], 2)
  b <- seq(min(vls, na.rm = TRUE), max(vls, na.rm = TRUE), length.out = 21)
  frm <- formula(ZScore ~ Model + Phase + CtrlSet + CtrlType)
  cst <- dcast(smryTbl[!is.na(Model)], frm, value.var = metric)
  mat <- round(as.matrix(cst[ , -1]), 2)
  cts <- cut(mat, breaks = b, include.lowest = TRUE)

  gray <- "gray30"
  pal <- colorRampPalette(c("#CDA5E1", "#2F124A"))(20)
  palette(if (invert) rev(pal) else pal)

  addSq <- function(i, val, col) {
    rw <- 5 - ((i - 1) %% 5); cl <- 1 + floor((i - 1)/5)
    x <- c(cl, cl, cl + 1, cl + 1); y <- c(rw, rw + 1, rw + 1, rw)
    polygon(x = x, y = y, col = col, border = "white")
    prnt <- sprintf("%0.2f", val)
    text(x = cl + 0.5, y = rw + 0.5, col = "white", labels = prnt)
  }

  addPts <- function(y, ind) {
    points(pch = c(15, 22)[ind],
           y = rep(y, 7),
           col = gray,
           bg = "white",
           cex = 2,
           x = 1:7 + 0.5)
  }

  boundBox <- function(x, y, fill = TRUE, w = 1.5, h = strheight("H")*1.75) {
    fill <- if (fill) gray else "white"
    polygon(x = c(x - w/2, x - w/2, x + w/2, x + w/2),
            y = c(y - h/2, y + h/2, y + h/2, y - h/2),
            col = fill, border = gray)
  }

  if (!is.null(pdfFl)) pd <- pdf(pdfFl, width = 9, height = 6, pointsize = 10)
  par(mar = rep(0, 4))
  plot.new()
  plot.window(xlim = c(-4, 8), ylim = c(1, 10), asp = 1)
  mapply(addSq, seq_along(cts), mat, cts)
  text(x = 0,
       y = 1:5 + 0.5,
       labels = c("Z > 3", "Z > 2", "Z > 1", "Z > 0", "None"),
       adj = c(0, 0.5))
  for (i in 6:9 + 0.5) lines(x = c(-3, 8), y = c(i, i), col = gray)
  for (i in 6:9 + 0.5) boundBox(x = -3, y = i)
  for (i in 6:9 + 0.5) boundBox(x = -1, y = i, fill = FALSE)
  text(x = -3,
       y = 6:9 + 0.5,
       label = c("Cell", "Janesick", "8-Slice", "PhaseI"),
       col = "white")
  text(x = -1,
       y = 6:9 + 0.5,
       label = c("Literature", "Kassotis", "5-Slice", "PhaseIII"))
  addPts(6.5, c(1, 1, 1, 2, 1, 1, 2))
  addPts(7.5, c(1, 1, 2, 2, 1, 2, 2))
  addPts(8.5, c(rep(1, 4), rep(2, 3)))
  addPts(9.5, c(1, rep(2, 6)))

  polygon(y = c(2.5, 4.5, 4.5, 2.5),
          x = c(-3, -3, -1, -1),
          border = NA,
          col = cut(vls[1], breaks = b))
  text(x = -2,
       y = 3.5,
       sprintf("%0.2f", vls[1]),
       col = "white",
       font = 2,
       cex = 1.5)
  if (!is.null(pdfFl)) dev.off(pd)
}
