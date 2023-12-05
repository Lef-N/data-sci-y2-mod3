# mode
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# average plot function
plot_average <- function(data, x, y) {
  
  
  
  plot <- ggplot(data, aes(x = {{ x }},
                     group = 1,
                     text = paste0("Number of houses = ", count))) +
    geom_point(aes(y = .data[[y]]), colour = "orange") + 
    geom_line(aes(y = .data[[y]]), colour = "orange") +
    theme_bw() +
    labs(x = "Year group",
         y = paste0("Average (", y, ")"))
  
 plotly::ggplotly(plot, tooltip = "text")


}
