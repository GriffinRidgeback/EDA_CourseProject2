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
# Set up the plot:
#
# 1. plot year against emission
# 2. remove minor outliers beyond y data point 400
# 3. group all data based on type factor
# 4. other aesthetics, parameters as noted
qplot(year, Emissions, data = baltimore, xlab = "", main = "Coal combustion emissions", ylab = "Total emissions (tons)", ylim = c(0, 400), facets = type ~ ., color = type, shape = type, geom = c("point", "smooth"), method = "lm")
#
# Write the plot
dev.off()