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
# Select indices of only coal-related combustion sources
# Source: http://www.epa.gov/otaq/
coal  <- grep("^fuel comb -(.*)- coal$", SCC$EI.Sector, ignore.case = T)
#
# Select only coal-related SCCs
coalSCC  <- SCC[coal, c("SCC", "EI.Sector")]
#
# Subset the NEI data for just coal-related emissions
#emissionData  <- NEI[NEI$SCC %in% coalSCC$SCC, ]
emissionData  <- join(NEI, coalSCC, by = "SCC", type = "inner")
#
# Section Three: plot the data ----
#
# Set up the graphics device
png("plot4.png", width = 1080, height = 480)
# 
# Set up the plot:
#
# visualize emissions by year
# condition by type of coal combustion
xyplot(Emissions ~ year | EI.Sector, 
       data = emissionData, 
       groups = EI.Sector,
       xlab = "", 
       ylab = "Total emissions (in tons)", 
       main = "Emissions by Coal Combustion: US (1999-2008)") 
#
# Write the plot
dev.off()