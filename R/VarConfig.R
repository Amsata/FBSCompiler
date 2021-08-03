
VarConfig <- function(){
  
  setClass(
    "variable", 
    slots=list(
      SuaItemCode  = "character", 
      SuaItem      = "character", 
      FbsItemCode  = "character",
      FbsItem      = "character",
      CountryCode  = "character",
      CountryName  = "character",
      ISO2         = "character",
      ISO3         = "character",
      M49Code      = "character",
      YearCode     = "character",
      YearName     = "character",
      GroupCode     = "character",
      GroupName     = "character",
      DomainCode    = "character",
      DomainName    = "character",
      ElementCode   = "character",
      ElementName   = "character"
      )
    )
  
  vars <- new(
    "variable"
    ,SuaItemCode  = "measureditem_cpc", 
    SuaItem       = "measureditemcpc_description", 
    FbsItemCode   = "fbsitem_code",
    FbsItem       = "fbsitem_description",
    CountryCode   = "country_code",
    CountryName   = "country_name",
    ISO2          = "iso2_code",
    ISO3          = "iso3_code",
    M49Code       = "m49_code",
    YearCode      = "year_code",
    YearName      = "year_description",
    GroupCode     = "group_code",
    GroupName     = "group_name",
    DomainCode    = "domain_code",
    DomainName    = "domain_description",
    ElementCode   = "measure_element",
    ElementName   = "element_description"
    )
  
  return(vars)
  
}
