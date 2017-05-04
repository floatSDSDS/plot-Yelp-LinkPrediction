g.all<-list()
evaluate.list<-c("PCC","RMSE")

names(point.shapes)<-unique(raw$Methods)
names(line.type)<-unique(raw$Methods)
names(colors)<-unique(raw$Methods)

list.dataset<-unique(raw$Dataset)

for(j in 1:2){
  if(j==1)
    data.temp<-raw[,c(1,2,3,4)]
  else
    data.temp<-raw[,c(1,2,3,5)]
  names(data.temp)[4]<-"value"
  data.temp$Dataset<-factor(data.temp$Dataset,
                            levels=c("Celegans","USAir","Lesmis","NetScience","Geom","CatCortex"))
  
  g.all[[j]]<-ggplot(data = data.temp,
                     aes(Proportion,value,
                         color=Methods,shape=Methods,linetype=Methods,group=Methods))+
    geom_line(size=1.11)+
    geom_point(size=5)+
    theme_minimal()+
    facet_wrap(~Dataset, scales = "free")+
    labs(x="Proportion",y=ifelse(j==1,"PCC","RMSE"))+
    theme(
      text=element_text(family = "Times New Roman"),
      legend.position="bottom",
      legend.text = element_text(size=k*10),
      legend.key.size=unit(.8,"inches"),
      strip.text.x = element_text(size = k*12),
      panel.border = element_rect(size = 1,fill=NA),
      plot.title = element_text(size=k*15,hjust = 0.5),
      axis.title.x = element_text(size = k*18),
      axis.title.y = element_text(size = k*18),
      axis.text.x = element_text(size = k*10),
      axis.text.y = element_text(size = k*10),
      panel.background = element_rect(fill = "white")
    )+
    scale_shape_manual(values=point.shapes,guide = guide_legend(title = NULL))+
    scale_linetype_manual(values=line.type,guide = guide_legend(title = NULL))+
    scale_color_manual(values=colors,guide = guide_legend(title = NULL))+
    scale_y_continuous(
      expand=c(.1, 0),limits=c(0,NA),
      labels = fmt_dcimals(2))#labels = fmt_dcimals(4))
  
  # for(i in 1:6){
  #   data.temp.2<-filter(data.temp,Dataset==list.dataset[i])
  #   label.temp<-seq(min(data.temp.2$value),max(data.temp.2$value),length.out=4)
  #   label.temp<-round(label.temp,3)
  #   
  #   g.all[[i]]<-ggplot(data=data.temp.2,
  #                      aes(Proportion,value,color=Methods,shape = Methods,group=Methods,linetype=Methods))+
  #     geom_line(size=1.11)+
  #     geom_point(size=5)+
  #     theme_minimal()+
  #     labs(title = list.dataset[i],x = "Proportion",y = "PCC")+
  #     theme(
  #       text=element_text(family = "Times New Roman"),
  #       legend.position="bottom",
  #       legend.text = element_text(size=k*10),
  #       legend.key.size=unit(.5,"inches"),
  #       strip.text.x = element_text(size = k*12),
  #       panel.border = element_rect(size = 1,fill=NA),
  #       plot.title = element_text(size=k*15,hjust = 0.5),
  #       axis.title.x = element_text(size = k*10),
  #       axis.title.y = element_text(size = k*10),
  #       axis.text.x = element_text(size = k*10),
  #       axis.text.y = element_text(size = k*10),
  #       panel.background = element_rect(fill = "white"))+
  #     scale_shape_manual(values=point.shapes,guide = guide_legend(title = NULL))+
  #     scale_linetype_manual(values=line.type,guide = guide_legend(title = NULL))+
  #     scale_color_discrete(guide = guide_legend(title = NULL))+
  #     scale_y_continuous(expand=c(.2, 0),breaks=label.temp)#labels = fmt_dcimals(4))
  # 
  #   if( i == 1 ){
  #     legend <- get_legend(g.all[[1]])
  #   }
  #   
  #   g.all[[i]]<-g.all[[i]]+theme(legend.position = "none")
  # }
  # 
  
  
  # export as eps 
  # cairo_ps(filename=paste("plot/evaluation/",paste(output.name,evaluate.list[j],Sys.Date(),sep="-"),".eps",sep=""),
  #          family = "Times",width = g.width, height = g.height)
  # grid.result<-grid.arrange(g.all[[1]], g.all[[2]], g.all[[3]],g.all[[4]],g.all[[5]],g.all[[6]],legend, ncol=3,nrow=3,
  #                           layout_matrix = rbind(c(1,2,3),c(4,5,6), c(7,7,7)),
  #                           widths = c(2.7, 2.7, 2.7), heights = c(3,3, 0.4))
  # dev.off()
  
  ggsave(filename = paste("plot/evaluation/",paste(output.name,evaluate.list[j],Sys.Date(),sep="-"),".eps",sep=""),device="eps",width=g.width,height=g.height)

  
}


