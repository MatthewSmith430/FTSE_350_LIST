library(rvest)
FTSE_URL<-"https://www.reuters.com/finance/stocks/company-officers/"
url<-paste0(FTSE_URL,CODE2[[i]])

webpage<-read_html(SEARCH)%>%
  html_table()
FTSE_TABLE<-webpage[[1]]
FTSE_TABLE$company_code<-CODE[[i]]

FTSE_TABLE$Name[1]
LSE_NAME_LIST<-list()

for (i in 1:length(CODE)){
  url<-"https://www.londonstockexchange.com/exchange/searchengine/search.html?lang=en&x=0&y=0&q="
  SEARCH<-paste0(url,CODE[[i]])
  webpage<-read_html(SEARCH)%>%
    html_table()
  FTSE_TABLE<-webpage[[1]]
  LSE_NAME_LIST[[i]]<-FTSE_TABLE$Name[1]
}

LSE_NAME<-data.frame(CODE=CODE,
                     NAME_LSE=unlist(LSE_NAME_LIST))
LSE_NAME$edit<-gsub("ORD.*","",LSE_NAME$NAME_LSE)

sheet_name<-as.character(Sys.Date())
FTSE_350_DF<-merge(FTSE_350_DF,LSE_NAME,by="CODE")
FTSE_350_DF<-select(FTSE_350_DF,-NAME_LSE)
  
write.xlsx(FTSE_350_DF, file = "FTSE_350_FIRM_LIST.xlsx", 
           sheetName=sheet_name,
           append=TRUE)
