library(rvest)
library(purrr)
library(magrittr)
library(xlsx)

#FTSE_URL<-"https://www.londonstockexchange.com/exchange/prices-and-markets/stocks/indices/constituents-indices.html?index=NMX&page="
AIM_SHARE_URL<-"https://www.londonstockexchange.com/exchange/prices-and-markets/stocks/indices/summary/summary-indices-constituents.html?index=AXX&page="
AIM_LIST<-list()

for (i in 1:37){
  
  url<-paste0(AIM_SHARE_URL,i)
  webpage<-read_html(url)%>%
    html_table()
  FTSE_TABLE<-webpage[[1]]
  FTSE_TABLE<-FTSE_TABLE[,1:2]
  colnames(FTSE_TABLE)<-c("CODE","NAME"#,"CUR","PRICE",
                          #"POINT_CHANGE","PERCENT_CHANGE"
  )
  
  AIM_LIST[[i]]<-FTSE_TABLE
}

AIM_DF<-map_df(AIM_LIST,data.frame)
AIM_DF$DATE<-Sys.Date()
sheet_name<-as.character(Sys.Date())
write.xlsx(AIM_DF, file = "AIM_ALL_SHARE_FIRM_LIST.xlsx", 
           sheetName=sheet_name,
           append=TRUE)
