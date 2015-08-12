# R source for Course Project 2
# Coursera Exploratory Data Analysis
#
# Section Zero: load in the packages ----
#
# plyr (for join)
if(!require(plyr)){
  install.packages("plyr")
  library(plyr)
}
#
# lattice (for xyplot)
if(!require(lattice)){
  install.packages("lattice")
  library(lattice)
}
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
# Extract only those entries that define motor vehicle emissions
# Source: http://www.epa.gov/otaq/hwy.htm
mobile  <- grep("^Mobile -(.*)Road(.*)", SCC$EI.Sector, ignore.case = T)
#
# Subset the SCC data based on those indices
mobileSCC  <- SCC[mobile, c("SCC", "EI.Sector")]
#
# Join the two datasets by their common key
emissionData  <- join(baltimore, mobileSCC, by = "SCC", type = "inner")
#
# Section Three: plot the data ----
#
# Set up the graphics device
png("plot5.png", width = 1440, height = 720)
# 
# Set up the plot:
#
# visualize emissions by year
# condition by type of motor vehicle
xyplot(Emissions ~ year | EI.Sector, 
       data = emissionData, 
       groups = EI.Sector,
       xlab = "", 
       ylab = "Total emissions (in tons)", 
       main = "Emissions by Motor Vehicle Type:  Baltimore (1999-2008)") 
#
# Write the plot
dev.off()