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

    titlePanel("Test title"),

    sidebarLayout(
        sidebarPanel(
        ),

        # Show a plot of the generated distribution
        mainPanel(
          selectInput(
            "y", "Type of average", c("mean", "mode", "median"), "mean"),
            plotlyOutput("testPlot")
        )
    )
))
