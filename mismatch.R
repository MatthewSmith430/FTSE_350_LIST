write.csv(REUTER_MISSING,"REUTER_MISSING.csv")
library(xlsx)
library(readxl)
F18<-read_excel("FTSE_350_FIRM_LIST.xlsx")
F18<-read_excel("FTSE_350_FIRM_LIST.xlsx",sheet = "2018-11")
F19<-read_xlsx("FTSE_350_FIRM_LIST.xlsx",sheet = "2019-08-16")
View(F19)
code_19<-F19$CODE
code_18<-F18$CODE
name19<-F19$NAME
name18<-F18$NAME
#In 18 not 19
setdiff(name18,name19)
#In 19 not 18
setdiff(name19,name18)
#In 18 not 19
write.csv(setdiff(name18,name19),"LEAVE18.csv")
#In 19 not 18
write.csv(setdiff(name19,name18),"JOINED19.csv")
library(CompaniesHouse)
