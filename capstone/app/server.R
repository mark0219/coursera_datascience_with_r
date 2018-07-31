library(shiny)
library(dplyr)

load('twoGram.RData')
load('threeGram.RData')
load('fourGram.RData')
load('fiveGram.RData')

twoGram <- mutate(twoGram, term = as.character(term))
threeGram <- mutate(threeGram, term = as.character(term))
fourGram <- mutate(fourGram, term = as.character(term))
fiveGram <- mutate(fiveGram, term = as.character(term))

predictWord <- function(sentence) {
    
    sentence <- tolower(sentence)
    sentence <- trimws(gsub('[[:punct:] ]+', ' ', sentence))
    sentence <- unlist(strsplit(sentence, split = ' '))
    sentenceLength <- length(sentence)
    
    ngramFound <- FALSE
    
    ###Search from fiveGram###
    if (sentenceLength >= 4 & !ngramFound) {
        
        searchPattern <- paste(sentence[(sentenceLength-3):sentenceLength], collapse = ' ')
        searchPattern <- paste('^', searchPattern, sep = '')
        candidatesIdx <- grep(searchPattern, fiveGram$term)
        
        if (length(candidatesIdx) >= 1) {
            
            lastWordIdx <- intersect(which(fiveGram$frequency == max(fiveGram[candidatesIdx,]$frequency)), 
                                     grep(searchPattern, fiveGram$term))
            finalLine <- fiveGram[lastWordIdx,1]
            wordPred <- unlist(strsplit(finalLine, ' '))[length(unlist(strsplit(finalLine, ' ')))]
            
            ngramFound <- TRUE
            return(wordPred)
            
        }
    }
    
    ###Search from fourGram###
    if (sentenceLength >= 3 & !ngramFound) {
        
        searchPattern <- paste(sentence[(sentenceLength-2):sentenceLength], collapse = ' ')
        searchPattern <- paste('^', searchPattern, sep = '')
        candidatesIdx <- grep(searchPattern, fourGram$term)
        
        if (length(candidatesIdx) >= 1) {
            
            lastWordIdx <- intersect(which(fourGram$frequency == max(fourGram[candidatesIdx,]$frequency)), 
                                     grep(searchPattern, fourGram$term))
            finalLine <- fourGram[lastWordIdx,1]
            wordPred <- unlist(strsplit(finalLine, ' '))[length(unlist(strsplit(finalLine, ' ')))]
            
            ngramFound <- TRUE
            return(wordPred)
            
        }
    }
    
    ###Search from threeGram###
    if (sentenceLength >= 2 & !ngramFound) {
        
        searchPattern <- paste(sentence[(sentenceLength-1):sentenceLength], collapse = ' ')
        searchPattern <- paste('^', searchPattern, sep = '')
        candidatesIdx <- grep(searchPattern, threeGram$term)
        
        if (length(candidatesIdx) >= 1) {
            
            lastWordIdx <- intersect(which(threeGram$frequency == max(threeGram[candidatesIdx,]$frequency)), 
                                     grep(searchPattern, threeGram$term))
            finalLine <- threeGram[lastWordIdx,1]
            wordPred <- unlist(strsplit(finalLine, ' '))[length(unlist(strsplit(finalLine, ' ')))]
            
            ngramFound <- TRUE
            return(wordPred)
            
        }
    }
    
    ###Search from twoGram###
    if (sentenceLength >= 1 & !ngramFound) {
        
        searchPattern <- sentence[sentenceLength]
        searchPattern <- paste('^', searchPattern, sep = '')
        candidatesIdx <- grep(searchPattern, twoGram$term)
        
        if (length(candidatesIdx) >= 1) {
            
            lastWordIdx <- intersect(which(twoGram$frequency == max(twoGram[candidatesIdx,]$frequency)), 
                                     grep(searchPattern, twoGram$term))
            finalLine <- twoGram[lastWordIdx,1]
            wordPred <- unlist(strsplit(finalLine, ' '))[length(unlist(strsplit(finalLine, ' ')))]
            
            ngramFound <- TRUE
            return(wordPred)
            
        }
    }
}

shinyServer(function(input, output) {
    
    wordPred <- reactive({
        sentenceInput <- input$sentence
        predictWord(sentenceInput)
    })
    
    output$text1 <- renderText({
        wordPred()
    })
})
