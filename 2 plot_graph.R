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
  
  # create graph filtered by weight
  graph.temp=data.yelp[data.yelp$weight==max(data.yelp$weight),]
  
  
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

V(g)$label<-""
V(g)$size<-0
E(g)$width<-1#log(graph.df$weight)



