## Beyond Dashboard Fatigue

This repository contains supporting code for the July 14, 2020 RStudio webinar. Once available, the webinar recording can be found on https://resources.rstudio.com.

Dashboards are *great* but sometimes people need the right information, at the right place, at the right time. 

Let's face it, data science teams face a challenging task. Not only do they have to gain insight from data, they also have to persuade others to make decisions based on those insights. To close this gap, teams rely on tools like dashboards, apps, and APIs. But unfortunately data organizations can suffer from their own success - how many of those dashboards are viewed once and forgotten? Is a dashboard of dashboards really the right solution? And what about that pesky, precisely formatted Excel spreadsheet that Finance still wants every week?

The webinar, entitled *Beyond Dashboard Fatigue*, presents an easy way teams can solve these problems using proactive email notifications through the **blastula** and **gt** packages. On top of that, **RStudio** pro products can be used to scale out those solutions for enterprise applications. Dynamic emails are a powerful way to meet decision makers where they live - their inbox - while displaying exactly the results needed to influence decision-making. Best of all, these notifications are crafted with code, ensuring your work is still reproducible, durable, and credible.

We’ll demonstrate how this approach provides solutions for data quality monitoring, detecting and alerting on anomalies, and can even automate routine (but precisely formatted) KPI reporting.

### Packages Required

The complete set of packages used in this webinar presentation (and required for using the R script files and R Markdown files in this repo) are:

- [**blastula**](https://rich-iannone.github.io/blastula/): 'Easily Send HTML Email Messages'
- [**gt**](https://gt.rstudio.com): 'Easily Create Presentation-Ready Display Tables'
- [**dplyr**](https://dplyr.tidyverse.org): 'A Grammar of Data Manipulation'
- [**readr**](https://readr.tidyverse.org): 'Read Rectangular Text Data'
- [**lubridate**](https://lubridate.tidyverse.org): 'Make Dealing with Dates a Little Easier'
- [**ggplot2**](https://ggplot2.tidyverse.org): 'Create Elegant Data Visualisations Using the Grammar of Graphics'
- [**scales**](https://scales.r-lib.org): 'Scale Functions for Visualization'
- [**tidyr**](https://tidyr.tidyverse.org): 'Tidy Messy Data'
- [**glue**](https://glue.tidyverse.org): 'Interpreted String Literals'
- [**flexdashboard**](https://rmarkdown.rstudio.com/flexdashboard/): 'R Markdown Format for Flexible Dashboards'
- [**DT**](https://rstudio.github.io/DT/): 'A Wrapper of the JavaScript Library "DataTables"'

By installing the **tidyverse** package with `install.packages("tidyverse")`, you'll get most of these packages. Use `install.packages()` with **"blastula"**, **"gt"**, **"glue"**, **"flexdashboard"**, and **"DT"** to obtain the complete set.

### Files Included

There are a number of files here that generate useful products. 

- `"health_dashboard.Rmd"`: An R Markdown document that generates a dashboard with business health KPIs (using **flexdashboard**, **DT**, and **ggplot2**)
- `"business_health.Rmd"`: An R Markdown document that generates a report with recent business health KPIs (using **gt**, **ggplot2**, and **blastula**)
- `"business_health_email.Rmd"`: An R Markdown subdocument that provides the **blastula** email message body, this email is only to be delivered when a certain condition holds (badly-performing KPIs)
- `"health_kpis.csv"`: A CSV file that contains daily KPI data for all of the examples
- `"health_kpis.R"`: An R script that contains a function for obtaining KPI data over the last *n* days (this file is *sourced* by `"health_dashboard.Rmd"` and by `"business_health.Rmd"`)
- `"health_thresholds"`: An R script that contains utility functions for the main R Markdown report (`"business_health.Rmd"`)
- `"beyond-dashboard-fatique.Rproj"`: A **RStudio** project file. This is helpful for opening this entire project in the **RStudio** IDE.

### Automation

In order for these dynamic reports to check for alerts and send proactive notifications, they need to be automated. One simple option would be to use a service like cron. In the webinar, we take advantage of [RStudio Connect](https://rstudio.com/products/connect), a professional product from RStudio that makes it easy to put these notifiers into production without worrying about package versions, logging, authentication, or scale.

For more information:  
 - Try [RStudio Connect Evaluation](https://rstudio.con/products/connect)
 - Read the [RStudio Connect User Guide](https://docs.rstudio.com/connect/user/rmarkdown/#r-markdown-email-customization)
 - Check out more [blastula email demos](https://solutions.rstudio.com/examples/blastula-overview/)
 

