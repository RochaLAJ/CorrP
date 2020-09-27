#This function is inspired by flattenCorMatrix found at http://www.sthda.com/english/wiki/correlation-matrix-formatting-and-visualization
#The original formula is:
#flattenCorrMatrix <- function(cormat, pmat) {
#  ut <- upper.tri(cormat)
#  data.frame(
#    row = rownames(cormat)[row(cormat)[ut]],
#    column = rownames(cormat)[col(cormat)[ut]],
#    cor  =(cormat)[ut],
#    p = pmat[ut]
#    )
#}

#I had trouble to change the title of the plots through a loop strategy. My best result was:
# titles = as.list("x1","x2","x3")  
#   for (x in hist)
#        hist(x, main=substitute(paste(titles(colnames[x]))))
#I had to keep it manual


#I recommend a corr matrix provided by Hmisc::rcorr function.
CorrP <- function(cormat, pmat, FDR=FALSE, plot=FALSE) {
    ut <- upper.tri(cormat)
        Row = rownames(cormat)[row(cormat)[ut]]
        Column = rownames(cormat)[col(cormat)[ut]]
        R  = (cormat)[ut]
        Pvalue = pmat[ut]
    if (FDR)
        P.FDR = p.adjust(pmat[ut], method="fdr")
        data = data.frame(Row, Column, R,Pvalue, P.FDR)
        pos <- 1
        envir = as.environment(pos)
        data <- assign("CorrMatrix", data, envir = envir)
        hist = data
    if (plot)
        par(mfrow=c(1,3))
        hist$Row = NULL
        hist$Column = NULL
        hist(hist$R, main="Histogram of R values", col=heat.colors(4))
        hist(hist$Pvalue, main="Histogram of raw Pvalues", col=heat.colors(4))
        hist(hist$P.FDR, main="Histogram of Pvalues \n [FDR]", col=heat.colors(4), lwd=2)
}

Example:
data = read.csv("file.csv", header=T, row.names=1)
cor = rcorr(data.matrix(data), type="spearman")
CorrP(corr$r, corr$P, FDR=TRUE, plot=TRUE) #An object called CorrMatrix will be created
