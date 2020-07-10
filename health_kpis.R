library(tidyverse)
library(lubridate)

get_health_kpis <- function(n = NULL) {

  tbl <-
    readr::read_csv("health_kpis.csv", col_types = c("Diidiid")) %>%
    mutate(week = paste0("Week ", lubridate::week(date))) %>%
    mutate(wday = lubridate::wday(date))

  if (!is.null(n)) {
    tbl <- tbl %>% head(n)
  }

  tbl
}
