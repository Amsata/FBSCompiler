
SetupDatabase <- function(con){
  
  vars=VarConfig()
  # con=dbConnect(odbc::odbc(),"Pos")
  
  #Drop Tables if they exist----
  dbGetQuery(con,
             'DROP TABLE IF EXISTS fbs_items CASCADE;
            DROP TABLE IF EXISTS sua_items CASCADE;
            DROP TABLE IF EXISTS years CASCADE;
            DROP TABLE IF EXISTS domains CASCADE;
            DROP TABLE IF EXISTS elements CASCADE;
            DROP TABLE IF EXISTS country CASCADE;
            DROP TABLE IF EXISTS SUA CASCADE;
           ')
  
  # Create fbs_items table --------------------------------------------------
  
  #Create the table
  DBI::dbGetQuery(
    con,
    '
CREATE TABLE fbs_items (
FBSItem_Code varchar(20) primary key,
FBSItem_description varchar(100)
);
'
  )
  
  #Prefill the table
  
  SuaFbsItems=read_excel("data/SuaFbsItems.xlsx",sheet = "FBS and SUA list")
  
  names(SuaFbsItems)=c(
    vars@FbsItemCode,
    vars@FbsItem,
    vars@SuaItemCode,
    vars@SuaItem
  )
  
  SuaFbsItems=SuaFbsItems %>%tidyr::fill_(vars@FbsItemCode)
  SuaFbsItems=SuaFbsItems %>%tidyr::fill_(vars@FbsItem)
  
  FbsItems=unique(SuaFbsItems[,c(vars@FbsItemCode,vars@FbsItem)])
  
  stopifnot(sum(dbListFields(con,"fbs_items")!=names(FbsItems))==0)
  
  fbsitem_tb=DBI::dbReadTable(conn = con,name="fbs_items")
  
  fbsitem_tb_to_save=FbsItems %>%
    dplyr::anti_join(
      fbsitem_tb,
      by = c(vars@FbsItemCode, vars@FbsItem)
    )
  
  odbc::dbAppendTable(con,"fbs_items",fbsitem_tb_to_save)
  
  
  # Create the sua_items table ----------------------------------------------
  
  #Create the table
  DBI::dbGetQuery(
    conn=con,
    '
  CREATE TABLE sua_items (
  measuredItem_CPC varchar(10) primary key,
  FBSItem_Code varchar(20) references fbs_items,
  measuredItemCPC_description varchar(255)
  );
  '
  )
  
  #pre-fill the table
  SuaItems=unique(SuaFbsItems[,c( vars@SuaItemCode,vars@FbsItemCode,vars@SuaItem)])
  
  stopifnot(sum(dbListFields(con,"sua_items")!=names(SuaItems))==0)
  
  suaitims_tb=DBI::dbReadTable(conn = con,name = "sua_items")
  
  suaitims_tb_to_save=SuaItems %>%
    dplyr::anti_join(
      suaitims_tb,
      by = c(vars@SuaItemCode, vars@FbsItemCode, vars@SuaItem)
    )
  
  odbc::dbAppendTable(con,"sua_items",suaitims_tb_to_save)
  
  
  # Create years table ------------------------------------------------------
  
  DBI::dbGetQuery(
    conn=con,
    '
CREATE TABLE Years (
year_code varchar(4) primary key,
year_description varchar(4)
);
'
  )
  
  # Create the domains tables -----------------------------------------------
  
  DBI::dbGetQuery(
    conn=con,
    
    'CREATE TABLE domains (
  domain_code varchar(30) primary key,
  domain_description varchar(50)
  );'
  )
  
  
  # Create the element table ------------------------------------------------
  
  DBI::dbGetQuery(
    conn=con,
    'CREATE TABLE elements(
  measure_element varchar(30) primary key,
  element_description varchar(30)
  );'
  )
  
  
  # Create the country table ------------------------------------------------
  
  #Create the table
  DBI::dbGetQuery(
    conn=con,
    '
  CREATE TABLE country (
  country_code int primary key,
  country_Name varchar(100),
  m49_code int,
  iso2_code varchar(2),
  iso3_code varchar(3)
  );
  '
  )
  
  #Prefill the table
  country_df=read.csv("data/country_classification.csv")
  
  vars=VarConfig()
  
  names(country_df)=c(
    vars@GroupCode,
    vars@GroupName,
    vars@CountryCode,
    vars@CountryName,
    vars@M49Code,
    vars@ISO2,
    vars@ISO3
  )
  
  country_df=unique(country_df[,dbListFields(conn=con,name="country")])
  country_tb=DBI::dbReadTable(con,"country")
  country_df_to_save=country_df %>% 
    anti_join(country_tb,by=vars@CountryCode) %>% 
    filter(country_code!=206)
  #TO DO: check how to include vars@CountryCode in dplyr commands
  odbc::dbAppendTable(con,"country",country_df_to_save)
  
  
  
  # Create the SUA table ----------------------------------------------------
  
  
  DBI::dbGetQuery(
    conn=con,
    '
  CREATE TABLE sua (
  country_code int references country,
  measureditem_cpc varchar(20) references sua_items,
  measured_element varchar(30) references elements,
  year_code varchar(4) references Years,
  value float(24),
  flag varchar(10)
  );
  '
  )
  
  
}
