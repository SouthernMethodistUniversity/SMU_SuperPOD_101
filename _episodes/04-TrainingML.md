---
title: "Training Machine Learning model"
teaching: 20
exercises: 0
questions:
- "How to train a Machine Learning model"
objectives:
- "Learn to use different algorithm for Machine Learning training"
keypoints:
- "training option"
---
# Supervised Learning training
## Train model using Linear Regression
Pre-processing data and create partition
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
Fit a Linear model using `method=lm`
```r
ModFit <- train(Ozone~Temp,data=training,
                preProcess=c("center","scale"),
                method="lm")
summary(ModFit$finalModel)
```
Apply trained model to testing data set and evaluate output
```r
prediction <- predict(ModFit,testing)
cor.test(prediction,testing$Ozone)
postResample(prediction,testing$Ozone)
```
Plot result
```r
output <- cbind(testing$Ozone,prediction)
colnames(output) <- c("obs","sim")
noutput <- as.data.frame(output)
ggplot(noutput,aes(obs,sim))+
    geom_point(color='darkblue',size=4,)+
    geom_smooth(method="lm",se=TRUE)+
    ggtitle("Linear Regression between obs and sim Ozone")
```
![image](https://user-images.githubusercontent.com/43855029/114227177-a0d2e880-9942-11eb-893d-ec598992b8e4.png)

## Train model using Multi-Linear Regression
From the above model, the `postResample` only show the reasonable result:
```r
> postResample(prediction,testing$Ozone)
      RMSE   Rsquared        MAE 
27.6743204  0.4313953 18.5866936 
```
The reason is that we only build the model with 1 input `Temp`.
In this section, we will build the model with more input `Solar Radiation, Wind, Temperature`:
```r
modFit2 <- train(Ozone~Solar.R+Wind+Temp,data=training,
                 preProcess=c("center","scale"),
                 method="lm")
summary(modFit2$finalModel)

prediction2 <- predict(modFit2,testing)

cor.test(prediction2,testing$Ozone)
postResample(prediction2,testing$Ozone)
```
Output is therefore better with smaller RMSE and higher Rsquared:
```r
> postResample(prediction2,testing$Ozone)
      RMSE   Rsquared        MAE 
24.3388752  0.5512334 16.5798881 
```
## Train model using Stepwise Linear Regression
This method uses Stepwise Linear Regression with AIC as the criterion.
At the beginning, all inputs are being used and the AIC is computed.
The for each subsequent iteration, one of the input data is droped based on its performance and the corresponding AIC is being computed.
Once AIC reach minimum, the model stops.
```r
modFit_SLR <- train(Ozone~Solar.R+Wind+Temp,data=training,method="lmStepAIC")
summary(modFit_SLR$finalModel)

prediction_SLR <- predict(modFit_SLR,testing)

cor.test(prediction_SLR,testing$Ozone)
postResample(prediction_SLR,testing$Ozone)
```

```r
> postResample(prediction_SLR,testing$Ozone)
      RMSE   Rsquared        MAE 
25.0004212  0.5239849 17.0977421 
```

## Train model using Principal Component Regression
```r
modFit_PCR <- train(Ozone~Solar.R+Wind+Temp,data=training,method="pcr")
summary(modFit_PCR$finalModel)

prediction_PCR <- predict(modFit_PCR,testing)

cor.test(prediction_PCR,testing$Ozone)
postResample(prediction_PCR,testing$Ozone)
```

## Train model using Logistic Regression

```r
library(kernlab)
data(spam)
names(spam)

indTrain <- createDataPartition(y=spam$type,p=0.6,list = FALSE)
training <- spam[indTrain,]
testing  <- spam[-indTrain,]

ModFit_glm <- train(type~.,data=training,method="glm")
summary(ModFit_glm$finalModel)
```


## Tuning parameter using `trainControl`
- One of the most important part of training ML models is tuning parameters. 
- You can use the `trainControl` function to specify a number of parameters (including sampling parameters) in your model. 
- The object that is outputted from trainControl will be provided as an argument for train.
- `trainControl` is optional input. By default, it's gonna use bootstraping
- 
