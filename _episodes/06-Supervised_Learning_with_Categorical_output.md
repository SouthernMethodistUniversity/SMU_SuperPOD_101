---
title: "Supervised Learning with Categorical Output"
teaching: 20
exercises: 0
questions:
- "How to train a Machine Learning model with categorical output"
objectives:
- "Learn to use different Regression algorithm for Machine Learning training"
keypoints:
- "categorical output"
---
# 6 Supervised Learning training with Categorical output

Here we use the R sampled data named iris

```r
data(iris)
```

## 6.1 Pre-processing data and treat missing value

Check missing value

```r
sum(is.na(iris))
```
There are no missing value so we go ahead with visualize the important data

## 6.2 Visualize the important data

```r
library(GGally)
ggpairs(iris,aes(colour=Species))
```

![image](https://user-images.githubusercontent.com/43855029/156045609-25ab64b2-8194-4eae-9613-0bc838f1ee68.png)

## 6.3 Split data into training and testing

```r
indT <- createDataPartition(y=iris$Species,p=0.6,list=FALSE)
training <- iris[indT,]
testing  <- iris[-indT,]
```

Let's use all inputs data for modeling

## 6.4 Train model and predict with different algorithm

### 6.4.1 Train model using Linear Discriminant Analyst:

```{r}
ModFit_lda <- train(Species~.,data=training,
                 preProcess=c("center","scale"),
                 method="lda")
predict_lda <- predict(ModFit_lda,testing)                 
```

### 6.4.2 Train model using Naive Bayes

```r
  ModFit_nb <- train(Species~.,data=training,method="nb")
  predict_nb <- predict(ModFit_nb,testing)                 

```

### 6.4.3 Train model using Gradient Boosting Machine

```r
ModFit_GBM <- train(Species~.,data=training,method="gbm",verbose=FALSE)
predict_GBM <- predict(ModFit_GBM,testing)
```

### 6.4.4 Train model using Random Forest

```r
ModFit_rf <- train(Species~.,data=training,method="rf",prox=TRUE)
predict_rf <- predict(ModFit_rf,testing)                                                            
```

### 6.4.5 Train model using Artificial Neural Network

```r
ModNN <- neuralnet(Species~.,training, hidden=c(4,3),linear.output = FALSE)
plot(ModNN)

predict_ann <- compute(ModNN,testing)
# Rescale to original:
yann=data.frame("yhat"=ifelse(max.col(predict_ann$net.result)==1, "setosa",
                              ifelse(max.col(predict_ann$net.result)==2, "versicolor", "virginica")))      
```

![image](https://user-images.githubusercontent.com/43855029/156047814-3722097f-176d-4745-a2a5-454fe2b80c78.png)

## 6.5 Evaluate model output

For continuous, we use postResample:

```r
confusionMatrix(predict_lda,testing$Species)
confusionMatrix(predict_nb,testing$Species)
confusionMatrix(predict_GBM,testing$Species)
confusionMatrix(predict_rf,testing$Species)
confusionMatrix(yann$yhat,testing$Species)
```
