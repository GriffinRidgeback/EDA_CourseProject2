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
# Select only the columns we need prior to performing join
NEIsubset <- select(NEI, SCC, Emissions, year)
SCCsubset <- select(SCC, starts_with("SCC", ignore.case = F))
#
# Delete Level.Two - no data of interest there
SCCsubset <- select(SCCsubset, -SCC.Level.Two)
#
# Now join based on mutual key SCC
bigData  <- plyr::join(NEIsubset, SCCsubset, by = "SCC", match = "all")
#
# Filter out anything not "External Combustion Boilers" because,
# according to the codebook for the SCC data (http://www.nj.gov/dep/aqm/es/scc.pdf),
# the only SCC.Level.One values that pertain to coal-related combustion are to be
# found only in "Internal Combustion Engines"
bigData <- filter(bigData, SCC.Level.One == "External Combustion Boilers")
#
# Put things in order
bigData  <- arrange(bigData, SCC)
#
# Now subset the dataframe based on "Coal" entries in the Level.Three and Level.Four columns
emissionData  <- bigData[grepl("Coal", bigData$SCC.Level.Three) | grepl("Coal", bigData$SCC.Level.Four), ]
# 
# Section Three: plot the data ----
#
# Set up the graphics device
png("plot4.png")
# 
# Set up the plot:
with(emissionData, plot(year, Emissions, xlab = "", ylim = c(0, 14500), main = "Coal combustion emissions (US Totals)"))
#
# Write the plot
dev.off()