#' @title Calculate ToxPi scores
#' @description Calculate ToxPi scores
#' @param dat chemical by assay matrix with appropriate dimnames
#' @param mdl list with model specification; see details
#' @details
#' mdl list structure:
#' \describe{
#'   \item{slices}{named list of character vectors; name gives the slice name
#'   and the character vector gives the assays (columns in dat) to include in
#'   the slice}
#'   \item{weights}{numeric vector of slice weights}
#' }
#' @export

calculateToxpi <- function(dat, mdl) {

  stopifnot(all(unlist(mdl$slices) %in% colnames(dat)))
  stopifnot(length(mdl$slices) == length(mdl$weights))

  wts <- mdl$weights/sum(mdl$weights)

  sumSlice <- function(x) rowSums(dat[ , x, drop = FALSE], na.rm = TRUE)
  z2o <- function(x) (x - min(x, na.rm = TRUE))/diff(range(x, na.rm = TRUE))

  slc <- sapply(mdl$slices, sumSlice)
  slc <- apply(slc, 2, z2o)
  Score <- rowSums(sweep(slc, 2, wts, "*"))
  Rank  <- rank(Score, ties.method = "first")
  cbind(Score, Rank, slc)

}

