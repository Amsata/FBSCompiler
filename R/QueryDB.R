# 
# item=c("Wheat and products","Rice and products")
# 
# years=2015:2017

getQuery=function(domain,fbs_items,years) {

  query= paste0("SELECT sua_records.item_cpc_code, ",
                "cpc_items.item, ",
                "sua_records.element_code, ",
                "elements.element, ",
                "sua_records.year_code, ",
                "sua_records.value, ",
                "sua_records.flag_code ",
                "FROM sua_records ",
                "INNER JOIN ",
                "cpc_items ON sua_records.item_cpc_code=cpc_items.item_cpc_code ",
                "INNER JOIN ",
                "fbs_items ON cpc_items.fbs_item_code=fbs_items.fbs_item_code ",
                "INNER JOIN ",
                "elements ON sua_records.element_code=elements.element_code ",
                "INNER JOIN ",
                "domains ON sua_records.domain_code=domains.domain_code ",
                "WHERE domains.domain_code='",domain,"' AND ",
                "fbs_items.fbs_item IN ('",paste(fbs_items,collapse = "','"),
                "') AND sua_records.year_code IN (",paste(years,collapse = ","),");"
  )
  
  return(query)
}

 # df=DBI::dbGetQuery(con,getQuery(domain = "SUA",item,years))
