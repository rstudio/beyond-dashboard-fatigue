# Define thresholds for KPIs
health_thresholds <-
  list(
    dau = 250000,         # below
    dac =  30000,         # below
    dac_dau = 0.1,        # below
    new_users = 1000,     # below
    churn_users = 1000,   # above
    daily_revenue = 25000 # below
  )

#
# Utility functions for dplyr transformation and gt table styling
#

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

highlight_exceedances <- function(data, health_thresholds) {

  data %>%
    tab_style(
      cell_fill(color = "#FF9999"),
      locations = cells_body(columns = vars(dau), rows = dau < t_dau)
    ) %>%
    tab_style(
      cell_fill(color = "#FF9999"),
      locations = cells_body(columns = vars(dac), rows = dac < t_dac)
    ) %>%
    tab_style(
      cell_fill(color = "#FF9999"),
      locations = cells_body(columns = vars(dac_dau), rows = dac_dau < t_dac_dau)
    ) %>%
    tab_style(
      cell_fill(color = "#FF9999"),
      locations = cells_body(columns = vars(new_users), rows = new_users < t_new_users)
    ) %>%
    tab_style(
      cell_fill(color = "#FF9999"),
      locations = cells_body(columns = vars(churn_users), rows = churn_users > t_churn_users)
    ) %>%
    tab_style(
      cell_fill(color = "#FF9999"),
      locations = cells_body(columns = vars(daily_revenue), rows = daily_revenue < t_daily_revenue)
    ) %>%
    tab_footnote(
      footnote = md(glue::glue("Threshold for DAU (**{scales::comma(health_thresholds$dau)}**) exceeded.")),
      locations = cells_body(columns = vars(dau), rows = dau < t_dau)
    ) %>%
    tab_footnote(
      footnote = md(glue::glue("Threshold for DAC (**{scales::comma(health_thresholds$dac)}**) exceeded.")),
      locations = cells_body(columns = vars(dac), rows = dac < t_dac)
    ) %>%
    tab_footnote(
      footnote = md(glue::glue("Threshold for DAC/DAU (**{health_thresholds$dac_dau}**) exceeded.")),
      locations = cells_body(columns = vars(dac_dau), rows = dac_dau < t_dac_dau)
    ) %>%
    tab_footnote(
      footnote = md(glue::glue("Threshold for New Users (**{scales::comma(health_thresholds$new_users)}**) exceeded.")),
      locations = cells_body(columns = vars(new_users), rows = new_users < t_new_users)
    ) %>%
    tab_footnote(
      footnote = md(glue::glue("Threshold for Churned Users (**{scales::comma(health_thresholds$churn_users)}**) exceeded.")),
      locations = cells_body(columns = vars(churn_users), rows = churn_users > t_churn_users)
    ) %>%
    tab_footnote(
      footnote = md(glue::glue("Threshold for Daily Revenue (**{scales::dollar(health_thresholds$daily_revenue)}**) exceeded.")),
      locations = cells_body(columns = vars(daily_revenue), rows = daily_revenue < t_daily_revenue)
    ) %>%
    cols_hide(columns = starts_with("t_"))
}

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

