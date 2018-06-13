#######################
#Editing Text Variable#
#######################
fileUrl <- 'http://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD'
download.file(fileUrl, destfile = 'cameras.csv')
cameraData <- read.csv('cameras.csv')
names(cameraData)
#convert all variable names to lower
tolower(names(cameraData))
splitNames <- strsplit(names(cameraData), '\\.')
splitNames
#Quick aside list
mylist <- list(letters = c('A', 'b', 'c'), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)
splitNames[[6]][1]
#Taking out only first element in each item from a list
firstElement <- function(x) {x[1]}
sapply(splitNames, firstElement)
#Finding values
grep('Alameda', cameraData$intersection)
table(grepl('Alameda', cameraData$intersection))
cameraData2 <- cameraData[!grepl('Alameda', cameraData$intersection),]
grep('Alameda', cameraData$intersection, value = T)
grep('JeffStreet', cameraData$intersection)
#More useful string function
require(stringr)
nchar('Jeffrey Leek')
substr('Jeffrey Leek', 1, 7)
paste('Jeffrey', 'Leek')
paste0('Jeffrey', 'Leek')
#Strip away white spaces
str_trim('  Jeff   ')

####################
#Regular Expression#
####################
#Normally used with grep, grepl, sub, gsub
#Match all sentense begins with "i think"
'^i think'
#Match all lines end with "morning"
'morning$'
#Match all version of the word "Busg/bush"
'[Bb]][Uu][Ss][Hh]'
#Match lines begin with "I/i am"
'[Ii] am'
#Match range of letters of numbers either capical case or lower case
'^[0-9][a-zA-Z]'
#Match lines end with either anything other than ? or .
'[^?.]$'
#. matches for any character
#flood|fire matches any line with either flood or fire word in the line
'flood|fire'
#multiple words
'flood|earthquake|hurricane|coldfire'
#Match all lines begin with Good/good, or anywhere in the line with a Bad/bad
'^[Gg]ood|[Bb]ad'
#Match all lines begin with Good/good or Bad/bad
'^([Gg]ood|[Bb]ad)'
#A question mark follows the () indicates optional contents to be matched (By adding the \ in front of the . to specify . as a character rather than
#a wildcard)
'[Gg]eorge( [Ww]\.)? [Bb]ush'
#* indicates any number of repetition.
#This one matches lines with () either have contents in it or no content at all
'(.*)'
'anyone wanna chat? (24, m, germany)'
'hello, 20.m here... ( east area + drives + webcam )'
'()'
#+ matches for something occurs at least once
'[0-9]+ (.*)[0-9]+'
#{} specify number of times occur
#Matches lines with 1 - 5 characters between Bush and debate
'[Bb]ush( + [^ ]+ +){1,5} debate'

###################
#Working with Date#
###################
d1 <- date()
d1
d2 <- Sys.Date()
d2
#%d = day as number (0-31), %a = abbreviated weekday, %A = unabbreviated weekday, %m = month (00 - 12), %b = abbreviated month, %y = 2 digit year
#%Y = four digit year
format(d2, '%a %b %d')
x <- c('1jan1960', '2jan1960', '31mar1960', '30jul1960')
z <- as.Date(x, '%d%b%Y')
z
z[1] - z[2]
as.numeric(z[1] - z[2])
weekdays(d2)
months(d2)
julian(d2)
require(lubridate)
ymd('20140108')
mdy('08/04/2013')
dmy('03-04-2013')
ymd_hms('2011-08-03 10:15:03')
ymd_hms('2011-08-03 10:15:03', tz = 'Pacific/Auckland')
x <- dmy(c('1jan2013', '2jan2013', '31mar2013', '30jul2013'))
wday(x[1])
wday(x[1], label = T)

#Quiz
#Q1
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(fileUrl, destfile = 'quizq1Data.csv')
quizData <- read.csv('quizq1Data.csv')
strsplit(names(quizData), split = 'wgtp')[[123]]
#Q2
require(stringr)
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
download.file(fileUrl, destfile = 'quizq2Data.csv')
quizData <- read.csv('quizq2Data.csv')
GDPColumn <- quizData[5:194,5]
GDPColumn <- as.character(GDPColumn)
GDPColumn <- GDPColumn[(GDPColumn != "..") & (GDPColumn != "")]
GDPColumn <- str_trim(GDPColumn)
GDPColumn <- as.numeric(gsub(',', '', GDPColumn))
mean(GDPColumn)
#Q3
countryNames <- quizData[, 4]
countryNames[grep('^United', countryNames)]
#Q4
url1 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
url2 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
download.file(url1, destfile = 'CountryGDP.csv')
download.file(url2, destfile = 'CountryDB.csv')
countryGDP <- read.csv('CountryGDP.csv')
countryDB <- read.csv('CountryDB.csv')
countryGDP <- countryGDP[5:194, 1:5]
colnames(countryGDP)[1] <- 'CountryCode'
tableMerged <- merge(x = countryGDP, y = countryDB, by = 'CountryCode')
fiscalNote <- tableMerged$Special.Notes
length(grep('^Fiscal year end: June', fiscalNote))
#Q5
require(quantmod)
amzn <- getSymbols("AMZN", auto.assign = FALSE)
sampleTimes <- index(amzn)
length(sampleTimes[format(sampleTimes, '%Y') == 2012])
length(sampleTimes[(format(sampleTimes, '%Y') == 2012) & (weekdays(sampleTimes) == 'Monday')])
