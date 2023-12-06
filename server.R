#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # ames <- reactive({
  #   
  #   data <- ames %>%
  #     filter(
  #       yr_sold %in% input$year_sold
  #     )
  #   
  #   return(data)
  #   
  # })
  
  
  output$testPlot <- plotly::renderPlotly({
    
    av_price_grps <- ames %>%
      group_by(year_group) %>%
      summarise(mean = mean(sale_price),
                mode = getmode(sale_price),
                median = median(sale_price),
                count = n())
    
    plot_average(av_price_grps, year_group, input$y)
    
  })
  
})
