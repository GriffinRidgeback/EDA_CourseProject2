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
# need plyr, dplyr for this work
library(plyr)
library(dplyr)
#
# Select only data for FIPS 24510 (Baltimore City)
baltimore <- NEI[NEI$fips == "24510", ]
#
# Select only the columns we need prior to performing join
NEIsubset <- select(baltimore, SCC, Emissions, year)
SCCsubset <- select(SCC, SCC, starts_with("EI", ignore.case = F))
#
# Now join based on mutual key SCC
bigData  <- plyr::join(NEIsubset, SCCsubset, by = "SCC", match = "all")
#
# Now subset the dataframe based on "Coal" entries in the Level.Three and Level.Four columns
emissionData  <- bigData[grepl("Mobile", bigData$EI.Sector), ]
# 
# Section Three: plot the data ----
#
# Set up the graphics device
png("plot5.png")
# 
# Set up the plot:
qplot(year, Emissions, data = emissionData, xlab = "", facets = EI.Sector ~ .)
#
# Write the plot
dev.off()