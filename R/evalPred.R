#' @title Calculate prediction metrics for the given prediction
#' @description Calculate prediction metrics for the given prediction
#' @param x prediction (numeric or logical)
#' @param y logical classification vector
#' @details x and y are subset to complete (neither NA) cases
#' @importFrom cutpointr cutpointr
#' @importFrom precrec evalmod
#' @importFrom caret confusionMatrix
#' @export

evalPred <- function(x, y) {

  stopifnot(is.logical(x) || is.numeric(x))
  stopifnot(is.logical(y))
  stopifnot(length(x) == length(y))

  use <- complete.cases(x, y)

  if (is.numeric(x)) {
    areas <- attr(evalmod(scores = x[use], labels = y[use]), "aucs")$aucs
    names(areas) <- c("rocAUC", "prcAUC")
    cp <- cutpointr(x[use], y[use], pos_class = TRUE, direction = ">=",
                    silent = TRUE)$optimal_cutpoint
    o <- x >= cp
    names(cp) <- "cutpoint"
  } else {
    o <- x
    areas <- c(ROC = NA_real_, PRC = NA_real_)
    cp <- c(cutpoint = NA_real_)
  }

  cm <- confusionMatrix(factor(o, c(TRUE, FALSE)), factor(y, c(TRUE, FALSE)))
  tb <- as.vector(cm$table)
  names(tb) <- c("TP", "FN", "FP", "TN")
  cm <- c(cm$byClass, cm$overall, tb)
  names(cm) <- gsub("[: :]", "", names(cm))

  list(metrics = c(areas, cp, cm), score = x, predClass = o, refClass = y)

}



