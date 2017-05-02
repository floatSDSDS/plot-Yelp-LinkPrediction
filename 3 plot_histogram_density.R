library(data.table)
library(ggplot2)
library(dplyr)
library(showtext)

# changed font to Times New Roman
showtext.auto()
showtext.opts(dpi = 240)
font.add("Times New Roman", "times.ttf")

# set path and output file names
path="E:/git/plot-yelp"
output.name<-"histogram-Kdensity-weight"



# set output file size and font zooming level
plot.title="Yelp Network's Weight Kernel Density Estimation"
g.width=8
g.height=5
k=1

# data preProcessing
setwd(path)
data.yelp<-as.data.frame(fread("src/yelp_ori.txt",header=F))
names(data.yelp)<-c("from","to","weight")

# plotting

ggplot(data.yelp, aes(weight)) +
 geom_histogram(aes(y=(..count..)/sum(..count..)),color="lightblue",fill="steelblue3")+
  stat_density(size=1,color="navy",fill="navy",alpha=.3,kernel =  "gaussian")+
  theme_minimal()+
  labs(title = plot.title,x = "",y="")+
  theme(
    text=element_text(family = "Times New Roman"),
    legend.position="bottom",
    legend.text = element_text(size=k*10),
    strip.text = element_text(size=k*12),
    strip.text.x = element_text(size = k*12),
    panel.border = element_rect(size = 1,fill=NA),
    plot.title = element_text(size=k*15,hjust = k*0.5),
    axis.title.x = element_text(size = k*15),
    axis.title.y = element_text(size = k*15),
    axis.text.x = element_text(size = k*10),
    axis.text.y = element_text(size = k*10),
    panel.background = element_rect(fill = "white"))


# export as eps and png
ggsave(
  filename=paste("plot/density/",paste(output.name,Sys.Date(),sep="-"),".eps",sep=""),
  device="eps",width = g.width,height = g.height,units = "in")
ggsave(
  filename=paste("plot/density/",paste(output.name,Sys.Date(),sep="-"),".png",sep=""),
  device="png",width = g.width,height = g.height,units = "in")
