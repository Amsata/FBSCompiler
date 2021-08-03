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
library(RPostgreSQL)


#cource R functions
lapply(paste0("R/",list.files("R")),source)

#Connect to the database
con=dbConnect(odbc::odbc(),"Pos")

#Create DB tables and prefill them at the very first run of the App
if(length(dbListTables(conn=con))==0){
  SetupDatabase(con)
}



# dbDisconnect(con)
