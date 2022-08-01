# ReadMe
  # Save working files to the desktop, that is also where the final output file will be saved.
  # Note: if we have an electronic copy we only need that one.

  #You do need to do some post-processing in the google sheet to highlight the titles with only one copy.
# Select the full sheet, go to fill and select Conditional Formatting at the bottom of the menu. 
  # Apply to range A1:Z1000 
  # Format Rules Custom formula is
  # =$C1 = 1
  # choose fill color and done

# Load Libraries
require(tidyverse)
require(dplyr)
require(readxl)

# Set working directory
setwd("~/Desktop")

# Set file input and output names
input <- "exampleInput.xlsx"
output <- "exampleOutput.csv"


# Script
data<- read_excel(input)
    # online copies count for two
online <- read_excel(input)
online <- filter(online, online$`Item Library Code` == "ONLINE")
data <- rbind(data, online)

data <- select(data,"Catalog Author", "Catalog Title")

data %>% 
  count(data$`Catalog Title`, name = "Number of Copies") %>% 
  rename("Catalog Title" = "data$`Catalog Title`") -> data_count

data %>% 
  left_join(data_count, by = "Catalog Title") %>% 
  unique() ->
  titleList

# Save title list
write_csv(titleList, output)





#### Optional: Combine saved title lists (ie for dept name change) ####

df1 <- read_csv("exampleOutput1.csv")
df2 <- read_csv("exampleOutput2.csv")

total <- rbind(df1, df2)
total <- unique(total)

write_csv(total, "exampleCombinedOutput.csv")
