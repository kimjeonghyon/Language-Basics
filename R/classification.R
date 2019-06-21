#  분류분석
install.packages("rpart")

library(rpart) # rpart() : 분류모델 생성

install.packages("rpart.plot")

library(rpart.plot) # prp(), rpart.plot() : rpart 시각화

install.packages('rattle')

library('rattle') # fancyRpartPlot() : node 번호 시각화




# 단계1. 실습데이터 생성

data(iris)

head(iris)

set.seed(415)

idx = sample(1:nrow(iris), 0.7*nrow(iris))

train = iris[idx, ]

test = iris[-idx, ]

dim(train) # 105 5

dim(test) # 45  5




table(train$Species)

head(train)




# 단계2. 분류모델 생성

# rpart(y변수 ~ x변수, data)

model = rpart(Species~., data=train) # iris의 꽃의 종류(Species) 분류

model

?rpart




# 분류모델 시각화 - rpart.plot 패키지 제공

prp(model) # 간단한 시각화  

rpart.plot(model) # rpart 모델 tree 출력

fancyRpartPlot(model) # node 번호 출력(rattle 패키지 제공)




# 단계3. 분류모델 평가 

pred <- predict(model, test) # 비율 예측

pred <- predict(model, test, type="class") # 분류 예측

pred

# 1) 분류모델로 분류된 y변수 보기

table(pred)




# 2) 분류모델 성능 평가

table(pred, test$Species) # 비율 예측 결과로는 table 생성 안 됨, 서로 모양이 달라서

t <- table(pred, test$Species)




(t[1,1]+t[2,2]+t[3,3])/nrow(test)


# ------------------------------------------
# 로지스틱 회귀분석 1
# ------------------------------------------

## [실습1] mtcars (자동차 모델별 성능정보)  데이터 셋을 이용한 로지스틱 회귀 모델 생성

## hp(마력), wt(중량), cyl 컬럼을 이용해 am(자동/수동)값을 찾는 로지스틱 회귀모델 생성




# 단계1. 실습데이터 생성

data(mtcars)

head(mtcars)




input <- mtcars[,c("am","cyl","hp","wt")]

print(head(input))




#단계2. 분류모델 생성

am.data = glm(formula = am ~ cyl + hp + wt, data = input, family = binomial)




# 단계3. 분류모델 평가 

print(summary(am.data))




#결과 : P 값으로서 요약 변수 "CYL"및 "HP"우리가 변수 "AM"값에 영향이 적고, ‘WT’ 값은 영향이 있음


# ------------------------------------------
# 로지스틱 회귀분석 2
# ------------------------------------------
## [실습2] iris 데이터 셋을 이용한 로지스틱 회귀 모델 생성




# 단계1. 실습데이터 생성

data(iris)

head(iris)




row_0 <- subset(iris)

# setosa와 versicolor만 선택하여 데이터셋으로 저장

data_1 <- subset(row_0, Species=='setosa'|Species=='versicolor')

#해당변수는 Factor형으로 setosa는 Y=1, versicolor는 Y=2로 인식

data_1$Species <- factor(data_1$Species)

str(data_1)




#단계2. 분류모델 생성

out <- glm(Species~Sepal.Length, data=data_1, family=binomial)

 

# 단계3. 분류모델 평가 

summary(out)





# ------------------------------------------
# 랜덤 포레스트
# ------------------------------------------
##################################################

# randomForest practice

##################################################




install.packages('randomForest')

library(randomForest)




data(iris)




# 1. 랜덤 포레스트 모델 생성 (형식: randomForest(y ~ x, data, ntree, mtry) )

model = randomForest(Species~., data=iris) 




# 2. 파라미터 조정 300개의 Tree와 4개의 변수 적용 모델 생성

model = randomForest(Species~., data=iris,

                     ntree=300, mtry=4, na.action=na.omit)




# 3. 최적의 파리미터(ntree, mtry) 찾기

# - 최적의 분류모델 생성을 위한 파라미터 찾기

ntree <- c(400, 500, 600)

mtry <- c(2:4)




# 2개 vector이용 data frame 생성

param <- data.frame(n=ntree, m=mtry)




for(i in param$n){ # 400,500,600

  cat('ntree = ', i, '\n')

  for(j in param$m){ # 2,3,4

    cat('mtry = ', j, '\n')

    model = randomForest(Species~., data=iris,

                         ntree=i, mtry=j,

                         na.action=na.omit )   

    print(model)

  }

}




# 4. 중요 변수 생성 

model3 = randomForest(Species ~ ., data=iris,

                      ntree=500, mtry=2,

                      importance = T, # 중요변수 추출하기 위한 옵션

                      na.action=na.omit )

importance(model3)

# MeanDecreaseAccuracy higher the better 분류정확도 개선에 기여하는 변수

# MeanDecreaseGini     higher the better 진위계수? 불확실성 = 노드 불순도 = entropy 개선에 기여하는 변수




varImpPlot(model3) # 중요변수 plot 생성

# ---------------------------------
# 부스팅
# ---------------------------------
##################################################

# Boosting practice

##################################################




install.packages("adabag")

library(adabag)

library(rpart)

data(iris)

iris.adaboost <- boosting(Species~., data=iris, boos=TRUE, mfinal=3)

iris.adaboost




## Data Vehicle (four classes)

library(mlbench)

data(Vehicle)

l <- length(Vehicle[,1])

sub <- sample(1:l,2*l/3)

mfinal <- 3

maxdepth <- 5




Vehicle.rpart <- rpart(Class~.,data=Vehicle[sub,],maxdepth=maxdepth)

Vehicle.rpart.pred <- predict(Vehicle.rpart,newdata=Vehicle[-sub, ],type="class")

tb <- table(Vehicle.rpart.pred,Vehicle$Class[-sub])

error.rpart <- 1-(sum(diag(tb))/sum(tb))

tb

error.rpart




Vehicle.adaboost <- boosting(Class ~.,data=Vehicle[sub, ],mfinal=mfinal, coeflearn="Zhu",

                             control=rpart.control(maxdepth=maxdepth))

Vehicle.adaboost.pred <- predict.boosting(Vehicle.adaboost,newdata=Vehicle[-sub, ])

Vehicle.adaboost.pred$confusion

Vehicle.adaboost.pred$error




#comparing error evolution in training and test set

errorevol(Vehicle.adaboost,newdata=Vehicle[sub, ])->evol.train

errorevol(Vehicle.adaboost,newdata=Vehicle[-sub, ])->evol.test




plot.errorevol(evol.test,evol.train)


# -----------------------------
# 나이브베이즈
# ------------------------------


##################################################

# Naive Bayes practice

##################################################

# 조건부 확률 적용 예측

# 비교적 성능 우수

# 베이즈 이론 적용

#  -> 조건부 확률 이용

#  -> 스펨 메시지 분류에 우수함




# 조건부 확률 : 사건 A가 발생한 상태에서 사건 B가 발생할 확률

# P(B|A) = P(A|B) * P(B) / P(A)

# ----------------------------------------------------------

# ex) 비아그라,정력 단어가 포함된 메시지가 스팸일 확률

# P(스팸|비아그라,정력)

# 사건 A : 비아그라, 정력 -> P(A) : 5/100(5%)

# 사건 B : 스팸 -> P(B) : 20/100(20%)

# P(A|B) : 스팸일때 비아그라, 정력일 경우 -> 4/20(20%)




##################################################

# Naive Bayes 기본실습 : iris

##################################################




# 패키지 설치

install.packages('e1071')

library(e1071) # naiveBayes()함수 제공  




# 1. train과 test 데이터 셋 생성 

data(iris)

idx <- sample(1:nrow(iris), 0.7*nrow(iris)) # 7:3 비율




train <- iris[idx, ]

test <- iris[-idx, ]

train; test

nrow(train)







# 2. 분류모델 생성 : train data 이용   

# 형식) naiveBayes(train, class) - train : x변수, calss : y변수

model <- naiveBayes(train[-5], train$Species)

model # 학습 데이터를 이용하여 x변수(4개)를 y변수로 학습시킴 




# 3. 분류모델 평가 : test data 이용

# 형식) predict(model, test, type='class') 

p <- predict(model, test) # test : y변수가 포함된 데이터 셋




# 4. 분류모델 평가(예측결과 평가)

table(p, test$Species) # 예측결과, test data의 y변수  

t <- table(p, test$Species)




# 분류 정확도

(t[1,1]+t[2,2]+t[3,3])/nrow(test)







# --------------------------
# KNN
# --------------------------

install.packages("class")

library("class")

set.seed(1234)




ind <- sample(1:nrow(iris), nrow(iris))




iris.training <- iris[ifelse(ind%%5!=0,ind,0), 1:4]

iris.test <- iris[ifelse(ind%%5==0,ind,0), 1:4]

dim(iris.training)

dim(iris.test)




iris.trainLabels <- iris[ifelse(ind%%5!=0,ind,0), 5]

iris.testLabels <- iris[ifelse(ind%%5==0,ind,0), 5]




iris_pred <- knn(train = iris.training, test = iris.test, cl = iris.trainLabels, k=3)




sum(iris_pred != iris.testLabels)

data(iris)

d <- iris head(d)




## 2. 시각화

install.packages("ggvis")

library(ggvis)

iris %>% ggvis(~Petal.Length, ~Petal.Width, fill=~factor(Species)) %>% layer_points() # 꽃잎 너비와 길이는 관계가 있는 것으로 보임




## 3. data split table(d$Species) # 총 150개

# random 을 위한 seed 값

set.seed(1234)




idx <- sample(1:nrow(d), 0.7*nrow(d))

iris.train <- d[idx,]  # 70% 학습에 사용

iris.test <- d[-idx,]  # 30% 테스트에 사용

nrow(iris.train); nrow(iris.test);




## 4. 데이터로부터 학습/모델 트레이닝

library(class)

# K=3~13 에 대하여 KNN 실행

# 최적의 k 찾기

result <- c()

for ( i in 3:13 ) { iris_model <- knn(train = iris.train[,-5], 

                                                       test = iris.test[,-5],

                                                       cl = iris.train$Species, k=i )

     t <- table(iris_model, iris.test$Species)

    accuracy <- ((t[1,1]+t[2,2]+t[3,3]) / nrow(iris.test))

    result <- c(result, accuracy) 

}




acc_df <- data.frame(k=3:13, accuracy=result)

acc_df[order(acc_df$acc, decreasing = T),]




# k=3 선택

iris_model <- knn(train = iris.train[,-5],

                   test = iris.test[,-5],

                   cl = iris.train$Species, k=3)

summary(iris_model)




## 5. 모델평가

table(iris_model, iris.test$Species)

# coufusion matrix

install.packages("gmodels")

library(gmodels)

CrossTable(x=iris.test$Species, y=iris_model, prop.chisq = F)


# ---------------------
# SVM
# ---------------------


library("e1071")

head(iris,5)

attach(iris)




x <- subset(iris, select=-Species)

y <- Species




# Create SVM Model and show summary

svm_model <- svm(Species ~ ., data=iris)

summary(svm_model)




# Create SVM Model and show summary

svm_model1 <- svm(x,y)

summary(svm_model1)




# Run Prediction and you can measuring the execution time in R

pred <- predict(svm_model1,x)

system.time(pred <- predict(svm_model1,x))




# See the confusion matrix result of prediction, using command table to compare the result of SVM prediction and the class data in y variable. table(pred,y)

# TUning SVM to find the best cost and gamma ..

svm_tune <- tune(svm, train.x=x, train.y=y,

                  kernel="radial",

                  ranges=list(cost=10^(-1:2), gamma=c(.5,1,2))) print(svm_tune)




# After you find the best cost and gamma, you can create svm model again and try to run again

svm_model_after_tune <- svm(Species ~ ., data=iris, kernel="radial", cost=1, gamma=0.5)

summary(svm_model_after_tune)




# Run Prediction again with new model

pred <- predict(svm_model_after_tune,x)

predict(svm_model_after_tune,x)

table(pred,y)


# -------------------------
# 인공신경망
# -------------------------

## [실습1] iris 데이터 셋을 이용한 인공신경망 모델 생성




# 단계1 : 데이터 셋 생성 

install.packages("nnet")   # 인공신경망 모델 생성 패키지

library(nnet)

data(iris)

idx = sample(1:nrow(iris), 0.7*nrow(iris))

training = iris[idx, ]

testing = iris[-idx, ]

nrow(training) # 105(70%)

nrow(testing) # 45(30%)




# 단계2 :  인공신경명 모델 생성

model_net_iris1 = nnet(Species ~ ., training, size = 1) # hidden=1

model_net_iris1 # 11 weights

model_net_iris3 = nnet(Species ~ ., training, size = 3) # hidden=3

model_net_iris3 # 27 weights




# 단계3 : 가중치 망보기 

summary(model_net_iris1) # 1개 가중치 확인

summary(model_net_iris3) # 3개 가중치 확인




# 단계4 : 분류모델 평가

table(predict(model_net_iris1, testing, type = "class"), testing$Species)

table(predict(model_net_iris3, testing, type = "class"), testing$Species)







## [실습2]  neuralnet 패키지 이용 인공신경망 모델 생성




# 단계1 : 패키지 설치

install.packages('neuralnet')

library(neuralnet)




# 단계2 : 데이터 셋 생성

data("iris")

idx = sample(1:nrow(iris), 0.7*nrow(iris))

training_iris = iris[idx, ]

testing_iris = iris[-idx, ]

dim(training_iris) # 105   6

dim(testing_iris) # 45  6







# 단계3 : 숫자형으로 칼럼 생성

training_iris$Species2[training_iris$Species == 'setosa'] <- 1

training_iris$Species2[training_iris$Species == 'versicolor'] <- 2

training_iris$Species2[training_iris$Species == 'virginica'] <- 3

training_iris$Species <- NULL

head(training_iris)




# 단계4 : 데이터 정규화

# (1) 정규화 함수 정의 : 0 ~ 1 범위로 정규화

normal <- function(x){

  return (( x - min(x)) / (max(x) - min(x)))

}




# (2) 정규화 함수를 이용하여 학습데이터/검정데이터 정규화

training_nor <- as.data.frame(lapply(training_iris, normal))

summary(training_nor) # 0 ~ 1 확인




testing_nor <- as.data.frame(lapply(testing_iris, normal))

summary(testing_nor) # 0 ~ 1 확인




# 단계5 : 인공신경망 모델 생성 : 은닉노드 1개

model_net = neuralnet(Species2 ~ Sepal.Length+Sepal.Width+Petal.Length+Petal.Width,

                      data=training_nor, hidden = 1)

model_net




plot(model_net) # Neural Network 모형 시각화




# 단계6 : 분류모델 성능 평가

# (1) compute() 함수 이용

model_result <- compute(model_net, testing_nor[c(1:4)])

model_result$net.result # 분류 예측값 보기 




# (2) 상관분석 : 상관계수로 두 변수 간의 선형관계의 강도 측정

cor(model_result$net.result, testing_nor$Species2)




# 단계7 : 분류모델 성능 향상 : 은닉노드 2개, backprop 적용

# (1) 인공신경망 모델 생성

model_net2 = neuralnet(Species2 ~ Sepal.Length+Sepal.Width+Petal.Length+Petal.Width,

                       data=training_nor, hidden = 2, algorithm="backprop", learningrate=0.01 )




# (2) 분류모델 예측치 생성과 평가

model_result2 <- compute(model_net2, testing_nor[c(1:4)])

cor(model_result2$net.result, testing_nor$Species2)


