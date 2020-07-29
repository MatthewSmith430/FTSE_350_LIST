library(rvest)
library(purrr)
library(magrittr)
library(xlsx)

#FTSE_URL<-"https://www.londonstockexchange.com/exchange/prices-and-markets/stocks/indices/constituents-indices.html?index=NMX&page="
ALL_SHARE_URL<-"https://www.londonstockexchange.com/exchange/prices-and-markets/stocks/indices/summary/summary-indices-constituents.html?index=ASX&page="
AS_LIST<-list()

for (i in 1:31){
  
  url<-paste0(ALL_SHARE_URL,i)
  webpage<-read_html(url)%>%
    html_table()
  FTSE_TABLE<-webpage[[1]]
  FTSE_TABLE<-FTSE_TABLE[,1:2]
  colnames(FTSE_TABLE)<-c("CODE","NAME"#,"CUR","PRICE",
                          #"POINT_CHANGE","PERCENT_CHANGE"
                          )
  
  AS_LIST[[i]]<-FTSE_TABLE
}

ALL_SHARE_FTSE_DF<-map_df(AS_LIST,data.frame)
ALL_SHARE_FTSE_DF$DATE<-Sys.Date()
sheet_name<-as.character(Sys.Date())
write.xlsx(ALL_SHARE_FTSE_DF, file = "ALL_SHARE_FTSE_FIRM_LIST.xlsx", 
           sheetName=sheet_name,
           append=TRUE)
