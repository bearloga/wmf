library(ggplot2)

donors %>%
  mutate(year = lubridate::year(receive_date)) %>%
  keep_where(year == "2015") %>%
  select(receive_date) %>%
  summary # 2015-01-01 -- 2015-12-09

lubridate::yday(as.Date("2015-12-09")) # 343

plot_donors_by_year <- donors %>%
  mutate(year = lubridate::year(receive_date)) %>%
  keep_where(year >= 2008) %>%
  group_by(year) %>%
  summarize(`repeat donors` = sum(`repeat donor`),
            `new donors` = sum(!`repeat donor`),
            `total donors` = n()) %>%
  tidyr::gather(type, donors, -year) %>%
  ggplot(data = ., aes(x = year, y = donors, color = type)) +
  geom_line(size = 1.1) +
  scale_x_continuous(name = "Year",
                     breaks = 2008:2015) +
  scale_y_continuous(name = "Donors",
                     breaks = seq(0, 2.2e6, 2e5),
                     labels = polloi::compress(seq(0, 2.2e6, 2e5))) +
  ggtitle("Number of total and repeat donors since 2008") +
  wmf::theme_fivethirtynine()
ggsave("plot_donors_by_year.png", plot_donors_by_year, width = 10, height = 5)

plot_donors_by_year_standardized <- donors %>%
  mutate(year = lubridate::year(receive_date),
         yday = lubridate::yday(receive_date)) %>%
  keep_where(yday < 343) %>% # Standardize
  keep_where(year >= 2008) %>%
  group_by(year) %>%
  summarize(`repeat donors` = sum(`repeat donor`),
            `new donors` = sum(!`repeat donor`),
            `total donors` = n()) %>%
  tidyr::gather(type, donors, -year) %>%
  ggplot(data = ., aes(x = year, y = donors, color = type)) +
  geom_line(size = 1.1) +
  scale_x_continuous(name = "Year",
                     breaks = 2008:2015) +
  scale_y_continuous(name = "Donors",
                     breaks = seq(0, 1.3e6, 1e5),
                     labels = polloi::compress(seq(0, 1.3e6, 1e5))) +
  ggtitle("Number of total and repeat donors since 2008, limited to 9 December") +
  wmf::theme_fivethirtynine()
ggsave("plot_donors_by_year_standardized.png", plot_donors_by_year_standardized, width = 10, height = 5)

donors_by_campaign <- donors %>%
  mutate(year = lubridate::year(receive_date),
         yday = lubridate::yday(receive_date)) %>%
  keep_where(yday < 343) %>% # Standardize
  keep_where(!is.na(group_id)) %>%
  group_by(group_id) %>%
  summarize(`repeat donors` = sum(`repeat donor`),
            `new donors` = sum(!`repeat donor`),
            `total donors` = n())

plot_donors_by_campaign <- donors_by_campaign %>%
  tidyr::gather(type, donors, -group_id) %>%
  ggplot(data = ., aes(x = group_id, y = donors, fill = type)) +
  geom_bar(position = "dodge", stat = "identity") +
  ggtitle("C14_en5C_dec_dsk_FR vs C1516_en6C_dsk_FR, limited to 9 December") +
  scale_y_continuous(name = "Donors",
                     breaks = seq(0, 5.5e5, 5e4),
                     labels = polloi::compress(seq(0, 5.5e5, 5e4))) +
  scale_x_discrete(name = "Campaign") +
  geom_text(aes(label = sprintf("%.0f", donors), y = donors + 2e4),
            position = position_dodge(width = 1)) +
  geom_text(aes(x = 1, y = 1e5, label = "56.21% new")) +
  geom_text(aes(x = 2, y = 1e5, label = "55.7% new")) +
  wmf::theme_fivethirtynine()
ggsave("plot_donors_by_campaign.png", plot_donors_by_campaign, width = 10, height = 8)
