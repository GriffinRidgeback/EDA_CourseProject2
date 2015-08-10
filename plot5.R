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
# Extract only those entries that define motor vehicle emissions
mobile  <- grep("^Mobile -(.*)Road(.*)", SCC$EI.Sector, ignore.case = T)
#
# Subset the SCC data based on those indices
mobileSCC  <- SCC[mobile, ]
#
# Subset the Baltimore data based on the SCCs for motor vehicle emissions
emissionData  <- baltimore[baltimore$SCC %in% mobileSCC$SCC, ]
# 
# Section Three: plot the data ----
#
# Load the ggplot2 library
#
library(ggplot2)
#
# Set up the graphics device
png("plot5.png")
# 
# Set up the plot:
qplot(year, Emissions, data = emissionData, xlab = "", ylab = "Total emissions (in tons)", main = "Motor Vehicle Emissions (Baltimore)")
#
# Write the plot
dev.off()