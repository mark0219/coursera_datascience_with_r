library(shiny)

shinyUI(fluidPage(
    
    titlePanel('Smart Iris Classifier'),
    
    sidebarLayout(
        sidebarPanel(
            
            h4('Read First!'),
            em('This app classifies the species of Iris. To use this classifier, users need to type the 4 \
               measurements into each box (notice the different value range for each box) then click \'submit\' button and the\
               result will show below the \'I think it is:\'. Additionally, in the main panel section, every tab has a histogram \
               shows the distribution of one measurement from our sampled iris dataset. The vertical black line indicates the value
               given by the user, so that you can see where the sample you are classifying would be located in our sample space. The \
               bin of each histogram is adjustable with the slider on the bottom of the sidebar panel.'),
            
            numericInput('Sp.lth', 'Please input the sepal length (4.3 - 7.9)',
                         value = 5, min = 4.3, max = 7.9, step = 0.1),
            numericInput('Sp.wth', 'Please input the sepal width (2 - 4.4)',
                         value = 3, min = 2, max = 4.4, step = 0.1),
            numericInput('Pt.lth', 'Please input the petal length (1 - 6.9)',
                         value = 4, min = 1, max = 6.9, step = 0.1),
            numericInput('Pt.wth', 'Please input the petal width (0.1 - 2.5)',
                         value = 1.5, min = 0.1, max = 2.5, step = 0.1),
            sliderInput('bins', 'Bin width adjustment', 
                        value = 20, min = 1, max = 30),
            submitButton('Submit')
            
        ),

        mainPanel(
            
            h2('I think it is:'),
            verbatimTextOutput('pred_rf'),
            
            tabsetPanel(
                tabPanel('Sepal Length', plotOutput('hist.sp.l')),
                tabPanel('Sepal Width', plotOutput('hist.sp.w')),
                tabPanel('Petal Length', plotOutput('hist.pt.l')),
                tabPanel('Petal Width', plotOutput('hist.pt.w'))
            )
        )
    )
))

