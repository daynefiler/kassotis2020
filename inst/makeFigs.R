## Make figures

library(data.table)
library(kassotis2020)
library(dlfUtils)
data(smryTbl)
data(allScores)
data(kassotis)
data(janesick)

pdf("inst/noBuild/balAcc.pdf", width = 7.5, height = 5, pointsize = 10)
metricPlot("BalancedAccuracy")
dev.off()

pdf("inst/noBuild/ph1Rank.pdf", width = 7.5, height = 2.5, pointsize = 10)
rankPlot(allScores[["ja1Non"]],
         janesick[(cellActive), code],
         janesick[!(cellActive), code],
         smryTbl[Model == "8-Slice" & Phase == "PhI", cutpoint])
addfiglab("A")
dev.off()

pdf("inst/noBuild/bestRank.pdf", width = 7.5, height = 2.5, pointsize = 10)
coff <- smryTbl[Model == "5-Slice" &
                  CtrlType == "Literature" &
                  ZScore == "None",
                cutpoint]
rankPlot(allScores[["au3Non"]],
         kassotis[(litActive), code],
         kassotis[!(litActive), code],
         coff)
addfiglab("B")
dev.off()
