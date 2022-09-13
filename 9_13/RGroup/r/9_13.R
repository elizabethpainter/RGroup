# R Users Group Meetin g9/13/22
# Introduction to GGPLOT
install.packages("tidyverse")
install.packages("plotly")
library(tidyverse)
library(ggplot2)
library(plotly)

# Load our data

surveys_complete <- read_csv("data/portal_data_joined.csv") %>%
   filter(complete.cases(.))

#check out the data

summary(surveys_complete)

#ggplot(data = <DATA>, mapping = aes (X,Y)) +
  #geom_function()


ggplot(data = surveys_complete, mapping = aes (x = weight,y = hindfoot_length)) +

  geom_point( alpha = 0.1, aes(color = species_id))

ggplot(data = surveys_complete, mapping = aes (x = weight,y = hindfoot_length)) +
  
  geom_point( alpha = 0.1, aes(color = genus)) +
  
  theme_bw() #theme to change background color

#Boxplots

ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
    geom_boxplot() + #outliers included
    #geom_point ()
    geom_jitter(alpha = 0.1, color = "tomato")


# because it's a layering function/iteritative

ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +

  geom_jitter(alpha = 0.1, color = "tomato")+
  geom_boxplot() 

ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
  
  geom_jitter(alpha = 0.1, color = "tomato")+
  geom_violin() # give you the shape of distribution instead of quartiles


#Make a new plot to explore the distribution of hindfoot_length just for species 
#NL and PF. Overlay a jitter plot of the hindfoot lengthsof each species ith a 
#box plot. Then color the datapoints according to the plot from which the sample was taken





surveys_complete %>% 
  filter(species_id == "NL" | species_id == "PF") %>%
  ggplot(aes(x = species_id, y = hindfoot_length))+
  geom_jitter(aes(color = plot_id))+ ## change plot id to category
  geom_boxplot()

surveys_complete %>% 
  filter(species_id == "NL" | species_id == "PF") %>%
  ggplot(aes(x = species_id, y = hindfoot_length))+
  geom_jitter(aes(color = as.factor(plot_id)))+ ## change plot id to category
  geom_boxplot()
  

## other filter option
species_of_interest <- c("NL", "PF")


surveys_complete %>% 
  filter(species_id == "NL" | species_id == "PF") %>%
  ggplot(aes(x = species_id, y = hindfoot_length))+
  geom_jitter(aes(color = as.factor(plot_id)))+ ## change plot id to category
  geom_boxplot()


#Plotting Time Series Data
#Number of records of each species in each year, has abundance changed over time

yearly_counts <- surveys_complete %>%
  count(year, species_id)

yearly_counts

ggplot(data = yearly_counts, aes(x = year, y = n, group = species_id)) +
  geom_line(aes(color = species_id))+
  theme_bw()

#OR for color in global

ggplot(data = yearly_counts, aes(x = year, y = n, group = species_id, color = species_id)) +
  geom_line()+
  theme_bw()


# single graph for species
ggplot(data = yearly_counts, aes(x = year, y = n, group = species_id, color = species_id)) +
  geom_line()+
  facet_wrap(~species_id)+
  theme_bw()

#Grided version
ggplot(data = yearly_counts, aes(x = year, y = n, group = species_id, color = species_id)) +
  geom_line()+
  facet_grid(~species_id)+
  theme_bw()


yearly_counts <- surveys_complete %>%
  count(year, species_id)

plot1<- ggplot(data = yearly_counts, aes(x = year, y = n))+
  geom_line(aes(color=species_id))



plot1+geom_point()


plotly(plot1)
