#### Load packages ------------------------------------------------------------
library(dplyr)
library(ggplot2)
library(GGally)
library(corrplot)
source("functions.R")

#### Processing ---------------------------------------------------------------
ames_raw <- readr::read_csv("ames.csv") %>%
  janitor::clean_names() %>%
  select(lot_area,             
         land_contour,  
         house_style,     
         overall_qual,     
         overall_cond,   
         year_built,         
         year_remod_add,           
         exterior_1st,     
         exterior_2nd,
         foundation,       
         bedroom_abv_gr,
         tot_rms_abv_grd,
         garage_type,    
         pool_area,         
         yr_sold,
         sale_price)

#check_missing <- summarise(ames_raw, across(everything(), ~ sum(is.na(.))))

ames <- ames_raw %>%
  mutate(garage = ifelse(is.na(garage_type), "No garage", "Garage"),
         has_pool = ifelse(pool_area == 0, "No pool", "Pool"),
         year_group = cut(
           year_built,
           breaks = c(seq(1850, 2025, by = 25)),
           labels = c("1850 to 1875",
                      "1876 to 1900",
                      "1901 to 1925",
                      "1926 to 1950",
                      "1951 to 1975",
                      "1976 to 2000",
                      "2001 to 2015")))


#### Analysis -----------------------------------------------------------------

## Line Graph 

av_price_grps <- ames %>%
  group_by(year_group) %>%
  summarise(mean = mean(sale_price),
            mode = getmode(sale_price),
            median = median(sale_price),
            count = n())

av_price <- ames %>%
  group_by(year_built) %>%
  summarise(mean = mean(sale_price),
            mode = getmode(sale_price),
            median = median(sale_price),
            count = n())


plot_grps <- ggplot(av_price_grps, aes(x = year_group, group = 1)) +
  geom_line(aes(y = mean), colour = "red") +
  geom_line(aes(y = mode), colour = "blue") +
  geom_line(aes(y = median), colour = "orange") +
  scale_y_continuous(labels = scales::dollar_format(scale = 0.001, suffix = "K"))
  
  
plot <- ggplot(av_price, aes(x = year_built, group = 1)) +
  geom_line(aes(y = mean), colour = "red") +
  geom_line(aes(y = mode), colour = "blue") +
  geom_line(aes(y = median), colour = "orange")


## Heat Map

# Option of 'method' in app 

# corrplot
matrix <- cor(ames %>% select_if(is.numeric))
corrplot(matrix, method = "color")

# GGally 
variables <- ames %>% select_if(is.numeric)
ggpairs(variables)


