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
# Split out emissions data by year
emissionsData  <- split(NEI$Emissions, NEI$year)
#
# Year values are on the x-axis
x <- unique(NEI$year)
#
# Sum data for y-axis values
y <- sapply(emissionsData, sum, na.rm = T)
#
# Section Three: plot the data ----
#
# Set up the graphics device
png("plot1.png")
#
# Set up the plot
plot(x, y, type = "n", xlab = "", ylab = "Emission totals (in tons)")
#
# Time series uses lines
lines(x, y)
#
# Add the data points for years
points(x, y, col = c("blue", "orange", "green", "red"), pch = 18, cex = 2.0)
#
# Add a plot title
title("Total PM2.5 Emissions:  US (1999-2008)")
#
# Write the plot
dev.off()