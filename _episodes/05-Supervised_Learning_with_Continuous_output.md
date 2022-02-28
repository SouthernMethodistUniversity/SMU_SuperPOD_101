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
### 5.1.1 Train model using different models:

#### Pre-processing data and create partition

```r
library(caret)
data(airquality)

set.seed(123)
#Impute missing value using Bagging approach
PreImputeBag <- preProcess(airquality,method="bagImpute")
airquality_imp <- predict(PreImputeBag,airquality)

indT <- createDataPartition(y=airquality_imp$Ozone,p=0.6,list=FALSE)
training <- airquality_imp[indT,]
testing  <- airquality_imp[-indT,]
```

#### Select the best variables:

```r

```

#### Train model using Linear modeling: 'method=lm'

```{r}
modFit_ml <- train(Ozone~Solar.R+Wind+Temp,data=training,
                 preProcess=c("center","scale"),
                 method="lm")
```

#### Train model using Stepwise Linear Regression

```r
modFit_SLR <- train(Ozone~Solar.R+Wind+Temp,data=training,method="lmStepAIC")
```

#### Train model using Polynomial Regression

![image](https://user-images.githubusercontent.com/43855029/122609104-6c1e9400-d04b-11eb-984c-ed20f0926451.png)

In this study, let use polynomial regression with degree of freedom=3

```r
modFit_poly <- train(Ozone~poly(Solar.R,3)+poly(Wind,3)+poly(Temp,3),data=training,
                     preProcess=c("center","scale"),
                     method="lm")
```

#### Train model using Principal Component Regression

Linear Regression using the output of a Principal Component Analysis (PCA). 
PCR is skillful when data has lots of highly correlated predictors

```r
modFit_PCR <- train(Ozone~Solar.R+Wind+Temp,data=training,method="pcr")
```

#### Train model using Decision Tree

```r
ModFit_rpart <- train(Species~.,data=training,method="rpart",
                      parms = list(split = "gini"))
```

#### Train model using Random Forest

```r
ModFit_rf <- train(Species~.,data=training,method="rf",prox=TRUE)
```

Many other model ... ()
