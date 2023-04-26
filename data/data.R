library(dplyr)
library(ggplot2)
library(psych)
library(data.table)
library(tidyr)
library(dplyr)
library(psych)
library(rstatix)

beer <- read.csv("BeerDataScienceProject.tar.bz2")

beer1 <- subset(beer, select = 1:12)

#review_appearance
beer1$review_appearance_mean <- with(beer1,ave(review_appearance,
                                               beer_beerId,
                                               FUN = mean))

beer1$review_appearance_mean <- round(beer1$review_appearance_mean, 1)

#review_palette
beer1$review_palette_mean <- with(beer1, ave(review_palette,
                                             beer_beerId,
                                             FUN = mean))
beer1$review_palette_mean <- round(beer1$review_palette_mean, 1)

#review_Taste
beer1$review_taste_mean <- with(beer1, ave(review_taste,
                                           beer_beerId,
                                           FUN = mean))
beer1$review_taste_mean <- round(beer1$review_taste_mean, 1)

#review_aroma

beer1$review_aroma_mean <- with(beer1, ave(review_aroma,
                                           beer_beerId,
                                           FUN = mean))
beer1$review_aroma_mean <- round(beer1$review_aroma_mean, 1)

#review_overall

beer1$review_overall_mean <- with(beer1, ave(review_overall,
                                             beer_beerId,
                                             FUN = mean))
beer1$review_overall_mean <- round(beer1$review_overall_mean, 1)

#review_count

beer1$review_count <- with(beer1, ave(review_profileName,
                                      beer_beerId,
                                      FUN = length))

#new beer
beer_mean <- subset(beer1, select = c(1:5,10,12:18))

#removing duplicated rows
#Not including repeating beer Id in our data
beer_mean <- beer_mean[!duplicated(beer_mean$beer_beerId),]

#Not including repeating beer_name in our data
beer_mean <- beer_mean[!duplicated(beer_mean$beer_name),]

#renaming columns

colnames(beer_mean)[8:12] <- c("Appearance", "Palette", "Taste",
                               "Aroma", "Overall")

#long version
beer_long <- gather(beer_mean,
                    key="review",
                    value="value",
                    Appearance,
                    Palette,
                    Taste,
                    Aroma,
                    Overall)

