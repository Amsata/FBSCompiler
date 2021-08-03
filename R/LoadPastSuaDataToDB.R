
source("R/VarConfig.R")
vars=VarConfig()
# Read and process sua data -----------------------------------------------
sua=read.csv("data/SUA.csv")

names(sua)=c(
  vars@DomainCode,#Domain Code to define in varconfig.R
  vars@DomainName,#Domain Name to define in varconfig.R
  vars@CountryCode,#Area Code
  vars@CountryName,#Area Name
  vars@ElementCode,#Element Code to define in varconfig.R
  vars@ElementName,#Element Name to define in varconfig.R
  vars@SuaItemCode,#Item code
  vars@SuaItem,#Item name
  vars@YearCode,#Year code
  vars@YearName,#Year name
  "unit",#Unit
  "value",#Value
  "Symbol",#Symbol
  "Symbol_des" #Symbol description
)



#For example purpus

sua_data=sua %>% mutate(
  Item=paste0("[",measureditem_cpc,"] ",measureditemcpc_description),
  Element=paste0("[",element_description,"] ",measure_element)
)