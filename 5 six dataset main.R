library(ggplot2)
library(data.table)
library(xlsx)
library(dplyr)
library(RColorBrewer)
library(plyr)
library(gridExtra)
library(grid)
library(Cairo)

# set path
#############################################
path="E:/git/plot-yelp"
file.name="30times_result.xlsx"
#############################################

setwd(path)
source("5 preprocess.R")

#############################################
# set folder to store plots
output.name="plot-6datasets"
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

point.shapes=15:19
line.type=c("solid","dashed","dotted","solid","solid")


source("5 plot_evaluate_6datasets.R")

# check the plots in the folder "folder.name"
# there may be problems with font, so you can set all the elements beside then return the code back to me.
