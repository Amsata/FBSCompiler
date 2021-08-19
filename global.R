rm(list=ls())

library(shiny)
library(shinyjs)
library(shinycssloaders)
library(shinyFeedback)
library(dplyr)
library(tidyr)
library(DT)
library(DBI)
library(RODBC)
library(odbc)
library(readxl)
library(Rcpp)
library(data.table)
library(RPostgreSQL)
library(shinydashboard)

#cource R functions
lapply(paste0("R/",list.files("R")),source)

#Connect to the database
# con=dbConnect(odbc::odbc(),"HerokuFbs")


#connect to heroku database
con <- dbConnect(RPostgres::Postgres(),
                 host   = "ec2-52-6-211-59.compute-1.amazonaws.com",
                 dbname = "d1qcu3g4pf06t5",
                 user      = "xfaefhqgdtlcle",
                 password      = "82ec6a4179aef9d3c11dbdc8cae8c0a78f258308c4a3844835330dfd81eb189b",
                 port     = 5432
                 )

#Create DB tables and prefill them at the very first run of the App
#initializeDb(con) #to remove after
if(length(dbListTables(conn=con))==0){
initializeDb(con)
}


fbs_item=unique(DBI::dbReadTable(con,"fbs_items") %>% dplyr::pull(fbs_item))
years=unique(DBI::dbReadTable(con,"years") %>% dplyr::pull(year))


# dbDisconnect(con)
