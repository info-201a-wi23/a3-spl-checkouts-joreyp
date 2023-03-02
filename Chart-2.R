#load relevant packages

library("dplyr")
library("ggplot2")
library("plotly")
library("stringr")

#load the data 
checkout_data <- read.csv("~/Desktop/2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

# Subset the data to physical books, audiobooks, and ebooks only
trend_data <- checkout_data %>%
  filter(MaterialType %in% c("BOOK", "AUDIOBOOK", "EBOOK")) %>%
  group_by(CheckoutYear, MaterialType) %>%
  summarize(TotalCheckouts = sum(Checkouts))

# Create the line plot
ggplot(trend_data, aes(x = CheckoutYear, y = TotalCheckouts, color = MaterialType)) +
  geom_line() +
  labs(title = "Trends for Physical vs. Audiobooks vs. Ebooks",
       x = "Year",
       y = "Total Checkouts") +
  scale_color_manual(name = "Material Type",
                     values = c("BOOK" = "red",
                                "AUDIOBOOK" = "green",
                                "EBOOK" = "blue")) +
  theme(plot.title = element_text(hjust = 0.5))
