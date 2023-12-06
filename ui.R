#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  
  titlePanel(h1("Data Visualisation - R Shiny", align = "center",
                style = "font-weight: 500; color: white; background-color: #12436D; padding-top: 10px;
                  padding-bottom: 10px;")),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      pickerInput(
        inputId = "foundation", 
        label = "Foundation type", 
        choices = unique(ames$foundation),
        multiple = FALSE
      ),
    
      plotOutput("price_by_foundation_ts")
    )
  )
)
