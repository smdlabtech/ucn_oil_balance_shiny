library(shiny)
source("modules/mod_home.R")
source("modules/mod_stats.R")
source("modules/mod_correlation.R")
source("modules/mod_acp.R")

server <- function(input, output, session) {
  mod_home_server("home")
  mod_stats_server("stats")
  mod_correlation_server("correlation")
  mod_acp_server("acp")
}
