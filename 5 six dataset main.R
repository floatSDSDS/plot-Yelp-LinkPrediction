library(ggplot2)
library(data.table)
library(xlsx)
library(dplyr)
library(RColorBrewer)
library(plyr)
library(showtext)

# this method usees system font, so it may be different on Mac OS
# to check specific what :Times New Roman" names, check "font.paths()" and "font.files()"
# note that remember to uncomment the line in "1 plot-all.R" in theme

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
source("5 plot_evaluate_6datasets.R",encoding = "UTF-8")

# check the plots in the folder "folder.name"
# there may be problems with font, so you can set all the elements beside then return the code back to me.
