library(ggplot2)
library(reshape2)
library(gridExtra)
library(grid)
library(RColorBrewer)
library(Cairo)

showtext.auto()
showtext.opts(dpi = 120)
font.add("Times", "times.ttf") 

# set path and output file names
path="E:/git/plot-yelp"
output.name<-c("basic","legendTop","reverse-legendRight")

# choose your template: 
# A: basic
# B: legendTop
# C: reverse-legendRight
template.ith=c(1,2,3)

# use 'display.brewer.all()' and 'brewer.pal.info' command to check for palette
palette="Greens"
flag.reverse.color=F

# set output file size and font zooming level
plot.title=""
g.width=c(14,16,16)
g.height=c(9,9,6)
k=2

# configuring for 3 templates
x.hjust=c(.55,.55,.8)
x.vjust=c(.65,.65,.75)
x.angle=c(15,15,45)

y.hjust=c(.6,.6,.9)
y.vjust=c(.9,.9,.8)
y.angle=c(45,45,45)

bar.width=c(2,25,2)
bar.height=c(38,1,18.5)


setwd(path)
source("4.1.1 heatmap_preprocess.R")

g<-list()
for(T.ith in template.ith){
  for(g.ith in 1:2){
    g[[g.ith]]<-ggplot(data=melted_Value[[g.ith]], aes(x=Var2, y=Var1,fill=value))+
      geom_tile()+
      labs(title="", x = ifelse(g.ith==1,"(a)","(b)"),y = "")+
      scale_fill_gradientn(
        colours=colorRampPalette(brewer.pal(4,palette))(20),
        limits =c(-0.1,1.1), breaks = seq(0,1,length.out = 6))+
      theme(      
        text = element_text(family = "Times"),
        legend.title=element_blank(),
        legend.text = element_text(size=k*8),
        plot.title = element_text(size=k*15,hjust = 0.5),
        axis.title.x = element_text(size = k*15),
        axis.title.y = element_text(size = k*15),
        panel.border = element_rect(size = 2,fill=NA),
        
        axis.text.x=element_text(angle=x.angle[T.ith],
                                 hjust=x.hjust[T.ith],
                                 vjust=x.vjust[T.ith],size=k*8),
        axis.text.y = element_text(angle=y.angle[T.ith],
                                   hjust=y.hjust[T.ith],
                                   vjust=y.vjust[T.ith],
                                   size = k*8)
        
        
      )+
      guides(fill = guide_colorbar(barwidth= bar.width[T.ith],
                                   barheight  = bar.height[T.ith]))
    
    
    if(flag.reverse.color)
      g[[g.ith]]=g[[g.ith]]+scale_fill_gradientn(
        colours=rev(colorRampPalette(brewer.pal(4,palette))(20)),
        limits =c(-0.1,1.1), breaks = seq(0,1,length.out = 6))
    
    if(T.ith==3)
      g[[g.ith]]=g[[g.ith]]+coord_flip()+
        labs(title="", x ="", y = ifelse(g.ith==1,"(a)","(b)"))
    
    if(T.ith==2)
      g[[g.ith]]=g[[g.ith]]+theme(legend.position = "top")
  }
  # export as eps
  cairo_ps(paste("plot/heatmap/heatmap170502Selected/",
                 paste(output.name[T.ith],Sys.Date(),sep="-"),".eps",sep=""),
           family = "Times",width = g.width, height = g.height[T.ith])
  grid.result<-grid.arrange(g[[1]], g[[2]], ncol=2,widths = c(2, 2))
  dev.off()
}



