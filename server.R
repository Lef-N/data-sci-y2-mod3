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
  
  get_data <- reactive({

    data <- ames

    if (input$year_sold != "All"){
      data <-
        data %>%
        filter(yr_sold == input$year_sold)
    }

    return(data)

  })

  
  output$testPlot <- plotly::renderPlotly({
    
    plot <- get_data() %>%
      group_by(year_group) %>%
      summarise(mean = mean(sale_price),
                mode = getmode(sale_price),
                median = median(sale_price),
                count = n()) %>%
      plot_average(., year_group, input$y)
    
  })
  
})
  
})
