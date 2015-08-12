# R source for Course Project 2
# Coursera Exploratory Data Analysis
#
# Section Zero: load in the packages ----
#
# ggplot2 (for qplot)
if(!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2)
}
#
## Section One: read in the data ----
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
# Set up the graphics device
png("plot3.png", width = 1440, height = 480)
# 
# Set up the plot:
#
# 1. plot year against emission
# 2. remove minor outliers beyond y data point 400
# 3. group all data based on type factor
# 4. other aesthetics, parameters as noted
qplot(year, 
      Emissions, 
      data = baltimore, 
      xlab = "", 
      main = "Emissions by category:  Baltimore City (1999-2008)", 
      ylab = "Total emissions (tons)", 
      ylim = c(0, 400), 
      facets = . ~ type, 
      color = type, 
      shape = type, 
      geom = c("point", "smooth"),
      method = "loess")
#
# Write the plot
dev.off()