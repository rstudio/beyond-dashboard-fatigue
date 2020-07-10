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

# Add columns that contain threshold values `t_<KPI>` for the purpose
# of determining weather daily values are above or below
add_threshold_columns <- function(data, health_thresholds) {

  data %>%
    dplyr::mutate(
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
    gt::tab_style(
      gt::cell_fill(color = "#FF9999"),
      locations = gt::cells_body(columns = vars(dau), rows = dau < t_dau)
    ) %>%
    gt::tab_style(
      gt::cell_fill(color = "#FF9999"),
      locations = gt::cells_body(columns = vars(dac), rows = dac < t_dac)
    ) %>%
    gt::tab_style(
      gt::cell_fill(color = "#FF9999"),
      locations = gt::cells_body(columns = vars(dac_dau), rows = dac_dau < t_dac_dau)
    ) %>%
    gt::tab_style(
      gt::cell_fill(color = "#FF9999"),
      locations = gt::cells_body(columns = vars(new_users), rows = new_users < t_new_users)
    ) %>%
    gt::tab_style(
      gt::cell_fill(color = "#FF9999"),
      locations = gt::cells_body(columns = vars(churn_users), rows = churn_users > t_churn_users)
    ) %>%
    gt::tab_style(
      gt::cell_fill(color = "#FF9999"),
      locations = gt::cells_body(columns = vars(daily_revenue), rows = daily_revenue < t_daily_revenue)
    ) %>%
    gt::tab_footnote(
      footnote = gt::md(glue::glue("Threshold for DAU (**{scales::comma(health_thresholds$dau)}**) exceeded.")),
      locations = gt::cells_body(columns = vars(dau), rows = dau < t_dau)
    ) %>%
    gt::tab_footnote(
      footnote = gt::md(glue::glue("Threshold for DAC (**{scales::comma(health_thresholds$dac)}**) exceeded.")),
      locations = gt::cells_body(columns = vars(dac), rows = dac < t_dac)
    ) %>%
    gt::tab_footnote(
      footnote = gt::md(glue::glue("Threshold for DAC/DAU (**{health_thresholds$dac_dau}**) exceeded.")),
      locations = gt::cells_body(columns = vars(dac_dau), rows = dac_dau < t_dac_dau)
    ) %>%
    gt::tab_footnote(
      footnote = gt::md(glue::glue("Threshold for New Users (**{scales::comma(health_thresholds$new_users)}**) exceeded.")),
      locations = gt::cells_body(columns = vars(new_users), rows = new_users < t_new_users)
    ) %>%
    gt::tab_footnote(
      footnote = gt::md(glue::glue("Threshold for Churned Users (**{scales::comma(health_thresholds$churn_users)}**) exceeded.")),
      locations = gt::cells_body(columns = vars(churn_users), rows = churn_users > t_churn_users)
    ) %>%
    gt::tab_footnote(
      footnote = gt::md(glue::glue("Threshold for Daily Revenue (**{scales::dollar(health_thresholds$daily_revenue)}**) exceeded.")),
      locations = gt::cells_body(columns = vars(daily_revenue), rows = daily_revenue < t_daily_revenue)
    ) %>%
    gt::cols_hide(columns = starts_with("t_"))
}

highlight_weekends <- function(data) {

  data %>%
    gt::tab_style(
      style = gt::cell_fill(color = "gray95"),
      locations = gt::cells_body(
        columns = TRUE,
        rows = wday %in% c(1, 7)
      )
    )
}

