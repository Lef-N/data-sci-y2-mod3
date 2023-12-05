#### Load packages ------------------------------------------------------------
library(dplyr)


#### Processing ---------------------------------------------------------------
ames_raw <- read_csv("ames.csv") %>%
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

check_missing <- summarise(ames, across(everything(), ~ sum(is.na(.))))

ames <- ames_raw %>%
  mutate(garage = ifelse(is.na(garage_type), "No garage", "Garage"),
         has_pool = ifelse(pool_area == 0, "No pool", "Pool"))



#### Analysis -----------------------------------------------------------------
