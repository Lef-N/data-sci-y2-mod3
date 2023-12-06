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
  
  
  sidebarLayout(
    sidebarPanel(
      
      div(icon("filter"), "Filters",
          style = "font-size: calc(1.325rem + 0.9vw); font-weight: 000;
            color: white; background-color: #12436D;
            margin-top: -3.5%;
            padding-right: 10%; padding-left: 10%;
            vertical-align: text-bottom; padding-bottom: 1%; padding-top: 1%;"),
      
      fluidRow(
        
        column(12,
               selectInput("year_sold",
                           label = "Year Built:",
                           choices = c("All",
                                       unique(ames$yr_sold)[order(unique(ames$yr_sold))]),
                           selected = "All"),
        )),
      
      ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      pickerInput(
        'y',
        selected = c("mean"),
        choices = list(
          "mean", "mode", "median"), multiple = TRUE,
        options = list(create = TRUE,
                       `actions-box` = TRUE)),
    
      plotlyOutput("testPlot")
    )
  )
))
