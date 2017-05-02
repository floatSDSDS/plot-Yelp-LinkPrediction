library(data.table)
library(ggplot2)
library(dplyr)
library(gridExtra)
library(grid)
library(Cairo)

# set path and output file names
path="E:/git/plot-yelp"
output.name<-"plot-yelp"

# set output file size and font zooming level
g.width=12
g.height=7
plot.title=""
k=1.5

# data preProcessing
setwd(path)
source("1 fun.R")
data<-as.data.frame(fread("src/yelp.csv",header=T))
names(data)<-c("Proportion","Method","PCC","RMSE")
data$Method<-gsub("xia","Zhu et al.",data$Method)
data$Method<-gsub("our","Ours",data$Method)
#data<-melt(data,id.vars=c("Proportion","Method"))


# select point shapes
# check shape library by typing: ?pch
point.shapes=15:19
names(point.shapes)<-unique(data$Method)
g.result<-list()


# plotting
for(i in 1:2){
  g.result[[i]]<-ggplot(data=data,aes(as.factor(Proportion),data[,i+2],
                                      color=Method,group=Method,shape=Method))+
    geom_line(size=1.11)+
    geom_point(size=5)+
    theme_minimal()+
    labs(title = plot.title,x = "Proportion",y=ifelse(i==1,"PCC","RMSE"))+
    theme(
      text=element_text(family = "serif"),
      legend.position="bottom",
      legend.title=element_blank(),
      legend.text = element_text(size=k*10),
      legend.key.size=unit(.5,"inches"),
      
      strip.text = element_text(size=k*12),
      strip.text.x = element_text(size = k*12),
      panel.border = element_rect(size = 2,fill=NA),
      
      plot.title = element_text(size=k*15,hjust = k*0.5),
      axis.title.x = element_text(size = k*15),
      axis.title.y = element_text(size = k*15),
      axis.text.x = element_text(size = k*10),
      axis.text.y = element_text(size = k*10))+
    scale_shape_manual(values=point.shapes,guide = guide_legend(title = NULL))+
    scale_color_discrete(guide = guide_legend(title = NULL))
  legend <- get_legend(g.result[[1]])
}

g.result[[1]]<-g.result[[1]]+theme(legend.position = "none")
g.result[[2]]<-g.result[[2]]+theme(legend.position = "none")


# export as eps 
cairo_ps(paste("plot/evaluation/",paste(output.name,Sys.Date(),sep="-"),".eps",sep=""),
         family = "Times",width = g.width, height = g.height)
grid.result<-grid.arrange(g.result[[1]], g.result[[2]], legend, ncol=2,nrow=2,
             layout_matrix = rbind(c(1,2), c(3,3)),
             widths = c(2.7, 2.7), heights = c(2.5, 0.2))
dev.off()
