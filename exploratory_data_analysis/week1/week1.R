#################################
#Principles of analytical graphs#
#################################

#1. Graph should demonstrate sufficient comparison
#   - Evidence for a hypothesis is always relative to another competing hypothesis
#   - Always ask "compared to What?"
#2. Show causality, mechanism, explanation, systematic structure
#   - What is your causal framwork for thinking about a question?
#3. Show multivariate data
#   - Multivariate = more than 2 variables
#   - The real world is multivariate
#   - Need to "escape flatland"
#4. Integration of evidence
#   - Completely integrate words, numbers, images, diagrams
#   - Data graphics should make use of many modes of data presentation
#   - Don't let the tool drive the analysis
#5. Describe and document the evidence with appropriate labesl ,scales, souces
#   - A data graphic should tell a complete story that ios credible
#6. Content is king
#   - Analytical presentations ultimately stand of fall depending on the quality, relevance, and integrity of their content

####################
#Exploratory graphs#
####################

#One dimentional summary:

#Five-number summary
summary(airquality$Temp)
#Boxplots
boxplot(airquality$Temp, col = 'blue')
#Histograms
hist(airquality$Temp, col = 'green', breaks = 100)
abline(v = 80, lwd = 2)
abline(v = median(airquality$Temp), col = 'magenta', lwd = 4)
rug(airquality$Temp)
#Density plot
#Barplot
barplot(table(airquality$Month), col = 'wheat', main = 'Number of Observations in Each Month')

#Two dimentional summary:

#Multiple Boxplots
boxplot(Temp ~ Month, data = airquality, col = 'red')
#Multiple Histograms
par(mfrow = c(2,1), mar = c(4,4,2,1))
hist(subset(airquality, Month == 5)$Temp, col = 'green')
hist(subset(airquality, Month == 7)$Temp, col = 'green')
#Scatterplot
with(airquality, plot(Solar.R, Ozone))
abline(h = 25, lwd = 2, lty = 2)
#Adding color as a dimension
with(airquality, plot(Solar.R, Ozone, col = Month))
abline(h = 25, lwd = 2, lty = 2)
#Multiple Scatterplots
par(mfrow = c(1,2), mar = c(5,4,2,1))
with(subset(airquality, Month = 5), plot(Solar.R, Ozone, main = 5))
with(subset(airquality, Month = 7), plot(Solar.R, Ozone, main = 7))

##########
#Plotting#
##########

#Base Plot

with(cars, plot(speed, dist))
require(lattice)
xyplot(mpg ~ hp | cyl, data = mtcars, layout = c(3,1))
require(ggplot2)
qplot(displ, hwy, data = mpg)

airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality)

#Some main plot parameters:
#pch: plotting symbol (default is open circle)
#lty: the line type (default is solid line), can be dashed, dotted...
#lwd: the line width, specified as an integer multiple
#col: the plotting color, specified as a number, string, or hex code; the colors() function gives you a vector of colors by name
#xlab: character string for the x-axis label
#ylab: character string for the y-axis label

#par() and its arguments:
#las: the orientation of the axis labels on the plot
#bg: the background color
#mar: the margin size
#oma: the outer margin size (default is 0 for all sides)
#mfrow: number of plots per row, column (plots are filled row-wise)
#mfcol: number of plots per row, column (plots are filled column-wise)
par('mar') #check for default
par(mar = c(5.1, 4.1, 4.1, 2.1))

#Base Plotting Functions

#plot: scatterplot
#lines: add lines to a plot
#points: add points to a plot
#text: add text labels
#title: add annotations to x, y axis
#mtext: add arbitrary text
#axis: adding axis

with(airquality, plot(Wind, Ozone, main = 'Ozone and Wind in New York City'))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = 'blue'))

with(airquality, plot(Wind, Ozone, main = 'Ozone and Wind in New York City', type = 'n'))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = 'blue'))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = 'red'))
legend('topright', pch = 1, col = c('blue', 'red'), legend = c('May', 'Other Months'))

with(airquality, plot(Wind, Ozone, main = 'Ozone and Wind in New York City', pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)

par(mfrow = c(1,2))
with(airquality, {
  plot(Wind, Ozone, main = 'Ozone and Wind')
  plot(Solar.R, Ozone, main = 'Ozone and Solor Radiation')
})

par(mfrow = c(1,3), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(airquality, {
  plot(Wind, Ozone, main = 'Ozone and Wind')
  plot(Solar.R, Ozone, main = 'Ozone and Solar Radiation')
  plot(Temp, Ozone, main = 'Ozone and Temperature')
  mtext('Ozone and weather in New York City', outer = T)
})












































