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
# Split out emissions data by year
emissionsData  <- split(baltimore$Emissions, baltimore$year)
#
# Year values are on the x-axis
x <- unique(baltimore$year)
#
# Sum data for y-axis values
y <- sapply(emissionsData, sum, na.rm = F)
#
# Section Three: plot the data ----
#
# Set up the graphics device
png("plot2.png")
#
# Set up the plot
plot(x, y, type = "n", xlab = "", ylab = "Totals (in tons)")
#
# Time series uses lines
lines(x, y)
#
# Add the data points for years
points(x, y, col = c("blue", "orange", "green", "red"), pch = 18, cex = 2.0)
#
# Add a plot title
title("Total PM2.5 Emissions for Baltimore City (1999-2008)")
#
# Write the plot
dev.off()