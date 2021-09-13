########################
## 네이버 뉴스 크롤링 ##
########################

install.packages("httr")
install.packages("rvest")
install.packages("dplyr")
install.packages("stringr")

library(httr)
library(rvest)

date = 20210823
page=2
url = paste0('https://news.naver.com/main/list.naver?mode=LS2D&mid=shm&sid2=229&sid1=105&date=', date, '&page=', page)
url
data=GET(url)
data_title = data %>%
  read_html(encoding='EUC-KR') %>%
  html_nodes('dl') %>%
  html_nodes('dt') %>%
  html_nodes('a') %>%
  html_text()

data_title

gsub("\r\n\t\t\t\t\t\t\t\t", "",data_title)

date_start <- as.Date(as.character(20210101),format='%Y%m%d')
date_end <- as.Date(as.character(20210630), format='%Y%m%d')
date <- date_start:date_end

date <-as.Date(date, origin='1970-01-01')
date<-as.character(date)
date<-gsub('-','',date)

page <- 1:2

date

date_start <- as.Date(as.character(20210101),format='%Y%m%d')
date_end <- as.Date(as.character(20210630), format='%Y%m%d')
date <- date_start:date_end
date <-as.Date(date, origin='1970-01-01')
date<-as.character(date)
date<-gsub('-','',date)

game_data = list()
head(game_data)
n=1
for (i in date){
  for (j in page) {
    url = paste0('https://news.naver.com/main/list.naver?mode=LS2D&sid2=229&mid=shm&sid1=105&date=', i, '&page=', j)
    data=GET(url)
    data_title = data %>%
      read_html(encoding='EUC-KR') %>%
      html_nodes('dl') %>%
      html_nodes('dt') %>%
      html_nodes('a') %>%
      html_text()
    
    data_title <- gsub("\r\n\t\t\t\t\t\t\t\t", "",data_title)
    game_data[[n]] <- data_title
    n=n+1
  }
}
game_data<-unlist(game_data)

game_data
game_data <- game_data[game_data!=" "]

Sys.setenv(JAVA_HOME = 'C:/Program Files/Java/jdk-16.0.2')
Sys.getenv("JAVA_HOME")
install.packages("rJava")
install.packages("tm")

install.packages("multilinguer")

library(multilinguer)

#multilinguer::install_jdk() 

install.packages(c("hash", "tau", "Sejong", "RSQLite", "devtools", "bit", "rex",
                   "lazyeval", "htmlwidgets", "crosstalk", "promises", "later",
                   "sessioninfo", "xopen", "bit64", "blob", "DBI", "memoise", "plogr",
                   "covr", "DT", "rcmdcheck", "rversions"), type = "binary")

install.packages("remotes")

remotes::install_github('haven-jeon/KoNLP', upgrade = "never",
                        INSTALL_opts=c("--no-multiarch"))

library(KoNLP) #최종적으로 "KoNLP" 패키지를 불러옵니다
extractNoun('테스트 입니다')



library(rJava)
#library(KoNLP)
useSejongDic()
library(tm)

word <- extractNoun(game_data) #<-여기서 에러**
word <-unlist(word)
word


word_table <- table(word)
word_table <- sort(word_table, decreasing=TRUE)
head(word_table)
word_table <- paste(names(word_table), word_table, sep=',')
word_table
cat('word, frequency', word_table, file='game_news.csv', sep='\n') # 이거 만들고 파일 내용 확인


View(word_table)
######################33
install.packages("wordcloud2")
library(wordcloud2)
library(RColorBrewer)
col <- brewer.pal(12, "Paired")
game_word <- read.csv("game_news1.csv")
wordcloud2(game_word, color=col, size=1, fontFamily = "맑은고딕", rotateRatio=0)