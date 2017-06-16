library(data.table)
library(ggplot2)
library(dplyr)
library(gridExtra)
library(grid)
library(Cairo)
library(showtext)

showtext.auto()
showtext.opts(dpi = 120)
font.add("Times New Roman", "times.ttf") 

# set path and output file names
path="E:/git/plot-yelp"
output.name<-"plot-yelp"

# set output file size and font zooming level
g.width=9
g.height=12
plot.title=""
k=1.5

# data preProcessing
setwd(path)
source("1 fun.R")
data<-as.data.frame(fread("src/yelp.csv",header=T))
names(data)<-c("Proportion","Method","PCC","RMSE")
data$Method<-gsub("xia","Zhu et al.",data$Method)
data$Method<-gsub("our","RF",data$Method)
data$Method<-factor(data$Method,levels = c("rWAA","rWCN","rWRA","Zhu et al.","RF","GBDT"))
#data<-melt(data,id.vars=c("Proportion","Method"))


# select point shapes
# check shape library by typing: ?pch
point.shapes=c(7:10,16:17)
line.type=c("solid","dashed","dotted","solid","solid","dashed")
colors=c("#009925","#EEB211","#3369E8","#D366EE","#EE8166","navy")

names(point.shapes)<-unique(data$Method)
names(line.type)<-unique(data$Method)
names(colors)<-unique(data$Methods)

g.result<-list()

data.melt<-melt(data,id.vars=c("Proportion","Method"))
# plotting
for(i in 1:2){
  g.result[[i]]<-ggplot(data=filter(data.melt,variable==ifelse(i==1,"PCC","RMSE")),
                        aes(x=as.factor(Proportion),y=value,
                            color=Method,group=Method,shape=Method,linetype=Method))+
    geom_line(size=1.11)+
    geom_point(size=5)+
    annotate("text", x = 1.1, y = 0, label = ifelse(i==1,"(a)","(b)"),size=k*6,family="Times New Roman")+
    theme_minimal()+
    labs(title = plot.title,x = "Proportion",y=ifelse(i==1,"PCC","RMSE"))+
    theme(
      text=element_text(family = "Times New Roman"),
      legend.position="bottom",
      legend.title=element_blank(),
      legend.text = element_text(size=k*10),
      legend.key.size=unit(.7,"inches"),
      strip.text = element_text(size=k*12),
      strip.text.x = element_text(size = k*12),
      panel.border = element_rect(size = 2,fill=NA),
      plot.title = element_text(size=k*15,hjust = 0.5),
      axis.title.x = element_text(size = k*15),
      axis.title.y = element_text(size = k*15),
      axis.text.x = element_text(size = k*10),
      axis.text.y = element_text(size = k*10))+
    scale_shape_manual(values=point.shapes,guide = guide_legend(title = NULL,nrow = 1))+
    scale_linetype_manual(values=line.type,guide = guide_legend(title = NULL,nrow = 1))+
    scale_color_manual(values=colors,guide = guide_legend(title = NULL,nrow = 1))+
    scale_y_continuous(expand=c(.1, 0))+
    scale_x_discrete(expand=c(.05,.1))#+
    # guides(
    #   color=guide_legend(ncol = 5,keywidth=6),
    #   linetype=guide_legend(ncol=5,keywidth=6),
    #   shape=guide_legend(ncol=5,keywidth=8))
  legend <- get_legend(g.result[[1]])
}

g.result[[1]]<-g.result[[1]]+theme(legend.position = "none")
g.result[[2]]<-g.result[[2]]+theme(legend.position = "none")


# export as eps 
cairo_ps(paste("plot/evaluation/",paste(output.name,Sys.Date(),sep="-"),".eps",sep=""),
         family = "Times",width = g.width, height = g.height)
grid.result<-grid.arrange(g.result[[1]], g.result[[2]], legend, ncol=1,nrow=3,
             layout_matrix = rbind(c(1), c(2),c(3)),
             widths = c(2.7), heights = c(2.5,2.5, 0.3))
dev.off()
