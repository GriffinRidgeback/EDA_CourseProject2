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
# need plyr, dplyr, ggplot2 for this work
library(plyr)
library(dplyr)
library(ggplot2)
#
# Select data for FIPS 24510 (Baltimore City)
baltimore <- NEI[NEI$fips == "24510", ]
#
# Select data for FIPS 06037 (Los Angeles)
losangeles <- NEI[NEI$fips == "06037", ]
#
# Select only the columns we need prior to performing join
baltimoreSubset <- select(baltimore, fips, SCC, Emissions, year)
losangelesSubset <- select(losangeles, fips, SCC, Emissions, year)
SCCsubset <- select(SCC, SCC, starts_with("EI", ignore.case = F))
#
# Convert FIPS to factors to aid in plotting
baltimoreSubset$fips <- as.factor("Baltimore")
losangelesSubset$fips <- as.factor("Los Angeles")
#
# Combine the city data
cityData <- rbind(baltimoreSubset, losangelesSubset)
#
# Now join based on mutual key SCC
bigData  <- plyr::join(cityData, SCCsubset, by = "SCC", match = "all")
#
# Now subset the dataframe based on "Mobile" entries in the EI.Sector column
emissionData  <- bigData[grepl("Mobile", bigData$EI.Sector), ]
# 
# Section Three: plot the data ----
#
# Set up the graphics device
png("plot6.png")
# 
# Set up the plot:
qplot(year, Emissions, data = emissionData, xlab = "", facets = . ~ fips)
#
# Write the plot
dev.off()