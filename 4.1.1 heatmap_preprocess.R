
f_linearnorm2<-function(feature){
  delta=max(feature)-min(feature)
  temp<-(feature-min(feature))/delta
  return(temp)
}


get_legend<-function(myggplot){
  tmp <- ggplot_gtable(ggplot_build(myggplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}


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
melted_Value<-list()
melted_Value[[1]]<- melt(Value1)
melted_Value[[2]]<- melt(Value2)