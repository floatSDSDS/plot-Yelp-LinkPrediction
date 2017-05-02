library(ggplot2)
library(reshape2)
library(gridExtra)
library(grid)
library(RColorBrewer)
library(Cairo)



# set path and output file names
path="E:/git/plot-yelp"
output.name<-"heatmap"


# set output file size and font zooming level
plot.title=""
g.width=16
g.height=9
k=2

setwd(path)
source("1 fun.R")
value1<-read.table('src/imp1.txt',sep='',header=T)
value2<-read.table('src/imp2.txt',sep='',header=T)


Value1<-as.matrix(value1)
colnames(Value1)<-c("Celegans",'USAir1','Lesmis','NetScience','Geom',"CatCortex")
rownames(Value1)<-c('CN','Salton','Jaccard','HPI','HDI','AA','RA','Sorensen','LHN1','PA','FM','LP','LRM','Degree','Closeness','Betweennes','Eigenvector','Edge betweenness','K-Core')
Value2<-as.matrix(value2)
colnames(Value2)<-c('Celegans','USAir1','Lesmis','NetScience','Geom',"CatCortex")
rownames(Value2)<-c('CN','Salton','Jaccard','HPI','HDI','AA','RA','Sorensen','LHN1','PA','FM','LP','LRM','Degree','Closeness','Betweennes','Eigenvector','Edge betweenness','K-Core')



for (i in 1:6){
  Value1[,i]<-rank(Value1[,i])
  Value2[,i]<-rank(Value2[,i])
}


melted_Value1<- melt(Value1)
g1<-ggplot(data=melted_Value1, aes(x=Var2, y=Var1,fill=value))+
  geom_tile()+
  labs(title="", x = "(a)",y = "")+
  scale_x_discrete(expand = c(0, 0))+
  theme()+
  theme(
    legend.text = element_text(size=k*10),
    legend.position='none',
    plot.title = element_text(size=k*15,hjust = 0.5),
    axis.text.x=element_text(angle=15,hjust=0.55,vjust=0.8,size=k*10),
    axis.text.y = element_text(angle=45,hjust=0.9,size = k*10),
    axis.title.x = element_text(size = k*15),
    axis.title.y = element_text(size = k*15),
    panel.border = element_rect(size = 2,fill=NA)
    )+
  scale_fill_gradientn(
    #    low="#ccffcc", high='#009900',
    colours=colorRampPalette(brewer.pal(9,"RdYlGn"))(20),
    limits = c(1,19), breaks = c(1, 5, 10, 15, 19))

###############################################################
melted_Value2<- melt(Value2)
g2<-ggplot(data=melted_Value2, aes(x=Var2, y=Var1,fill=value))+
  geom_tile()+
  labs(title="",x = "(b)",y = "")+
  scale_x_discrete(expand = c(0, 0))+
  theme(      
    legend.title=element_blank(),
    legend.text = element_text(size=k*10),
    plot.title = element_text(size=k*15,hjust = 0.5),    
    axis.text.x=element_text(angle=15,hjust=0.55,vjust=0.8,size=k*10),
    panel.border = element_rect(size = 2,fill=NA),
    axis.text.y = element_blank(),
    axis.title.x = element_text(size = k*15),
    axis.title.y = element_text(size = k*15)
    )+
  guides(fill = guide_colorbar(barwidth = 1,barheight = 20))+
  scale_fill_gradientn(
#    low="#ccffcc", high='#009900',
    colours=colorRampPalette(brewer.pal(9,"RdYlGn"))(20),
    limits = c(1,19), breaks = c(1, 5, 10, 15, 19))

legend <- get_legend(g2)
g2<-g2+theme(legend.position = "none")

# export as eps
cairo_ps(paste("plot/heatmap/",paste(output.name,Sys.Date(),sep="-"),".eps",sep=""),
         family = "Times",width = g.width, height = g.height)
grid.result<-grid.arrange(g1, g2, legend, ncol=3,
                          widths = c(2.5, 2,0.4))
dev.off()
