library(twitteR)
library(RJSONIO)
library(bitops)
library(RCurl)

## Create a connection to your app in twitter
credentials <- OAuthFactory$new(consumerKey="16d1Qa3J1PdBXnvtI9fIkqM5t" ,consumerSecret="XqOrnAO7YlE1MX9QdKDT95RwRwDwVf79enlPKwRLONF0jrLDC6",requestURL="https://api.twitter.com/oauth/request_token",accessURL="https://api.twitter.com/oauth/access_token",authURL="https://api.twitter.com/oauth/authorize")

# SSL certificates required for secure communication
download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

credentials$handshake(cainfo="cacert.pem")


## For checking if the connection is working just put below command and see if you get true
registerTwitterOAuth(credentials)
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

# Fetch 100 tweets 
tweetList <- searchTwitter("@elonmusk", n=100)
elonmusk.df = twListToDF(tweetList)
write.csv(elonmusk.df, file="elonmusk.csv", row.names = F)