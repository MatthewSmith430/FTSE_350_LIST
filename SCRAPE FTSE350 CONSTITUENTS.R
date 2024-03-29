library(rvest)
library(purrr)
library(magrittr)
library(xlsx)

FTSE_URL<-"https://www.londonstockexchange.com/indices/ftse-350/constituents/table?page="
FTSE_LIST<-list()

for (i in 1:18){
  
  url<-paste0(FTSE_URL,i)
  webpage<-read_html(url)%>%
    html_table()
  FTSE_TABLE<-webpage[[1]]
  #FTSE_TABLE<-FTSE_TABLE[,1:6]
  
  colnames(FTSE_TABLE)<-c("CODE","NAME","CUR","MARKET_CAP","PRICE",
                          "POINT_CHANGE","PERCENT_CHANGE")
  FTSE_TABLE$POINT_CHANGE<-FTSE_TABLE$POINT_CHANGE%>%
    as.character()
  
  FTSE_LIST[[i]]<-FTSE_TABLE
}

FTSE_350_DF<-map_df(FTSE_LIST,data.frame)
#FTSE_350_DF<-bind_rows(FTSE_LIST)
FTSE_350_DF$DATE<-Sys.Date()
sheet_name<-as.character(Sys.Date())
write.xlsx(FTSE_350_DF, file = "FTSE_350_FIRM_LIST.xlsx", 
           sheetName=sheet_name,
           append=TRUE)
