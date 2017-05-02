library(data.table)
library(dplyr)
library(igraph)
library(showtext)
library(Cairo)

# changed font to Times New Roman
showtext.auto()
showtext.opts(dpi = 240)
font.add("Times New Roman", "times.ttf")

# data preProcessing
setwd(path)
data.yelp<-as.data.frame(fread("src/yelp_ori.txt",header=F))
names(data.yelp)<-c("from","to","weight")


if(flag.deg==F){
  
  graph.temp<-data.yelp[data.yelp$weight==max(data.yelp$weight),]
  # create graph filtered by weight
  for( layer.ith in 1:layer){
    index.from<-graph.temp$from
    index.to<-graph.temp$to
    graph.temp<-filter(data.yelp,
                     from %in% index.from |
                       to %in% index.from |
                       from %in% index.to |
                       to %in% index.to
    )
  }
  graph.df<-graph.temp
  
  
  
  # theshold.weight<-quantile(data.yelp$weight,theshold.quantile)
  # graph.df<-data.yelp[data.yelp$weight>theshold.weight,]
  
} else{
  
  # create graph filtered by degree
  g <- graph_from_data_frame(data.yelp,directed=F)
  degree<-degree(g)
  theshold.deg<-quantile(degree,theshold.quantile)
  degree<-data.frame(id=as.numeric(as.character(names(degree))),deg=degree)%>%
    filter(deg>theshold.deg)
  graph.df<-filter(data.yelp,from%in% degree$id,to%in% degree$id)
  
}


g <- graph_from_data_frame(graph.df,directed=F)
degree<-degree(g)
#degree<-data.frame(id=as.numeric(as.character(names(degree))),deg=degree)


V(g)$label<-""
V(g)$size<-log(degree)/2
V(g)$color<-ceiling(log(degree))
g$palette<-palette(brewer.pal(7,"Greens"))
E(g)$width<-0#graph.df$weight/6



