# 读取数据，改变RMSE和Pearson数据类型
raw<-read.xlsx2(paste("src/",file.name,sep=""),1,header=T)

names(raw)<-c("Dataset","Proportion","Methods","Pearson","RMSE")
  
raw$Pearson<-as.character(raw$Pearson)
raw$Pearson<-as.double(raw$Pearson)
raw$RMSE<-as.double(as.character(raw$RMSE))
raw$Methods<-gsub("xia","Zhu et al.", raw$Methods)
raw$Methods<-gsub("our","Ours", raw$Methods)

raw$Dataset<-gsub("celegans","Celegans",raw$Dataset)
raw$Dataset<-gsub("lesmis","Lesmis",raw$Dataset)
raw$Dataset<-gsub("netscience","NetScience",raw$Dataset)
raw$Dataset<-gsub("catbrain","CatCortex",raw$Dataset)



get_legend<-function(myggplot){
  tmp <- ggplot_gtable(ggplot_build(myggplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}

fmt_dcimals <- function(decimals=0){
  function(x) format(x,nsmall = decimals,scientific = FALSE)
}