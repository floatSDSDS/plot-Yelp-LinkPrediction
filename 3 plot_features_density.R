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
output.name<-"yelp_all_features_KDensity"


# set output file size and font zooming level
g.width=16
g.height=9
k=2

# data preProcessing
setwd(path)
data.features<-as.data.frame(fread("src/yelp_feature.csv",header=T))
names(data.features)[3]<-"weight"
data.features<-select(data.features,from,to,weight,AA,CN,HDI,HPI,Jaccard,LHNI,
                      PA,RA,Salton,Sorenson,LocalPath,
                      rw,edge_BTS,newdegree,newbetweenness,newcloseness,newevcent,kcore,fm)
# 
# for(i in 3:dim(data.features)[2]){
#   data.features[,i]<-f_linearnorm(data.features[,i])
# }
data.features.melt<-melt(data.features,id.vars=c("from","to"))



# plotting
ggplot(data.features.melt,aes(value)) +
  #  geom_histogram(aes(y=(..count..)/sum(..count..)),color="lightblue",fill="steelblue3")+
  stat_density(size=1,color="navy",fill=NA,kernel =  "gaussian")+
  theme_minimal()+
  labs(title = "Kernel Density Estimation for Yelp Features",x = "",y="")+
  facet_wrap(~variable,nrow=5,ncol=4,scales = "free")+
  theme(
    text=element_text(family = "Times New Roman"),
    legend.position="bottom",
    legend.text = element_text(size=k*10),
    strip.text = element_text(size=k*12),
    strip.text.x = element_text(size = k*12),
    panel.border = element_rect(size = 1,fill=NA),
    plot.title = element_text(size=k*15,hjust =0.5),
    axis.title.x = element_text(size = k*15),
    axis.title.y = element_text(size = k*15),
    axis.text.x = element_text(size = k*10),
    axis.text.y = element_text(size = k*10),
    panel.background = element_rect(size=2,color="gray",fill = "white")
    )


# export as eps and png
ggsave(
  filename=paste("plot/density/",paste(output.name,Sys.Date(),sep="-"),".eps",sep=""),
  device="eps",width = g.width,height = g.height,units = "in")
ggsave(
  filename=paste("plot/density/",paste(output.name,Sys.Date(),sep="-"),".png",sep=""),
  device="png",width = g.width,height = g.height,units = "in")

