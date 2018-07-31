library(shiny)

shinyUI(fluidPage(
        
    titlePanel('Word Predictor'),
    
    sidebarLayout(
        
        sidebarPanel(
            
            em('This app uses an N-Gram model to predict/suggest for the next word given the previous content you have typed. 
               By default, the model searches for the most probable next word in a 4-gram table. The Backoff technique is 
               added to the model to make sure that the predictor will take one step down to use lower gram when there is
               no match in the current gram.'),
            textInput('sentence', 'Please enter a sentence:')
            
        ),
        
        mainPanel(
            
            h3('Next word suggestion:'),
            textOutput('text1')
            
        )
    )
))