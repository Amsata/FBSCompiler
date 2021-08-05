

initializeDb <- function(con){

  #remove other db tables in case they exist
  
  if (length(dbListTables(con))!=0) {
    
    lapply(dbListTables(con),function(x){
      
      DBI::dbGetQuery(con, paste0("DROP TABLE IF EXISTS ",x," CASCADE;"))
    })
  }
  
  #SQL database creation sript generated from power AMC
  path="DatabaseModele/DatabaseCreationScript_test.sql"
  
  #get the sql file as string usable in R
  database_SQL <- getSQL(filepath=path)
  
  #run the generated sql script
  DBI::dbGetQuery(con,
             database_SQL
             )
}


# Pre-fill the table "cpc_items ------------------------------------------------------



# pre-fill the table "country" --------------------------------------------------



# pre-fill table "fbs_items" -------------------------------------------------



# pre-fill the table "years" ------------------------------------------------



# pre-fill the table "hs_item" ----------------------------------------------


# pre-fill the table "element" --------------------------------------------


# pre-fill the table "domains" --------------------------------------------


# pre-fill the table "flags" ----------------------------------------------


