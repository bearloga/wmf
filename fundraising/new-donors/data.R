# ssh lutetium
library(RMySQL)
con <- dbConnect(RMySQL::MySQL(), dbname = "civicrm")

query <- "SELECT
  civicrm_contribution.total_amount,
  civicrm_country.iso_code,
  civicrm_contribution.receive_date,
  civicrm_email.email,
  civicrm_address.street_address,
  civicrm_address.postal_code,
  civicrm_address.city,
  civicrm_contact.first_name,
  civicrm_contact.last_name,
  contribution_tracking.utm_medium,
  contribution_tracking.utm_campaign
FROM
  civicrm.civicrm_contribution,
  civicrm.civicrm_address,
  civicrm.civicrm_country,
  civicrm.civicrm_email,
  civicrm.civicrm_contact,
  drupal.contribution_tracking
WHERE 
  civicrm_contribution.id = drupal.contribution_tracking.contribution_id
  AND civicrm_contribution.contact_id = civicrm_address.contact_id
  AND civicrm_address.country_id = civicrm_country.id
  AND civicrm_contact.id = civicrm_contribution.contact_id
  AND civicrm_contribution.contact_id = civicrm_email.contact_id
  AND civicrm_address.is_primary = 1
  AND civicrm_country.iso_code = 'US'
ORDER BY civicrm_contact.first_name;"

data <- fetch(dbSendQuery(con, query), -1)
dbClearResult(dbListResults(con)[[1]]) # Frees all resources associated with a result set.

dbDisconnect(con)

# As of 2015-12-08 18:45:33 UTC there are 1,578,269 entries.
# There are `sum(duplicated(data))` = 9,667 duplicates.

donors <- unique(data); rm(data)

donors$receive_date <- as.POSIXct(donors$receive_date, format = "%Y-%m-%d %H:%M:%S")

# Reformat/sanitize addresses:
donors$street_address <- tolower(donors$street_address)
donors$city <- tolower(donors$city)
donors$street_address <- sub(',', ' ', donors$street_address, fixed = TRUE)
donors$street_address <- sub('  ', ' ', donors$street_address, fixed = TRUE)
donors$street_address <- sub('.', '', donors$street_address, fixed = TRUE)
donors$street_address <- sub(' ct', ' court', donors$street_address, fixed = TRUE)
donors$street_address <- sub(' street', ' st', donors$street_address, fixed = TRUE)
donors$street_address <- sub(' str', ' st', donors$street_address, fixed = TRUE)
donors$street_address <- sub(' boulevard', ' blvd', donors$street_address, fixed = TRUE)
donors$street_address <- sub(' lane', ' ln', donors$street_address, fixed = TRUE)
donors$street_address <- sub(' av', ' ave', donors$street_address, fixed = TRUE)
donors$street_address <- sub(' avenue', ' ave', donors$street_address, fixed = TRUE)
donors$street_address <- sub(' drive', ' court', donors$street_address, fixed = TRUE)
donors$street_address <- sub(' road', ' rd', donors$street_address, fixed = TRUE)

# Reformat/sanitize names:
donors$first_name <- tolower(donors$first_name)
donors$last_name <- tolower(donors$last_name)

donors$group_id <- ifelse(donors$utm_campaign %in% c("C1516_en6C_dsk_FR", "C14_en5C_dec_dsk_FR"), "interest", NA)
donors$group_id[donors$utm_campaign == "C14_en5C_dec_dsk_FR"] <- "last year's campaign"
donors$group_id[donors$utm_campaign == "C1516_en6C_dsk_FR"] <- "this year's campaign"

# Get initial IDs by email:
donors$donor_id <- as.numeric(factor(donors$email))

write_tsv(donors, '~/T120708.tsv')
system('gzip ~/T120708.tsv')
