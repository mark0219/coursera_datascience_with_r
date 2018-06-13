#Include a code book that explains detail about each column (Word/r-markdown)
#Keep record (script) for all the steps taken from raw data to tidy data
#Instruction list

##################
#Downloading file#
##################

#Gets working dir
getwd()

#Relative set wd
setwd("./data")

#Checking for and creating dir
if (!file.exists('data')) {
  dir.create('data')
}
fileUrl <- 'http://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD'
download.file(fileUrl, destfile = './data/cameras.csv')
list.files('./data')
dateDownloaded <- date()
dateDownloaded

#Reading file
cameraData <- read.table('./data/cameras.csv', sep = ',', header = T)
#quote = "" removes quotation marks

#read excel file
fileUrl <- 'http://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD&bom=true&format=true'
download.file(fileUrl, destfile = './data/cameras.xlsx')
#read.xlsx2 is faster

#read XML
require(XML)
fileUrl <- 'http://www.w3schools.com/xml/simple.xml'
download.file(fileUrl, destfile = 'simple.xml')
doc <- xmlTreeParse(file = 'simple.xml', useInternalNodes = T)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]]     #Access first element in an xml
rootNode[[1]][[1]]
xmlSApply(rootNode, xmlValue)
#XPath lecture: http://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf
#/node: Top level node
#//node: Node at any level
#node[@attr-name]: Node with an attribute name
#node[@attr-name='bob']:Node with attribute name attr-name='bob'
#Extract all the xml values with a node tag "name"
xpathSApply(rootNode, '//name', xmlValue)
#Extract all the xml values with a node tag "price"
xpathSApply(rootNode, '//price', xmlValue)
fileUrl <- 'http://www.espn.com/nfl/team/_/name/bal/baltimore-ravens'
doc <- htmlTreeParse(fileUrl, useInternalNodes = T)
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)

#read JSON
require(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
#converting table to JSON format
myjson <- toJSON(iris, pretty = T)
cat(myjson)
iris2 <- fromJSON(myjson)
head(iris2)

#data.table
require(data.table)
DF <- data.frame(x = rnorm(9), y = rep(c('a', 'b', 'c'), each = 3), z = rnorm(9))
head(DF, 3)
DT <- data.table(x = rnorm(9), y = rep(c('a', 'b', 'c'), each = 3), z = rnorm(9))
head(DF, 3)
tables()
DT[2,]
DT[DT$y == 'a',]
{
  x = 1
  y = 2
}
k = {print(10); 5}
print(k)
#Columns calculation
DT[,list(mean(x), sum(z))]
DT[,table(y)]
#Add new column
DT[,w:=z^2]
#If we want to create a duplicate of DT, use copy function instead of assigning directly!!!
DT2 <- copy(DT)
#Multi-steps
DT[,m:= {tmp <- (x+z); log2(tmp+5)}]
#Add logical column
DT[,a:=x>0]
#plyr like operations
DT[,b:=mean(x+w),by=a]
#special variables
set.seed(0871)
DT <- data.table(x = sample(letters[1:3], 1E5, T))
#Count
DT[, .N, by = x]
#Keys
DT <- data.table(x = rep(c('a', 'b', 'c'), each = 100), y = rnorm(300))
#Setting key of the table to be the variable x
setkey(DT, x)
#Subset by key
DT['a']
#Joins by using key
DT1 <- data.table(x = c('a', 'a', 'b', 'dt1'), y = 1:4)
DT2 <- data.table(x = c('a', 'b', 'dt2'), z = 5:7)
setkey(DT1, x)
setkey(DT2, x)
#Merge by key
merge(DT1, DT2)

#Quiz
#Q1
#How many properties worth more than $1,000,000?
myTable <- read.csv('week1_quiz.csv', sep = ',')
nrow(myTable[myTable$VAL == 24,])
#Q3
#Read row 18-23, col 7-15
dat <- read.xlsx('week1_quiz.xlsx', sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)
#Q4
#Read xml file, how many restaruants has zip 21231?
require(XML)
xmlRead <- xmlParse('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml')
zips <- xpathSApply(xmlRead, '//zipcode', xmlValue)
length(zips[zips == '21231'])
#Q5
require(data.table)
DT <- fread('big_dataset.csv', sep = ',')
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time({rowMeans(DT)[DT$SEX==1];rowMeans(DT)[DT$SEX==2]})
system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
system.time(tapply(DT$pwgtp15,DT$SEX,mean))




