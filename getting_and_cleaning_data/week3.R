###################
#Data Manipulation#
###################
quantile(seq(1, 100, 3))
quantile(seq(1, 100, 3), probs = c(0.5, 0.75, 0.9))
#Have missing values included
table(seq(1, 100, 3), useNA = 'ifany')

#Checking nas for each column:
colSums(is.na(airquality))
all(colSums(is.na(airquality)) == 0)

#Cross tab
DF <- as.data.frame(UCBAdmissions)
xt <- xtabs(Freq ~ Gender + Admit, data = DF)

#Assigning binary variable
car <- mtcars
car$HighHP <- ifelse(car$hp >= 100, T, F)

#Cut based on numerical value intervals (Creating factor variable)
hpGroup <- cut(car$hp, breaks = quantile(car$hp))
table(hpGroup)
table(hpGroup, car$hp)
#Easier cut
require(Hmisc)
cut2(car$hp, g = 4)

#Creating factor
gearf <- factor(mtcars$gear)
gearf

#Using mutate function
require(plyr)
carData <- mutate(mtcars, gearf)

#Data reshaping
require(reshape2)
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c('carname', 'gear', 'cyl'), measure.vars = c('mpg', 'hp'))
cylData <- dcast(carMelt, cyl ~ variable)
cylData <- dcast(carMelt, cyl ~ variable, mean)

#Averaging values
InsectSprays
tapply(InsectSprays$count, InsectSprays$spray, sum)
#Split calculate combine
spIns <- split(InsectSprays$count, InsectSprays$spray)
sprCount <- lapply(spIns, sum)
unlist(sprCount)
sapply(spIns, sum)
ddply(InsectSprays, .(spray), summarize, sum = sum(count))

#Using dplyr to manipulate data frame
require(dplyr)
names(airquality)
#Select with
head(select(airquality, Ozone:Wind))
#Select without
head(select(airquality, -(Ozone:Wind)))
airquality.f <- filter(airquality, Ozone > 20)
airquality.f <- filter(airquality, Ozone > 20 & Wind > 10)
#Sort table by specific column (Default ascending)
airData <- arrange(airquality, Temp)
#Sort table by specific column in descending
airData <- arrange(airquality, desc(Temp))
#Rename column names
airData <- rename(airData, Ozone.level = Ozone, Date = Day)
#Mutate column
airData <- mutate(airData, Ozone.level.log = log(Ozone.level))
#Group by
airData <- mutate(airData, windcat = factor((Wind > 10), labels = c('low', 'high')))
lowhigh <- group_by(airData, windcat)
summarise(lowhigh, Wind = mean(Wind, na.rm = T), Solar = max(Solar.R))

#Quiz
#Q1
housingData <- read.csv('housing2006.csv', sep = ',')
agricultureLogical <- ifelse((housingData$ACR == 3 & housingData$AGS == 6), T, F)
which(agricultureLogical)
#Q2
require(jpeg)
pic <- readJPEG('jeff.jpg', native = TRUE)
quantile(pic)
#Q3
countryDB <- read.csv('getdata%2Fdata%2FEDSTATS_Country.csv', sep = ',')
countryGDP <- read.csv('getdata%2Fdata%2FGDP.csv', sep = ',', skip = 3)
colnames(countryGDP)[1] <- 'CountryCode'
countryGDP <- countryGDP[2:191, 1:5]
countryGDP <- mutate(countryGDP, Ranking = as.numeric(levels(countryGDP$Ranking))[countryGDP$Ranking])
GDPMerged <- merge(countryGDP, countryDB, by = 'CountryCode')
GDPMerged <- arrange(GDPMerged, desc(Ranking))
#Q4
require(dplyr)
GDPMerged <- group_by(GDPMerged, Income.Group)
summarise(GDPMerged, avg = mean(Ranking, na.rm = T))
#Q5
require(Hmisc)
GDPRankingGroup <- cut2(GDPMerged$Ranking, g = 5)
table(GDPRankingGroup, GDPMerged$Income.Group)



