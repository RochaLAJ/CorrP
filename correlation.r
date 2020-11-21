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
#An automated and pretty option is possible through corrplot package.
CorrP <- function(cormat, pmat, FDR=FALSE, sum=FALSE) {
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
    if (sum)
        P.FDR <- ifelse(data$P.FDR<=0.05, "Correlated", "NC")
        print(table(P.FDR))
        raw_pvalue <- ifelse(data$Pvalue<=0.05, "Correlated", "NC")
        print(table(raw_pvalue))      
}
CorrP(cor$r, cor$P, FDR=TRUE, sum=TRUE)


Example:
data = read.csv("file.csv", header=T, row.names=1)
cor = rcorr(data.matrix(data), type="spearman")
CorrP(corr$r, corr$P, FDR=TRUE, plot=TRUE, sum=TRUE) #An object called CorrMatrix will be created
