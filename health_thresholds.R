library(tidyverse)
library(gt)
library(glue)
library(scales)

#
# Utility functions for the main R Markdown report
#

# Define thresholds for KPIs

health_thresholds <-
  list(
    dau = 250000,          # should be above this value
    dac =  30000,          # should be above this value
    dac_dau = 0.1,         # should be above this value
    new_users = 1000,      # should be above this value
    daily_revenue = 25000, # should be above this value
    churn_users = 1000     # should be below this value
  )

#
# Utility functions for dplyr transformations
#

# Add columns that contain threshold values `t_<KPI>` for the purpose
# of determining weather daily values are above or below
add_threshold_columns <- function(data, health_thresholds) {

  data %>%
    mutate(
      t_dau = health_thresholds$dau,
      t_dac = health_thresholds$dac,
      t_dac_dau = health_thresholds$dac_dau,
      t_new_users = health_thresholds$new_users,
      t_churn_users = health_thresholds$churn_users,
      t_daily_revenue = health_thresholds$daily_revenue
    )
}

#
# Utility functions for gt table styling
#

# This is a gt-based function that styles rows with a
# light gray fill if they correspond to weekend days
highlight_weekends <- function(data) {

  data %>%
    tab_style(
      style = cell_fill(color = "gray95"),
      locations = cells_body(
        columns = TRUE,
        rows = wday %in% c(1, 7)
      )
    )
}

# This is a gt-based function that uses the `health_thresholds`
# list to highlight the exceeding KPIs in a light red color
highlight_exceedances <- function(data, health_thresholds) {

  data %>%
    tab_style(
      cell_fill(color = "#FF9999"),
      locations = cells_body(
        columns = vars(dau),
        rows = dau < t_dau
      )
    ) %>%
    tab_style(
      cell_fill(color = "#FF9999"),
      locations = cells_body(
        columns = vars(dac),
        rows = dac < t_dac
      )
    ) %>%
    tab_style(
      cell_fill(color = "#FF9999"),
      locations = cells_body(
        columns = vars(dac_dau),
        rows = dac_dau < t_dac_dau
      )
    ) %>%
    tab_style(
      cell_fill(color = "#FF9999"),
      locations = cells_body(
        columns = vars(new_users),
        rows = new_users < t_new_users
      )
    ) %>%
    tab_style(
      cell_fill(color = "#FF9999"),
      locations = cells_body(
        columns = vars(churn_users),
        rows = churn_users > t_churn_users
      )
    ) %>%
    tab_style(
      cell_fill(color = "#FF9999"),
      locations = cells_body(
        columns = vars(daily_revenue),
        rows = daily_revenue < t_daily_revenue
      )
    ) %>%
    tab_footnote(
      footnote = md(glue(
        "Threshold for DAU (**{comma(health_thresholds$dau)}**) exceeded.")
      ),
      locations = cells_body(
        columns = vars(dau),
        rows = dau < t_dau
      )
    ) %>%
    tab_footnote(
      footnote = md(glue(
        "Threshold for DAC (**{comma(health_thresholds$dac)}**) exceeded.")
      ),
      locations = cells_body(
        columns = vars(dac),
        rows = dac < t_dac
      )
    ) %>%
    tab_footnote(
      footnote = md(glue(
        "Threshold for DAC/DAU (**{health_thresholds$dac_dau}**) exceeded.")
      ),
      locations = cells_body(
        columns = vars(dac_dau),
        rows = dac_dau < t_dac_dau
      )
    ) %>%
    tab_footnote(
      footnote = md(glue(
        "Threshold for New Users (**{comma(health_thresholds$new_users)}**) exceeded.")
      ),
      locations = cells_body(
        columns = vars(new_users),
        rows = new_users < t_new_users
      )
    ) %>%
    tab_footnote(
      footnote = md(glue(
        "Threshold for Churned Users (**{comma(health_thresholds$churn_users)}**) exceeded.")
      ),
      locations = cells_body(
        columns = vars(churn_users),
        rows = churn_users > t_churn_users
      )
    ) %>%
    tab_footnote(
      footnote = md(glue(
        "Threshold for Daily Revenue (**{dollar(health_thresholds$daily_revenue)}**) exceeded.")
      ),
      locations = cells_body(
        columns = vars(daily_revenue),
        rows = daily_revenue < t_daily_revenue
      )
    ) %>%
    cols_hide(columns = starts_with("t_"))
}
