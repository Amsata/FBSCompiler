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


#cource R functions
lapply(paste0("R/",list.files("R")),source)

#Connect to the database
con=dbConnect(odbc::odbc(),"Pos")

#Create DB tables and prefill them at the very first run of the App
initializeDb(con) #to remove after
if(length(dbListTables(conn=con))==0){
initializeDb(con)
}


fbs_item=unique(DBI::dbReadTable(con,"fbs_items") %>% dplyr::pull(fbs_item))
years=unique(DBI::dbReadTable(con,"years") %>% dplyr::pull(year))


dbDisconnect(con)
