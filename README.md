# CorrP
A simple adaptation of flattenCorMatrix() function to provide histogram and corrected Pvalues
This function is inspired by flattenCorMatrix found at http://www.sthda.com/english/wiki/correlation-matrix-formatting-and-visualization


I had trouble to change the title of the plots through a loop strategy. My best result was:
 titles = as.list("x1","x2","x3")  ;
   for (x in hist)  ;
        hist(x, main=substitute(paste(titles(colnames[x])))) ;
I had to keep it manual


I recommend a corr matrix provided by Hmisc::rcorr function.
An automated and pretty option is possible through corrplot package.
