## Make supplemental tables

library(openxlsx)
library(data.table)
library(kassotis2020)
data(litSmry)
data(litAll)
data(smryTbl)
data(allScores)

tblDesc <- list(
  data.table("Chemical identifiers", "chemData"),
  data.table("Summary of literature findings", "litSmry"),
  data.table("Complete listing of manuscripts returned by literature search", "litAll"),
  data.table("Model performance metrics", "smryTbl"),
  data.table("Kassotis reference set", "kassotis"),
  data.table("Janesick reference set", "janesick"),
  data.table("ToxPi results for 8-slice model using Phase I", "allScores[['ja1Non']]"),
  data.table("ToxPi results for 8-slice model using Phase III, no cytotox filtering", "allScores[['ja3Non']]"),
  data.table("ToxPi results for 8-slice model using Phase III, Z > 0", "allScores[['ja3Rm0']]"),
  data.table("ToxPi results for 8-slice model using Phase III, Z > 1", "allScores[['ja3Rm1']]"),
  data.table("ToxPi results for 8-slice model using Phase III, Z > 2", "allScores[['ja3Rm2']]"),
  data.table("ToxPi results for 8-slice model using Phase III, Z > 3", "allScores[['ja3Rm3']]"),
  data.table("ToxPi results for 5-slice model using Phase III, no cytotox filtering", "allScores[['au3Non']]"),
  data.table("ToxPi results for 5-slice model using Phase III, Z > 0", "allScores[['au3Rm0']]"),
  data.table("ToxPi results for 5-slice model using Phase III, Z > 1", "allScores[['au3Rm1']]"),
  data.table("ToxPi results for 5-slice model using Phase III, Z > 2", "allScores[['au3Rm2']]"),
  data.table("ToxPi results for 5-slice model using Phase III, Z > 3", "allScores[['au3Rm3']]")
)
tblDesc <- rbindlist(tblDesc)
setnames(tblDesc, c("Description", "PackageObject"))
tblDesc[ , SheetName := paste0("Table S", .I)]
setcolorder(tblDesc, "SheetName")
getFunc <- function(x) {
  as.data.table(eval(parse(text = x)), keep.rownames = "code")
}
tblList <- lapply(tblDesc$PackageObject, getFunc)
names(tblList) <- tblDesc$SheetName
tblList <- c("Table S0" = list(tblDesc), tblList)
write.xlsx(tblList,
           file = "inst/noBuild/SuppTables.xlsx",
           keepNA = TRUE,
           colWidths = "auto",
           firstRow = TRUE)



