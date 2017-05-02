library(ggplot2)
library(reshape2)
library(gridExtra)
library(grid)
library(Cairo)



# set path and output file names
path="E:/git/plot-yelp"
output.name<-"heatmap"

# set output file size and font zooming level
g.width=16
g.height=9
k=2

value1<-read.table('src/imp1.txt',sep='',header=T)
value2<-read.table('src/imp2.txt',sep='',header=T)


# for(i in 1:6){
#   value1[,i]<-f_linearnorm(value1[,i])
#   value2[,i]<-f_linearnorm(value2[,i])
# }

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
  scale_fill_gradient(low="#ccffcc", high='#009900')+
  labs(x = "",y = "")+
  scale_x_discrete(expand = c(0, 0))+
  theme()+
  theme(
    legend.text = element_text(size=k*10),
    legend.position='none',
    axis.text.x=element_text(angle=45,hjust=1,size=k*10),
    panel.border = element_rect(size = 2,fill=NA),
    axis.text.y = element_text(size = k*10)
    )

###############################################################
melted_Value2<- melt(Value2)
g2<-ggplot(data=melted_Value2, aes(x=Var2, y=Var1,fill=value))+
  geom_tile()+
  scale_fill_gradient(low="#ccffcc", high='#009900')+
  labs(x = "",y = "")+
  scale_x_discrete(expand = c(0, 0))+
  theme(      
    legend.title=element_blank(),
    legend.text = element_text(size=k*10),
    legend.key.size=unit(1,"inches"),
    legend.position = "bottom",
    axis.text.x=element_text(angle=45,hjust=1,size=k*10),
    panel.border = element_rect(size = 2,fill=NA),
    axis.text.y = element_text(size = k*10)
    )
legend <- get_legend(g2)
g2<-g2+theme(legend.position = "none")

# export as eps
cairo_ps(paste("plot/heatmap/",paste(output.name,Sys.Date(),sep="-"),".eps",sep=""),
         family = "Times",width = g.width, height = g.height)
grid.result<-grid.arrange(g1, g2, legend, ncol=2,nrow=2,
                          layout_matrix = rbind(c(1,2), c(3,3)),
                          widths = c(2.7, 2.7), heights = c(2.5, 0.4))
dev.off()
