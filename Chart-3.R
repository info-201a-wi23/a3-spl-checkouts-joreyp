#load relevant packages

library("dplyr")
library("ggplot2")
library("plotly")
library("stringr")

#load the data 
checkout_data <- read.csv("~/Desktop/2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

# What are the top 5 most popular material types?
top_material_types <- checkout_data %>%
  group_by(MaterialType) %>%
  summarize(total_checkouts = sum(Checkouts)) %>%
  arrange(desc(total_checkouts)) %>%
  top_n(5)

# Create bar plot of top 5 material types
ggplot(top_material_types, aes(x = MaterialType, y = total_checkouts)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Top 5 Most Popular Material Types",
       x = "Material Type", y = "Total Checkouts") +
      scale_y_continuous(labels = scales::comma) +
      theme(plot.title = element_text(hjust = 0.5))
