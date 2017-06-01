library(ggplot2)
library(data.table)
library(xlsx)
library(dplyr)
library(RColorBrewer)
library(plyr)
library(gridExtra)
library(grid)
library(showtext)


showtext.auto()
showtext.opts(dpi = 120)
font.add("Times New Roman", "times.ttf") 

# set path
#############################################
path="E:/git/plot-yelp"
file.name="30times_result.xlsx"
#############################################

setwd(path)
source("5 preprocess.R")

#############################################
# set folder to store plots
output.name="plot-new6"
plot.title=""
# set output size (inch)
g.width=16
g.height=9
# set font zooming scale
k=1.5
#############################################

# plotting, for details go check script 1 plot-all.R
# select point shapes
# check shape library by typing: ?pch

point.shapes=c(15:19,8,6)
line.type=c("solid","solid","dotted","dashed","solid","twodash","longdash")
colors=c("#009925","#EEB211","#3369E8","#D366EE","#EE8166","#102177","#7FA84A")

# an old version plot for 5 evaluation
# source("5 plot_evaluate_6datasets.R")

source("5 plot_evaluate_6datasets2.R")
# check the plots in the folder "folder.name"
# there may be problems with font, so you can set all the elements beside then return the code back to me.
