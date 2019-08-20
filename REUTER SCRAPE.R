library(readxl)
FTSE_MEM<-read_xlsx("FTSE_350_FIRM_LIST.xlsx",sheet = "2019-08-16")
CODE<-FTSE_MEM$CODE
CODE2<-paste0(CODE,".L")
FTSE_URL<-"https://www.reuters.com/finance/stocks/company-officers/"
url<-paste0(FTSE_URL,CODE2[[i]])
webpage<-read_html(url)%>%
  html_table()
FTSE_TABLE<-webpage[[1]]
FTSE_TABLE$company_code<-CODE[[i]]


FTSE_R_TABLE_LIST<-list()
for (i in 349:length(CODE2)){
  FTSE_URL<-"https://www.reuters.com/finance/stocks/company-officers/"
  url<-paste0(FTSE_URL,CODE2[[i]])
  webpage<-read_html(url)%>%
    html_table()
  FTSE_TABLE<-webpage[[1]]
  
  FTSE_TABLE$company_code<-CODE[[i]]
  
  FTSE_R_TABLE_LIST[[i]]<-FTSE_TABLE
  print(i)
  
}
missing_code<-c(6,7,8,9,18,21,25,26,28,31,38,40,42,43,50,55,
                61,63,71,72,73,80,85,92,93,99,107,111,119,121,
                126,133,135,142,143,145,148,153,164,168,169,171,
                176,185,195,201,203,204,213,217,219,220,225,228,
                229,230,234,238,239,241,243,251,256,257,268,269,
                278,292,295,296,305,310,311,314,322,325,326,328,
                333,335,336,347,348)

REUTER_SCRAPE_DF<-map_df(FTSE_R_TABLE_LIST,data.frame)[,1:5]

REUTER_SCRAPE_DF$company_name<-REUTER_SCRAPE_DF$company_code
REUTER_SCRAPE_DF$company_name<-FTSE_MEM$NAME[match(REUTER_SCRAPE_DF$company_name,
                                                   FTSE_MEM$CODE)]
write.csv(REUTER_SCRAPE_DF,"REUTER_SCRAPE_DF.csv")

MISSING_LIST<-list()

for (j in 1:length(missing_code)){
  R<-missing_code[[j]]
  RR<-CODE[R]
  MEM_M<-dplyr::filter(FTSE_MEM,CODE==RR)
  MISSING_LIST[[j]]<-MEM_M
}

REUTER_MISSING<-map_df(MISSING_LIST,data.frame)

write.csv(REUTER_MISSING,"REUTER_MISSING.csv")
  