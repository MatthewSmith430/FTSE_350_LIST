library(rtweet)
library(purrr)
library(magrittr)
library(xlsx)

wb <- loadWorkbook("FTSE_350_FIRM_LIST.xlsx")
sheets <- getSheets(wb)
SS<-names(sheets)

FILE<-read.xlsx("FTSE_350_FIRM_LIST.xlsx", sheetName = SS[[3]])

FIRMS<-FILE$FULL.NAME%>%as.character()
ftse_tweet_list<-list()
for (i in 1:length(FIRMS)){
  FF<-FIRMS[[i]]
  usrs <- search_users(FF, n = 1)
  SN<-usrs$screen_name
  if (is.null(SN)){
    FF2<-gsub(" PLC","",FF)
    USER2<-search_users(FF, n = 1)
    SN2<-USER2$screen_name
    if (is.null(SN2)){
      screen_name<-"NA"
    }else{
      screen_name<-SN2
    }
  }else{
    screen_name<-SN
  }
  DF<-tibble(firm_name=FF,
             twitter_screen_name=screen_name)
  ftse_tweet_list[[i]]<-DF
}

ftse_tweet_df<-map_df(ftse_tweet_list,data.frame)
library(readr)
write_csv(ftse_tweet_df,paste0("FTSE_TWEET_",SS[[3]],"2.csv"))

          