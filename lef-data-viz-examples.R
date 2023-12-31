#library
library(tidyverse)
library(ggplot2)
library(plotly)

#Functions
#Summary Function to bring together our observations - Taken from http://www.cookbook-r.com/Graphs/Plotting_means_and_error_bars_(ggplot2)/
summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
  library(plyr)
  
  # New version of length which can handle NA's: if na.rm==T, don't count them
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  
  # This does the summary. For each group's data frame, return a vector with
  # N, mean, and sd
  datac <- ddply(data, groupvars, .drop=.drop,
                 .fun = function(xx, col) {
                   c(N    = length2(xx[[col]], na.rm=na.rm),
                     mean = mean   (xx[[col]], na.rm=na.rm),
                     sd   = sd     (xx[[col]], na.rm=na.rm)
                   )
                 },
                 measurevar
  )
  
  # Rename the "mean" column    
  datac <- rename(datac, c("mean" = measurevar))
  
  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}

#Summary Stats Overall
ames_sum_shapes <- summarySE(ames, measurevar = "sale_price", groupvars = c("foundation", "year_built")) #NAs are expected, we just want the means, naturally we won't have SEs, SDs, etc. due to some years only having one observation; that's a problem but this is a visualisation excercise so we opt in to ignore it at this stage.
ames_sum_all <- summarySE(ames, measurevar = "sale_price", groupvars = c("year_built"))

##Connected Scatterplots are hybrids 
#Price/Year Scatterplot visualisation without shapes
all_groups_con_scat <- ggplot(ames_sum_shapes, aes(x = year_built, y = sale_price, group=1)) +
  geom_line() +
  geom_point() + 
  geom_hline(yintercept = mean(ames_sum_shapes$sale_price))
all_groups_con_scat + scale_x_continuous(breaks = seq(1872, 2010, 10))

ggplotly(all_groups_con_scat)

#Price/Year Scatterplot visualisation with shapes
sep_groups_con_scat <- ggplot(ames_sum_shapes, aes(x = year_built, y = sale_price, shape = foundation, group = foundation, colour = foundation)) +
  geom_line() +
  geom_point(size = 2) + 
  geom_hline(yintercept = mean(ames_sum_shapes$sale_price)) #Few but massive outliers
sep_groups_con_scat + scale_x_continuous(breaks = seq(1872, 2010, 10))
ggplotly(sep_groups_con_scat)

#Individual foundations

ames_sum_brk <- ames_sum_shapes %>% filter(foundation == "BrkTil")
ggplot(ames_sum_brk, aes(x = year_group, y = sale_price, group = 1)) +
  geom_point(size = 2) +
  geom_line()
geom_hline(yintercept = mean(ames_sum_brk$sale_price)) #Few but massive outliers

ames_sum_CBlock <- ames_sum_shapes %>% filter (foundation == "CBlock")
ggplot(ames_sum_CBlock, aes(x = year_built, y = sale_price)) +
  geom_point(size = 2) + 
  geom_hline(yintercept = mean(ames_sum_CBlock$sale_price)) #Few but massive outliers

ames_sum_PConc <- ames_sum_shapes %>% filter (foundation == "PConc")
ggplot(ames_sum_PConc, aes(x = year_built, y = sale_price)) +
  geom_point(size = 2) + 
  geom_hline(yintercept = mean(ames_sum_PConc$sale_price)) #Few but massive outliers

ames_sum_Slab <- ames_sum_shapes %>% filter (foundation == "Slab")
ggplot(ames_sum_Slab, aes(x = year_built, y = sale_price)) +
  geom_point(size = 2) + 
  geom_hline(yintercept = mean(ames_sum_Slab$sale_price)) #Few but massive outliers

ames_sum_stone <- ames_sum_shapes %>% filter (foundation == "Stone")
ggplot(ames_sum_stone, aes(x = year_built, y = sale_price)) +
  geom_point(size = 2) + 
  geom_hline(yintercept = mean(ames_sum_stone$sale_price)) #Few but massive outliers

ames_sum_wood <- ames_sum_shapes %>% filter (foundation == "Wood")
ggplot(ames_sum_wood, aes(x = year_built, y = sale_price)) +
  geom_point(size = 2) + 
  geom_hline(yintercept = mean(ames_sum_wood$sale_price)) #Few but massive outliers
