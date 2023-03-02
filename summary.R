#load relevant packages
library("dplyr")
library("ggplot2")

# load data
checkout_data <- read.csv("~/Desktop/2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

# Five summary questions with their respective code:

# Calculate the average number of checkouts for each item type: physical vs. digital
avg_checkouts_digital_and_physical <- checkout_data %>%
  group_by(UsageClass) %>%
  summarize(avg_checkouts = mean(Checkouts))
avg_checkouts_digital_and_physical

# Find the year with the most checkouts for ebooks
ebooks_most_checkouts_year <- checkout_data %>%
  filter(UsageClass == "Digital") %>%
  group_by(CheckoutYear) %>%
  summarize(total_checkouts = sum(Checkouts, na.rm = TRUE)) %>%
  arrange(desc(total_checkouts))
ebooks_most_checkouts_year

# How has the number of print/digital book checkouts changed over time?
changed_over_time <- checkout_data %>%
  group_by(UsageClass, CheckoutYear) %>%
  summarize(total_checkouts = sum(Checkouts)) %>%
  arrange(CheckoutYear, desc(UsageClass))
changed_over_time

# What is the most popular material type?
material_type_most_popular <- checkout_data %>%
  group_by(MaterialType) %>%
  summarize(total_checkouts = sum(Checkouts)) %>%
  arrange(desc(total_checkouts))
material_type_most_popular

# What are the 5 most checked out items? How has this changed over time?
five_most_checked_out <- checkout_data %>%
  group_by(CheckoutYear, Title) %>%
  summarize(total_checkouts = sum(Checkouts)) %>%
  arrange(CheckoutYear, desc(total_checkouts)) %>%
  group_by(CheckoutYear) %>%
  slice_max(order_by = total_checkouts, n = 5)


