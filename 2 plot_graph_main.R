
# set path and output file names
path="E:/git/plot-yelp"
output.name<-"graph-yelp"
setwd(path)

# set output file size and font zooming level
g.width=16
g.height=16
k=1
flag.deg=F
theshold.quantile<-0.98


source("2 plot_graph.R")


cairo_ps(paste("plot/graph/",paste(output.name,Sys.Date(),sep="-"),".eps",sep=""),
         family = "Times",width = g.width, height = g.height)
plot(g, layout=layout_with_dh)
dev.off()
