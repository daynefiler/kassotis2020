#' @title fread files from zipped archive
#' @description fread files from zipped archive
#' @param zipDir the zipped folder
#' @param zipFl the file within the zipped directory to pass to fread
#' @param ... passed to [data.table::fread]
#' @return data.table object
#' @import data.table
#' @export

freadZipFile <- function(zipDir, zipFl, ...) {
  if (missing(zipFl)) return(unzip(zipDir, list = TRUE))
  cmd <- sprintf("unzip -p %s %s", zipDir, zipFl)
  fread(cmd = cmd, ...)
}

