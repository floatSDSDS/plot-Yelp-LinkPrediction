library(ggplot2)
library(reshape2)
library(gridExtra)
library(grid)
library(RColorBrewer)
library(Cairo)
library(showtext)


showtext.auto()
showtext.opts(dpi = 120)
font.add("Times New Roman", "times.ttf") 

f_linearnorm2<-function(feature){
  delta=max(feature)-min(feature)
  temp<-(feature-min(feature))/delta
  return(temp)
}


# set path and output file names
path="E:/git/plot-yelp"
output.name<-"true_right_heatmap"


# set output file size and font zooming level
plot.title=""
g.width=16
g.height=12
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
  Value1[,i]<-f_linearnorm2(Value1[,i])
  Value2[,i]<-f_linearnorm2(Value2[,i])
}


melted_Value1<- melt(Value1)
g1<-ggplot(data=melted_Value1, aes(x=Var2, y=Var1,fill=value))+
  geom_tile()+
  labs(title="", x = "",y = "(a)")+
  scale_x_discrete(expand = c(0, 0))+
  theme()+
  theme(      
    text=element_text(family = "Times New Roman"),
    legend.title=element_blank(),
    legend.text = element_text(size=k*10),
    # legend.position=c(.6,.3),
    # legend.position = "none",
    plot.title = element_text(size=k*15,hjust = 0.5),
    axis.text.x=element_text(angle=45,hjust=0.75,vjust=0.8,size=k*10),
    axis.text.y = element_text(angle=45,hjust=0.9,size = k*10),
    axis.title.x = element_text(size = k*15),
    axis.title.y = element_text(size = k*15),
    panel.border = element_rect(size = 2,fill=NA)
    )+  
  scale_fill_gradientn(
      #    low="#ccffcc", high='#009900',
      colours=colorRampPalette(brewer.pal(4,"Greens"))(20),
      limits =c(-0.1,1.1), breaks = seq(0,1,length.out = 6))+
  guides(fill = guide_colorbar(barwidth=2,barheight  = 17))
  # +coord_flip()


###############################################################
melted_Value2<- melt(Value2)
g2<-ggplot(data=melted_Value2, aes(x=Var2, y=Var1,fill=value))+
  geom_tile()+
  labs(title="",x = "",y = "(b)")+
  scale_x_discrete(expand = c(0, 0))+
  theme(      
    text=element_text(family = "Times New Roman"),
    legend.title=element_blank(),
    legend.key = element_rect(colour = "black"),
    legend.position=c(.6,.55),
    legend.direction="vertical",
    legend.text = element_text(size=k*8),
    plot.title = element_text(size=k*15,hjust = 0.5),    
    axis.text.x=element_text(angle=45,hjust=0.75,vjust=0.8,size=k*10),
    # axis.text.y = element_blank(),  
    axis.text.y = element_text(angle=45,hjust=0.9,size = k*10),
    
    panel.border = element_rect(size = 2,fill=NA),
    axis.title.x = element_text(size = k*15),
    axis.title.y = element_text(size = k*15)
    )+
  guides(fill = guide_colorbar(barwidth = 2,barheight = 49))+
  scale_fill_gradientn(
    colours=colorRampPalette(brewer.pal(4,"Greens"))(20),
    limits = c(-0.1,1.1), breaks = seq(0,1,length.out = 6))
  # coord_flip()


legend <- get_legend(g2)
g2<-g2+theme(legend.position = "none")
g1<-g1+theme(legend.position = "none")

# export as eps
cairo_ps(paste("plot/heatmap/",paste(output.name,Sys.Date(),sep="-"),".eps",sep=""),
         family = "Times",width = g.width, height = g.height)

# grid.result<-grid.arrange(g1,g2, legend, ncol=2,nrow=2,
#                           layout_matrix = rbind(c(3,3),c(1,2)),
#                           widths = c(2.7,2.7), heights = c(0.4,3.3))

grid.result<-grid.arrange(g1,g2,legend,ncol=3,nrow=1,
                          layout_matrix=rbind(c(1,2,3)),
                          widths=c(2.7,2.7,0.5))
dev.off()
