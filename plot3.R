# R source for Course Project 2
# Coursera Exploratory Data Analysis
#
# Section One: read in the data ----
#
# Read in the National Emissions Inventory Data
NEI <- readRDS("./data/summarySCC_PM25.rds")
#
# Read in the Source Classification Code Table
SCC <- readRDS("./data/Source_Classification_Code.rds")
#
# Section Two: massage the data ----
# 
# Select only data for FIPS 24510 (Baltimore City)
baltimore <- NEI[NEI$fips == "24510", ]
# 
# Convert type from chr to factor for plotting
baltimore$type  <- as.factor(baltimore$type)
# 
# Section Three: plot the data ----
#
# Load the ggplot2 package
library(ggplot2)
#
# Set up the graphics device
png("plot3.png")
# 
# Set up the plot
qplot(year, Emissions, data = baltimore, facets = type ~ ., color = type, shape = type, geom = c("point", "smooth"), method = "lm")
#
# Write the plot
dev.off()