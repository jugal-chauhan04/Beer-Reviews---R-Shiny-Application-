## Loading the required packages

library(dplyr)
library(ggplot2)
library(psych)
library(data.table)
library(tidyr)
library(dplyr)
library(psych)
library(rstatix)

# reading the data into a variable
beer <- read.csv("BeerDataScienceProject.tar.bz2")

# Removing the variable "review_time" as it is not required
beer1 <- subset(beer, select = 1:12)

# Now we will create new colums containing average review scores of each beer for the variables: review_appearance,
# review_palette, review_aroma, review_taste, review_overall

# Creating a new column containing the average review score of beers for review_appearance variable.
beer1$review_appearance_mean <- with(beer1,ave(review_appearance,
                                               beer_beerId,
                                               FUN = mean))
# Rounding to nearest integer value
beer1$review_appearance_mean <- round(beer1$review_appearance_mean, 1)

# Creating new variable containing average review score of each beer for review_palette variable.
beer1$review_palette_mean <- with(beer1, ave(review_palette,
                                             beer_beerId,
                                             FUN = mean))
# Rounding to nearest integer value
beer1$review_palette_mean <- round(beer1$review_palette_mean, 1)

# Creating new variable containing average review score of each beer for review_taste variable
beer1$review_taste_mean <- with(beer1, ave(review_taste,
                                           beer_beerId,
                                           FUN = mean))
# Rounding to nearest integer value
beer1$review_taste_mean <- round(beer1$review_taste_mean, 1)

# Creating new variable containing average review score of each beer for review_aroma variable

beer1$review_aroma_mean <- with(beer1, ave(review_aroma,
                                           beer_beerId,
                                           FUN = mean))
# Rounding to nearest integer value
beer1$review_aroma_mean <- round(beer1$review_aroma_mean, 1)

# Creating new variable containing average review score of each beer for review_overall variable

beer1$review_overall_mean <- with(beer1, ave(review_overall,
                                             beer_beerId,
                                             FUN = mean))
# Rounding to nearest integer value
beer1$review_overall_mean <- round(beer1$review_overall_mean, 1)

# Now we will create another new variable that contains total number of reviews for
# each beer and name it review_count

# review_count

beer1$review_count <- with(beer1, ave(review_profileName,
                                      beer_beerId,
                                      FUN = length))

# Selecting the required columns in a new variable
beer_mean <- subset(beer1, select = c(1:5,10,12:18))

# Removing duplicated rows
# Not including repeating beer Id in our data
beer_mean <- beer_mean[!duplicated(beer_mean$beer_beerId),]

# Not including repeating beer_name in our data
beer_mean <- beer_mean[!duplicated(beer_mean$beer_name),]

# renaming columns

colnames(beer_mean)[8:12] <- c("Appearance", "Palette", "Taste",
                               "Aroma", "Overall")

# long version
beer_long <- gather(beer_mean,
                    key="review",
                    value="value",
                    Appearance,
                    Palette,
                    Taste,
                    Aroma,
                    Overall)

# The beer_long variable will be the input for the app.R file
