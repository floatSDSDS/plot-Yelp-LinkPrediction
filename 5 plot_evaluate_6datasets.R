g.all<-list()
evaluate.list<-c("PCC","RMSE")

names(point.shapes)<-unique(raw$Methods)

for(i in 1:2){      
  g.all[[i]]<-ggplot(data=raw,aes(Proportion,raw[,i+3],color=Methods,group=Methods,shape = Methods))+
    geom_line(size=1.11)+
    geom_point(size=2.5)+
    facet_wrap(~Dataset,nrow=2,ncol=3,scales = "free")+
    theme_minimal()+
    labs(title = plot.title,x = "Proportion",y = evaluate.list[i])+
    theme(
      text=element_text(family = "Times New Roman"),
      legend.position="bottom",
      legend.text = element_text(size=k*10),
      legend.key.size=unit(.5,"inches"),
      strip.text.x = element_text(size = k*12),
      panel.border = element_rect(size = 1,fill=NA),
      plot.title = element_text(size=k*15,hjust = k*0.5),
      axis.title.x = element_text(size = k*15),
      axis.title.y = element_text(size = k*15),
      axis.text.x = element_text(size = k*10),
      axis.text.y = element_text(size = k*10),
      panel.background = element_rect(fill = "white"))+
    scale_shape_manual(values=point.shapes,guide = guide_legend(title = NULL))+
    scale_color_discrete(guide = guide_legend(title = NULL))
  
  ggsave(filename=paste("plot/evaluation/",paste(output.name,evaluate.list[i],Sys.Date(),sep="-"),".eps",sep=""),
         g.all[[i]],device="eps",
         width = g.width,height = g.height,units = "in")
  ggsave(filename=paste("plot/evaluation/",paste(output.name,evaluate.list[i],Sys.Date(),sep="-"),".png",sep=""),
         g.all[[i]],device="png",
         width = g.width,height = g.height,units = "in")
}

