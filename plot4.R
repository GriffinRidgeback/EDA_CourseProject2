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
# Select indices of only coal-related combustion sources
coal  <- grep("^fuel comb -(.*)- coal$", SCC$EI.Sector, ignore.case = T)
#
# Select only coal-related SCCs
coalSCC  <- SCC[coal, ]
#
# Subset the NEI data for just coal-related emissions
emissionData  <- NEI[NEI$SCC %in% coalSCC$SCC, ]
#
# Section Three: plot the data ----
#
# Set up the graphics device
png("plot4.png")
# 
# Set up the plot:
with(emissionData, 
     plot(year, 
          Emissions, 
          xlab = "", 
          ylab = "Total emissions (tons)", 
          ylim = c(0, 14500), 
          main = "Emissions from coal combustion sources:  US (1999-2008))"))
#
# Write the plot
dev.off()