library(shiny)
require(caret)
require(randomForest)
require(e1071)

trControl <- trainControl(method = 'cv', number = 10)
fit_rf <- train(Species ~ ., 
                method = 'rf',
                data = iris,
                trControl = trControl)

shinyServer(function(input, output) {
    
    output$pred_rf <- renderPrint(
        
        as.character(predict(fit_rf$finalModel, 
                             newdata = data.frame(Sepal.Length = input$Sp.lth,
                                                  Sepal.Width = input$Sp.wth,
                                                  Petal.Length = input$Pt.lth,
                                                  Petal.Width = input$Pt.wth)))
        )
    
    output$hist.sp.l <- renderPlot({
        
        hist(iris$Sepal.Length, breaks = input$bins, main = '', xlab = '', col = 'coral1', 
             xlim = c(min(iris$Sepal.Length)-1, max(iris$Sepal.Length)+1))
        abline(v = input$Sp.lth, lty = 1, lwd = 3)
        legend('topright', lty = 1, lwd = 3, col = 'black', legend = 'Your Input', cex = 1.2)
        
        })
    
    output$hist.sp.w <- renderPlot({
        
        hist(iris$Sepal.Width, breaks = input$bins, main = '', xlab = '', col = 'darkorchid',
             xlim = c(min(iris$Sepal.Width)-1, max(iris$Sepal.Width)+1))
        abline(v = input$Sp.wth, lty = 1, lwd = 3)
        legend('topright', lty = 1, lwd = 3, col = 'black', legend = 'Your Input', cex = 1.2)
        
    })
    
    output$hist.pt.l <- renderPlot({
        
        hist(iris$Petal.Length, breaks = input$bins, main = '', xlab = '', col = 'darkseagreen',
             xlim = c(min(iris$Petal.Length)-1, max(iris$Petal.Length)+1))
        abline(v = input$Pt.lth, lty = 1, lwd = 3)
        legend('topright', lty = 1, lwd = 3, col = 'black', legend = 'Your Input', cex = 1.2)
        
    })
    
    output$hist.pt.w <- renderPlot({
        
        hist(iris$Petal.Width, breaks = input$bins, main = '', xlab = '', col = 'forestgreen',
             xlim = c(min(iris$Petal.Width)-1, max(iris$Petal.Width)+1))
        abline(v = input$Pt.wth, lty = 1, lwd = 3)
        legend('topright', lty = 1, lwd = 3, col = 'black', legend = 'Your Input', cex = 1.2)
        
    })
    
})










