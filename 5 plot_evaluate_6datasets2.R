g.all<-list()
evaluate.list<-c("PCC","RMSE")

names(point.shapes)<-unique(raw$Methods)
names(line.type)<-unique(raw$Methods)
names(colors)<-unique(raw$Methods)

list.dataset<-c("Celegans","USAir","Lesmis","NetScience","Geom","CatCortex")




for(j in 1:2){
  if(j==1)
    data.temp<-raw[,c(1,2,3,4)]
  else
    data.temp<-raw[,c(1,2,3,5)]
  names(data.temp)[4]<-"value"

  for(i in 1:6){
    data.temp.2<-filter(data.temp,Dataset==list.dataset[i])

    g.all[[i]]<-ggplot(data=data.temp.2,
                       aes(Proportion,value,color=Methods,shape = Methods,group=Methods,linetype=Methods))+
      geom_line(size=1.11)+
      geom_point(size=5)+
      theme_minimal()+
      labs(title = list.dataset[i],x = "",y = "")+
      theme(
        text=element_text(family = "Times New Roman"),
        legend.position="bottom",
        legend.text = element_text(size=k*10),
        legend.key.size=unit(.9,"inches"),
        strip.text.x = element_text(size = k*12),
        panel.border = element_rect(size = 1,fill=NA),
        plot.title = element_text(size=k*15,hjust = 0.5),
        # axis.title.x = element_text(size = k*10),
        # axis.title.y = element_text(size = k*10),
        axis.text.x = element_text(size = k*10),
        axis.text.y = element_text(size = k*10),
        panel.background = element_rect(fill = "white"))+
      scale_shape_manual(values=point.shapes,guide = guide_legend(title = NULL,nrow = 1))+
      scale_linetype_manual(values=line.type,guide = guide_legend(title = NULL,nrow = 1))+
      scale_color_manual(values=colors,guide = guide_legend(title = NULL,nrow = 1))+
      scale_y_continuous(
        expand=c(.1, 0),limits=c(0,ifelse(j==2&i==2,0.008,NA)),
        labels = fmt_dcimals(2))

    if( i == 1 ){
      legend <- get_legend(g.all[[1]])
    }

    g.all[[i]]<-g.all[[i]]+theme(legend.position = "none")
  }

  y.title=ggplot(test[j,],aes(x,y,label=Title))+
    geom_text(size=10,angle=90,family = "Times New Roman")+
    theme_void()

  # export as eps
  cairo_ps(filename=paste("plot/evaluation/",paste(output.name,evaluate.list[j],Sys.Date(),sep="-"),".eps",sep=""),
           width = g.width, height = g.height)
  grid.result<-grid.arrange(g.all[[1]], g.all[[2]], g.all[[3]],g.all[[4]],g.all[[5]],g.all[[6]],
                            y.title,x.title,legend,blank,
                            ncol=4,nrow=4,
                            layout_matrix = rbind(c(7,1,2,3),c(7,4,5,6), c(10,8,8,8),c(10,9,9,9)),
                            widths = c(0.3,2.7, 2.7, 2.7), heights = c(2.5,2.5,0.3,0.3))
  dev.off()
  
  # ggsave(filename = paste("plot/evaluation/",paste(output.name,evaluate.list[j],Sys.Date(),sep="-"),".eps",sep=""),device="eps",width=g.width,height=g.height)
  
  
}


