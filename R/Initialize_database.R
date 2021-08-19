

initializeDb <- function(con){
vars=VarConfig()
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
  
  query_lst=paste0(unlist(strsplit(database_SQL,split = ";")),";")
  query_lst=query_lst[1:(length(query_lst)-1)]
  
  #run the generated sql script
  # DBI::dbGetQuery(con,
  #            database_SQL # change because Cannot insert multiple commands into a prepared statement(for heroku)
  #            )
  
  lapply(query_lst, function(q){
    DBI::dbGetQuery(con,
                    q
    )
  })
  
  
  # pre-fill table "fbs_items" -------------------------------------------------
  
  SuaFbsItems=read_excel("data/SuaFbsItems.xlsx",sheet = "FBS and SUA list")
  
  names(SuaFbsItems)=c(
    vars@FbsItemCode,
    vars@FbsItem,
    vars@CPCItemCode,
    vars@CPCItem
  )
  
  
  
  SuaFbsItems=SuaFbsItems %>%tidyr::fill_(vars@FbsItemCode)
  SuaFbsItems=SuaFbsItems %>%tidyr::fill_(vars@FbsItem)
  
  FbsItems=unique(SuaFbsItems[,c(vars@FbsItemCode,vars@FbsItem)])
  
  stopifnot(sum(dbListFields(conn=con,name="fbs_items")!=names(FbsItems))==0)
  
  odbc::dbAppendTable(con,"fbs_items",FbsItems)
  # Pre-fill the table "cpc_items ------------------------------------------------------
  SuaItems=unique(SuaFbsItems[,c( vars@CPCItemCode,vars@FbsItemCode,vars@CPCItem)])
  
  suaitims_tb_to_save=as.data.table(SuaItems)%>% mutate(
    is_zeroweight=NA,
    is_primary=NA,
    is_derived=NA,
    is_food=NA,
    is_feed=NA,
    is_seed=NA,
    is_stockable=NA,
    is_industrial=NA
  )
  
  stopifnot(sum(dbListFields(con,"cpc_items")!=names(suaitims_tb_to_save))==0)
  
  odbc::dbAppendTable(con,"cpc_items",suaitims_tb_to_save)
  
  
  # pre-fill the table "country" --------------------------------------------------
  
  
  
  
  
  # pre-fill the table "years" ------------------------------------------------
  
  
  
  # pre-fill the table "hs_item" ----------------------------------------------
  
  
  # pre-fill the table "element" --------------------------------------------
  
  element_df=readxl::read_excel(path="data/Reference File.xlsx",sheet = "Elements")
  names(element_df)=c(vars@ElementCode,vars@ElementName)
  element_tb=DBI::dbReadTable(conn=con,"elements")
  stopifnot(sum(dbListFields(conn=con,"elements")!=names(element_tb))==0)
  
  element_df$element_code <- as.integer(element_df$element_code)
  
  DBI::dbAppendTable(conn = con,name="elements",element_df)
  
  # pre-fill the table "domains" --------------------------------------------
  
  domain_df=data.frame(
    domain_code=c("SUA","FBS","TRD","FOD","FED","SED","IND","LOS","STK"),
    domain=c("Supply Utilization Account (SUA)", "Food Balance Sheet (FBS)",
             "Trade","Food","Feed","Seed","Industrial uses","Loss","Stocks")
  )
  DBI::dbAppendTable(conn = con,"domains",domain_df)
  
  
  # pre-fill the table "flags" ----------------------------------------------
  
  flag_df=readxl::read_excel(path="data/Reference File.xlsx",sheet = "Flags")
  names(flag_df)=c(vars@FlagCode,vars@Flag)
  flag_tb=DBI::dbReadTable(conn=con,"flags")
  flag_df=flag_df %>% mutate(flag_code=ifelse(is.na(flag_code)," ",flag_code))
  stopifnot(sum(dbListFields(conn=con,"flags")!=names(flag_df))==0)
  
  DBI::dbAppendTable(conn = con,name="flags",flag_df)
  
  #prefill commodity tree table------------------------------------------
  
  
  # prefill year ------------------------------------------------------------
  
  years_df=data.frame(
    year_code=2000:2020,
    year=2000:2020
  )
  
  DBI::dbAppendTable(conn = con,"years",years_df)
  
  
  
  # prefill country tanle ---------------------------------------------------
  
  
  country_df=read.csv("data/country_classification.csv")
  
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
    filter(country_code==206)
  #TO DO: check how to include vars@CountryCode in dplyr commands
  odbc::dbAppendTable(con,"country",country_df_to_save)
  
  
  
  # prefill coproduct table -------------------------------------------------
  
  coprod_df=read.csv("data/coproducts.csv")
  
  cpc_item_df=dbReadTable(con,"cpc_items")
  items=trimws(cpc_item_df$item_cpc_code)
  
  coprod_df=coprod_df %>% dplyr::select(measured_item_child_cpc,branch,note2) %>% 
    filter(!is.na(branch), branch %in% items ,measured_item_child_cpc%in%items)
  
  names(coprod_df)=dbListFields(conn=con,"coprod")
  odbc::dbAppendTable(con,"coprod",coprod_df)
  
  
  
  # prefilled tree ----------------------------------------------------------
  
  
  tree_df=read.csv("data/tree.csv")
  tree_df=tree_df %>% filter(measuredElementSuaFbs=="extractionRate")
  tree_df$measuredElementSuaFbs=5423 #extraction rate
  tree_df$flagObservationStatus="I"
  
  
  cpc_item_df=dbReadTable(con,"cpc_items")
  items=trimws(cpc_item_df$item_cpc_code)
  
  tree_df=tree_df %>% dplyr::select(geographicAreaM49,measuredItemParentCPC,
                                    measuredItemChildCPC,measuredElementSuaFbs,
                                    timePointYears,Value,flagObservationStatus) %>% 
    filter(measuredItemParentCPC%in% items, measuredItemChildCPC%in% items)
  
  names(tree_df)=DBI::dbListFields(con,"sua_tree")
  tree_df$country_code=26
  
  odbc::dbAppendTable(con,"sua_tree",tree_df)
  
  
  # trade -------------------------------------------------------------------
  
  
  
  commodityTrade=read_excel("data/Reference File.xlsx", "Trade_Commodities")
  setDT(commodityTrade)
  # tradeICommodities = unique(countryData[CPCCode %in% unique(commodityTrade[, CPCCode]), Commodity])
  # tradeECommodities = tradeICommodities
  tradeIElements = "Import Quantity [t]"
  tradeEElements = "Export Quantity [t]"
  s <- strsplit(commodityTrade$HS6, split = ",")
  
  
  trade_list=data.table(CPCCode = rep(commodityTrade$CPCCode, sapply(s, length)), HS6= unlist(s))
  
  
  # trade_list=merge(trade_list,commodityName, by ="CPCCode", all.x = TRUE)
  
  
  
  # prefill SUA -------------------------------------------------------------
  
  
  sua_df=read.csv("data/SUA.csv")
  sua_df=sua_df %>% dplyr::select(-Unit)
  names(sua_df)=c(
    vars@DomainCode,vars@DomainName,vars@CountryCode,vars@CountryName,
    vars@ElementCode,vars@ElementName,vars@CPCItemCode,vars@CPCItem,
    vars@YearCode,vars@YearName,"value",vars@FlagCode,vars@Flag
  ) 
  
  sua_df=sua_df%>% mutate(
    source=NA_character_,
    precision=NA_character_,
    comments=NA_character_
  ) %>% filter(item_cpc_code %in% items)
  
  DBI::dbListFields(con,"sua_records")
  
  sua_df=sua_df[,setdiff(DBI::dbListFields(con,"sua_records"),"seq_id")]
  
  sua_df$country_code=26
  sua_df$domain_code="SUA"
  sua_df$flag_code=" "
  
  DBI::dbAppendTable(con,"sua_records",sua_df)
  
  #save food to production domain
  food_df=sua_df %>% filter(element_code==5141) %>% mutate(domain_code="FOD")
  DBI::dbAppendTable(con,"sua_records",food_df)
  
  # Feed domain
  feed_df=sua_df %>% filter(element_code==5520) %>% mutate(domain_code="FED")
  DBI::dbAppendTable(con,"sua_records",feed_df)
  
  # seed domain
  seed_df=sua_df %>% filter(element_code==5525) %>% mutate(domain_code="SED")
  DBI::dbAppendTable(con,"sua_records",seed_df)
  
  #loss domain
  loss_df=sua_df %>% filter(element_code==5516) %>% mutate(domain_code="LOS")
  DBI::dbAppendTable(con,"sua_records",loss_df)
  
  # industrial domain
  industrial_df=sua_df %>% filter(element_code==5565) %>% mutate(domain_code="IND")
  # DBI::dbAppendTable(con,"sua_records",industrial_df)
  
  
  
  
}

