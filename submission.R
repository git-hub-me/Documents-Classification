#install required packages
install.packages(stringr)
install.packages(tm)
install.packages(RTextTools)
install.packages(topicmodels)
install.packages(e1071)

library(stringr)
library(tm)
library(RTextTools)
library(topicmodels)
library(e1071)

setwd("path to file directory") #path to file directory containing trainingdata.txt and testfile.txt (input)

#Importing data
source <- readLines("trainingdata.txt")
m = as.integer(source[1])  

#splitting the data into line category and document
train <- str_split(source[-1]," ",n=2)
train <- data.frame(matrix(unlist(train), nrow=m, byrow=T))
train <- setNames(train, c("category","document"))

# Making a matrix and cleaning the text
mat <- create_matrix(train$document, language="english", 
                     removeNumbers=TRUE,
                     removePunctuation = TRUE,
                     removeStopwords = TRUE, 
                     stripWhitespace = TRUE)
set.seed(1234)
#SVM model
container <- create_container(mat, train$category, trainSize=1:4400,testSize=4401:5485, virgin=FALSE)
model <- train_model(container, 'SVM',kernel='linear') 
results <- classify_model(container, model)
table(as.character(train$category[4401:5485]), as.character(results[,"SVM_LABEL"]))
recall_accuracy(train$category[4401:5485], results[,"SVM_LABEL"])
#1020 documents correctly predicted out of 1085 documents
#accuracy is 0.9400 --> score is 94

#testfile----> your file goes here
test <- readLines("testfile.txt")
l <- length(test)-1 #first line specifies no of lines
test <- data.frame(matrix(unlist(test[-1]), nrow=l, byrow=T))
test <- setNames(test, c("document"))

#change in function: "Acronym" to "acronym"
print("please go to line 42 in the function window pop up and change 'Acronym' to 'acronym'. ")
trace("create_matrix", edit=T)

#matrix creation based on training matrix
testmat <- create_matrix(test$document,originalMatrix = mat )

#testcontainer prediction
testcontainer <- create_container(testmat, labels=rep(0,l), testSize = 1:l,virgin = FALSE)
testresults <- classify_model(testcontainer, model)

#writing an output file in specified format
write.table(as.integer(testresults[,"SVM_LABEL"]),"output.txt",row.names = FALSE, col.names = FALSE)

