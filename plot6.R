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
# Setup up selection criteria
criteria <- c("fips", "SCC", "Emissions", "year")
#
# Select data for FIPS 24510 (Baltimore City)
baltimore <- NEI[NEI$fips == "24510", criteria]
#
# Select data for FIPS 06037 (Los Angeles)
losangeles <- NEI[NEI$fips == "06037", criteria]
#
# Convert FIPS to factors to aid in plotting
baltimore$fips <- as.factor("Baltimore")
losangeles$fips <- as.factor("Los Angeles")
#
# Combine the city data
cityData <- rbind(baltimore, losangeles)
#
# Extract only those entries that define motor vehicle emissions
# Source: http://www.epa.gov/otaq/hwy.htm
mobile  <- grep("^Mobile -(.*)Road(.*)", SCC$EI.Sector, ignore.case = T)
#
# Subset the SCC data based on those indices
mobileSCC  <- SCC[mobile, c("SCC", "EI.Sector")]
#
# Join the two datasets by their common key SCC
emissionData  <- join(cityData, mobileSCC, by = "SCC", type = "inner")
# 
# Section Three: plot the data ----
#
# Set up the graphics device
png("plot6.png", width = 2160, height = 720)
# 
# Set up the plot:
#
# visualize emissions by year; condition
# by type of motor vehicle for each city
#
# y-axis limits were set because of the 
# wide disparity between the emission
# measurements of both cities.  A smaller
# range for y-values gives more visibility
# to the emissions measurements of Baltimore
# and hopefully provides a more meaningful
# comparison to those for Los Angeles.
xyplot(Emissions ~ year | EI.Sector + fips, 
       data = emissionData, 
       groups = fips,
       xlab = "", 
       ylim = c(0, 20),
       ylab = "Total emissions (in tons)", 
       main = "Emissions by Motor Vehicle Type:  Baltimore vs. Los Angeles (1999-2008)")
#
# Write the plot
dev.off()