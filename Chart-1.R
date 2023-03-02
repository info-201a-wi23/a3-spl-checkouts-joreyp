#load relevant packages

library("dplyr")
library("ggplot2")
library("plotly")
library("stringr")

#load the data 
checkout_data <- read.csv("~/Desktop/2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

# Subset the data to physical books only
physical_books <- checkout_data %>%
  filter(UsageClass == "Physical") %>%
  group_by(CheckoutYear) %>%
  summarize(TotalCheckouts = sum(Checkouts))

# Subset the data to digital books only
digital_books <- checkout_data %>%
  filter(UsageClass == "Digital") %>%
  group_by(CheckoutYear) %>%
  summarize(TotalCheckouts = sum(Checkouts))

# Create the line plot
ggplot() +
  geom_line(data = physical_books, aes(x = CheckoutYear, y = TotalCheckouts, color = "Physical Books")) +
  geom_line(data = digital_books, aes(x = CheckoutYear, y = TotalCheckouts, color = "Digital Books")) +
  scale_color_manual(name = "Usage Class", values = c("Physical Books" = "red", "Digital Books" = "blue")) +
  labs(title = "Trends in all Physical/Digital Checkouts",
       x = "Year",
       y = "Total Checkouts") +
  scale_y_continuous(labels = scales::comma) +
  theme(plot.title = element_text(hjust = 0.5))
