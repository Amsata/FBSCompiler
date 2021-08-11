
VarConfig <- function(){
  
  setClass(
    "variable", 
    slots=list(
      CPCItemCode     = "character", 
      CPCItem         = "character", 
      FbsItemCode     = "character",
      FbsItem         = "character",
      CountryCode     = "character",
      CountryName     = "character",
      ISO2            = "character",
      ISO3            = "character",
      M49Code         = "character",
      YearCode        = "character",
      YearName        = "character",
      GroupCode       = "character",
      GroupName       = "character",
      DomainCode      = "character",
      DomainName      = "character",
      ElementCode     = "character",
      ElementName     = "character",
      HsItemCode          = "character",
      HsItem           = "character",
      CpcParentCode   = "character",
      CpcChildCode    = "character",
      FbsParentCode   = "character",
      FbsChildCode    = "character",
      CpcMainItemCode = "character",
      CpcCoprodItem   = "character",
      IsZeroweight    ="character",
      IsPrimary       ="character",
      IsDerived       ="character",
      IsFood          ="character",
      IsFeed          ="character",
      IsSeed          ="character",
      IsStockable     ="character",
      IsIndustrial    ="character",
      FlagCode        ="character",
      Flag            ="character"
      
      )
    )
  
  vars <- new(
    "variable",
    CPCItemCode  = "item_cpc_code", 
    CPCItem       = "item", 
    FbsItemCode   = "fbs_item_code",
    FbsItem       = "fbs_item",
    CountryCode   = "country_code",
    CountryName   = "country",
    ISO2          = "iso2",
    ISO3          = "iso3",
    M49Code       = "m49_code",
    YearCode      = "year_code",
    YearName      = "year",
    GroupCode     = "group_code",
    GroupName     = "group_name",
    DomainCode    = "domain_code",
    DomainName    = "domain",
    ElementCode   = "element_code",
    ElementName   = "element",
    HsItemCode    ="hs_item_code",
    HsItem        ="hs_item",
    CpcParentCode = "cpc_parent_code",
    CpcChildCode  = "cpc_child_code",
    FbsParentCode = "fbs_parent_code",
    FbsChildCode  = "fbs_child_code",
    CpcMainItemCode = "item_cpc_code",
    CpcCoprodItem   = "cpc_item_cpc_code",
    IsZeroweight  ="is_zeroweight",
    IsPrimary     ="is_primary",
    IsDerived     ="is_derived",
    IsFood        ="is_food",
    IsFeed        ="is_feed",
    IsSeed        ="is_seed",
    IsStockable   ="is_stockable",
    IsIndustrial  ="is_industrial",
    FlagCode        ="flag_code",
    Flag            ="flag"
    )
  
  return(vars)
  
}
