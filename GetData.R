## JHU Data Science

## Capstone


## Get the data

library(jsonlite)
if(!file.exists("E:/Rspace/JHU_CPA_data")){dir.create("E:/Rspace/JHU_CPA_data")}

# business data
businessData<- stream_in(file("E:/RSpace/yelp_dataset/business.json"))
saveRDS(businessData,"E:/Rspace/JHU_CPA_data/businessData.rds")
rm(businessData)

# checkin data
checkinData<- stream_in(file("E:/RSpace/yelp_dataset/yelp_academic_dataset_checkin.json"))
saveRDS(checkinData,"E:/Rspace/JHU_CPA_data/checkinData.rds")
rm(checkinData)

# review data
reviewData<- stream_in(file("E:/RSpace/yelp_dataset/yelp_academic_dataset_review.json"))
saveRDS(reviewData,"E:/Rspace/JHU_CPA_data/reviewData.rds")
rm(reviewData)

# tip data
tipData<- stream_in(file("E:/RSpace/yelp_dataset/yelp_academic_dataset_tip.json"))
saveRDS(tipData,"E:/Rspace/JHU_CPA_data/tipData.rds")
rm(tipData)

# user data
userData<- stream_in(file("E:/RSpace/yelp_dataset/yelp_academic_dataset_user.json"))
saveRDS(userData,"E:/Rspace/JHU_CPA_data/userData.rds")
rm(userData)

## Investigate the review data

## Question 3
review<-readRDS("./data/reviewData.rds")
str(review)

## Question 4
review$text[100]

## Question 5
summary(as.factor(review$stars))[5]/nrow(review)

## Question 6
# How many lines are there in the businesses file?
business<-readRDS("./data/businessData.rds")
nrow(business)

## Question 7

# Conditional on having an response for the attribute "Wi-Fi", how many businesses are reported
# for having free wi-fi (rounded to the nearest percentage point)?
names(business$attributes)
wifi_response<-sum((!is.na(business$attributes[[20]])),rm.na=TRUE)
wifi_free<-sum(business$attributes[[20]]=="free",na.rm=TRUE)
wifi_free/wifi_response

## Question 8
# How many lines are in the tip file?
tip<-readRDS("./data/tipData.rds")
nrow(tip)

## Question 9
# In the tips file on the 1,000th line, fill in the blank: "Consistently terrible ______"
names(tip)
tip$text[1000]

## Question 10
# What is the name of the user with over 10,000 compliment votes of type "funny"?
user<-readRDS("./data/userData.rds")
names(user)
str(user$compliments)
summary(user$compliments$funny)
funniest<-subset(user,user$compliments$funny>10000)
nrow(funniest)
funniest$name


## Question 11
# Create a 2 by 2 cross tabulation table of when a user has more than 1 fans to if the user
# has more than 1 compliment vote of type "funny". Treat missing values as 0 (fans or votes of that type).
# Pass the 2 by 2 table to fisher.test in R. What is the P-value for the test of independence?
funny<-user$compliment$funny
funny[is.na(funny)]<-0
funnyGT1<-funny>1

fans<-user$fans
fans[is.na(fans)]<-0
fansGT1<-fans>1

ff<-table(funnyGT1,fansGT1)
