#' @title Download ToxCast Data into zipped folders
#' @description Download ToxCast Data into zipped folders
#' @param destDir the destination directory for the downloaded zip files
#' @details Downloads two files: (1) ToxCast_20110110.zip containing the
#' PhI ToxCast data, and (2) INVITRODB_V3_2_SUMMARY.zip containing the most
#' v3.2 data release (PhIII).
#' @importFrom utils download.file
#' @export

downloadData <- function(destDir = getwd()) {
  baseUrl <- file.path("https://gaftp.epa.gov",
                       "Comptox",
                       "High_Throughput_Screening_Data")
  ph1 <- file.path(baseUrl,
                   "Previous_Data",
                   "Jan_2010_PhaseI_ToxCast_Data",
                   "ToxCast_20110110.zip")
  ph3 <- file.path(baseUrl,
                   "InVitroDB_v3.2",
                   "Summary_Files",
                   "INVITRODB_V3_2_SUMMARY.zip")
  ph1Dest <- file.path(destDir, basename(ph1))
  download.file(ph1, ph1Dest)
  ph3Dest <- file.path(destDir, basename(ph3))
  download.file(ph3, ph3Dest)
}

