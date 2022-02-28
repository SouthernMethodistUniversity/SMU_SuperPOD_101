---
title: "Supervised Learning with Continuous Output"
teaching: 20
exercises: 0
questions:
- "How to train a Machine Learning model using Regression method"
objectives:
- "Learn to use different Regression algorithm for Machine Learning training"
keypoints:
- "Regression training"
---
# 5 Supervised Learning training
## 5.1 For Continuous output

Here we use the R sampled data named airquality with some missing values.

```r
data(airquality)
```

### Pre-processing data and treat missing value

Check missing value

```r
sum(is.na(airquality))
```

Impute missing value using Bagging approach

```r
PreImputeBag <- preProcess(airquality,method="bagImpute")
airquality_imp <- predict(PreImputeBag,airquality)
```

### Visualize the important data

```r
library(GGally)
ggpairs(airquality_imp,aes(colour=factor(Month)))
```

![image](https://user-images.githubusercontent.com/43855029/156043017-4fa675b1-d840-45b3-a637-54ad342c5e89.png)

### Split data into training and testing

```r
indT <- createDataPartition(y=airquality_imp$Ozone,p=0.6,list=FALSE)
training <- airquality_imp[indT,]
testing  <- airquality_imp[-indT,]
```

Let's use all inputs data (except Month/Day) for modeling

### Train model and predict with different algorithm

#### Train model using Linear modeling: 'method=lm'

```{r}
ModFit_lm <- train(Ozone~Solar.R+Wind+Temp,data=training,
                 preProcess=c("center","scale"),
                 method="lm")
predict_lm <- predict(ModFit_lm,testing)                 
```

#### Train model using Stepwise Linear Regression

```r
ModFit_SLR <- train(Ozone~Solar.R+Wind+Temp,data=training,method="lmStepAIC")
predict_SLR <- predict(ModFit_SLR,testing)                 

```

#### Train model using Polynomial Regression

![image](https://user-images.githubusercontent.com/43855029/122609104-6c1e9400-d04b-11eb-984c-ed20f0926451.png)

In this study, let use polynomial regression with degree of freedom=3

```r
ModFit_poly <- train(Ozone~poly(Solar.R,3)+poly(Wind,3)+poly(Temp,3),data=training,
                     preProcess=c("center","scale"),
                     method="lm")
predict_poly <- predict(ModFit_poly,testing)                                      
```

#### Train model using Principal Component Regression

Linear Regression using the output of a Principal Component Analysis (PCA). 
PCR is skillful when data has lots of highly correlated predictors

```r
ModFit_PCR <- train(Ozone~Solar.R+Wind+Temp,data=training,method="pcr")
predict_PCR <- predict(ModFit_PCR,testing)  
```

#### Train model using Decision Tree

```r
ModFit_rpart <- train(Ozone~Solar.R+Wind+Temp,data=training,method="rpart",
                      parms = list(split = "gini"))
predict_rpart <- predict(ModFit_rpart,testing)                                                            
```

#### Train model using Random Forest

```r
ModFit_rf <- train(Ozone~Solar.R+Wind+Temp,data=training,method="rf",prox=TRUE)
predict_rf <- predict(ModFit_rf,testing)                                                            
```

#### Train model using Artificial Neural Network

```r
library(neuralnet)
smax <- apply(training,2,max)
smin <- apply(training,2,min)
trainNN <- as.data.frame(scale(training,center=smin,scale=smax-smin))
testNN <- as.data.frame(scale(testing,center=smin,scale=smax-smin))
ModNN <- neuralnet(Ozone~Solar.R+Wind+Temp,trainNN, hidden=3,linear.output = T)
plot(ModNN)

predict_ann <- compute(ModNN,testNN)
# Rescale to original:
predict_ann_rescale <- predict_ann$net.result*(smax-smin)[1]+smin[1]
```

![image](https://user-images.githubusercontent.com/43855029/156043689-bcf75a49-c671-4c51-bad8-a40315109900.png)

### Evaluate model output

For continuous, we use postResample:

```r
postResample(predict_lm,testing$Ozone)
postResample(predict_SLR,testing$Ozone)
postResample(predict_PCR,testing$Ozone)
postResample(predict_poly,testing$Ozone)
postResample(predict_rpart,testing$Ozone)
postResample(predict_rf,testing$Ozone)
postResample(predict_ann_rescale,testing$Ozone)
```
