# Reading data: $> openssl aes-256-cbc -d -salt -in T120708.RData.aes -out T120708.RData
load("~/Documents/Data/T120708.RData")

library(magrittr)
library(tidyr)
import::from(dplyr, mutate, select, arrange, group_by, summarize, keep_where = filter)

donors$index <- 1:nrow(donors)

# Record linkage:
donors %<>%
  group_by(email) %>%
  mutate(donor_id_email = min(index)) %>%
  group_by(first_name, last_name, street_address, city) %>%
  mutate(donor_id_address = min(index)) %>%
  dplyr::ungroup()
donors$donor_id <- ifelse(donors$email == "nobody@wikimedia.org",
                          donors$donor_id_address, donors$donor_id_email)
donors$donor_id_address <- NULL
donors$donor_id_email <- NULL
donors$index <- NULL

repeat_donors <- donors %>%
  mutate(year = lubridate::year(receive_date)) %>%
  group_by(donor_id, year) %>%
  summarize(`donations per year` = n()) %>%
  group_by(donor_id) %>%
  summarize(`years donated` = n()) %>%
  mutate(`repeat donor` = `years donated` > 1)

donations <- donors

donors %<>%
  keep_where(!is.na(utm_campaign)) %>%
  dplyr::distinct(donor_id, utm_campaign) %>%
  dplyr::left_join(repeat_donors, by = "donor_id")
