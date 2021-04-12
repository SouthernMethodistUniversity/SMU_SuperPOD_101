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
It’s a step by step Regression to determine which covariates set best match with the dependent variable. Using AIC as criteria:

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
Linear Regression using the output of a Principal Component Analysis (PCA). 
PCR is skillful when data has lots of highly correlated predictors

```r
modFit_PCR <- train(Ozone~Solar.R+Wind+Temp,data=training,method="pcr")
summary(modFit_PCR$finalModel)

prediction_PCR <- predict(modFit_PCR,testing)

cor.test(prediction_PCR,testing$Ozone)
postResample(prediction_PCR,testing$Ozone)
```

## Train model using Logistic Regression
- Logistic regression is another technique borrowed by machine learning from the field of statistics. It is the go-to method for binary classification problems (problems with two class values).
- Typical binary classification: True/False, Yes/No, Pass/Fail, Spam/No Spam, Male/Female
- Unlike linear regression, the prediction for the output is transformed using a non-linear function called the logistic function.
- The standard logistic function has formulation: ![image](https://user-images.githubusercontent.com/43855029/114233181-f7dcbb80-994a-11eb-9c89-58d7802d6b49.png)

![image](https://user-images.githubusercontent.com/43855029/114233189-fb704280-994a-11eb-9019-8355f5337b37.png)


In this example, we use `spam` data set from package `kernlab`.
This is a data set collected at Hewlett-Packard Labs, that classifies **4601** e-mails as spam or non-spam. In addition to this class label there are **57** variables indicating the frequency of certain words and characters in the e-mail.
More information on this data set can be found [here](https://rdrr.io/cran/kernlab/man/spam.html)

Train the model:
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
Predict based on testing data and evaluate model output:
```r
predictions <- predict(ModFit_glm,testing)
confusionMatrix(predictions, testing$type)
```

## Train model using Decision Tree
-   Tree based learning algorithms are considered to be one of the best and mostly used supervised learning methods.
-   Tree based methods empower predictive models with high accuracy, stability and ease of interpretation
-   Non-parametric and non-linear relationships
-   Types: Categorical and Continuous
![image](https://user-images.githubusercontent.com/43855029/114233972-198a7280-994c-11eb-9f4f-da4ed958961e.png)

### Spliting algorithm
- Gini Impurity: (Categorical)
- Chi-Square index (Categorical)
- Cross-Entropy & Information gain (Categorical)
- Reduction Variance (Continuous)

### Pros & Cons
![image](https://user-images.githubusercontent.com/43855029/114234120-548ca600-994c-11eb-889e-e8ec6d313e52.png)

### Implementation
Here we will use `iris` data
```r
library(caret)
data(iris)
set.seed(123)
indT <- createDataPartition(y=iris$Species,p=0.6,list=FALSE)
training <- iris[indT,]
testing  <- iris[-indT,]
```
Next we will train using `method="rpart"` with `gini` splitting algorithm:
```r
ModFit_rpart <- train(Species~.,data=training,method="rpart",
                      parms = list(split = "gini"))
# gini can be replaced by chisquare, entropy, information

#fancier plot
library(rattle)
fancyRpartPlot(ModFit_rpart$finalModel)
```
![image](https://user-images.githubusercontent.com/43855029/114234603-ff04c900-994c-11eb-9999-0c5d5f85b76e.png)
Apply decision tree model to predic output of testing data
```r
predict_rpart <- predict(ModFit_rpart,testing)
confusionMatrix(predict_rpart, testing$Species)

testing$PredRight <- predict_rpart==testing$Species
ggplot(testing,aes(x=Petal.Width,y=Petal.Length))+
  geom_point(aes(col=PredRight))
```
![image](https://user-images.githubusercontent.com/43855029/114234661-117f0280-994d-11eb-950f-d07ed91cda09.png)

## Train model using Ensemble Approach
Ensemble methods use multiple learning algorithms to obtain better predictive performance than could be obtained from any of the constituent learning algorithms alone.
Unlike a statistical ensemble in statistical mechanics, which is usually infinite, a machine learning ensemble consists of only a concrete finite set of alternative models, but typically allows for much more flexible structure to exist among those alternatives.
Here we will be learning several ensemble models:
- Random Forest
- Bagging
- Boosting with AdaBoost
- Boosting with Gradient Boosting Machine

## Train model using Random Forest
- Random Forest is considered to be a panacea of all data science problems. On a funny note, when you can’t think of any algorithm (irrespective of situation), use random forest!
- Opposite to Decision Tree, Random Forest use bootstrapping technique to grow multiple tree
- Random Forest is a versatile machine learning method capable of performing both regression and classification tasks. 
- It is a type of ensemble learning method, where a group of weak models combine to form a powerful model.
- The end output of the model is like a black box and hence should be used judiciously.
### Detail explaination
- If there are M input variables, a number m<M is specified such that at each node, m variables are selected at random out of the M. The best split on these m is used to split the node. The value of m is held constant while we grow the forest.
- Each tree is grown to the largest extent possible and  there is no pruning.
- Predict new data by aggregating the predictions of the ntree trees (i.e., majority votes for classification, average for regression).
![image](https://user-images.githubusercontent.com/43855029/114235192-d16c4f80-994d-11eb-9732-571463c2f3f5.png)

### Pros & Cons of Random Forest
![image](https://user-images.githubusercontent.com/43855029/114235213-daf5b780-994d-11eb-83f8-ac7520749dbe.png)

### Implementation of Random Forest

```r
ModFit_rf <- train(Species~.,data=training,method="rf",prox=TRUE)

predict_rf <- predict(ModFit_rf,testing)
confusionMatrix(predict_rf, testing$Species)

testing$PredRight <- predict_rf==testing$Species
ggplot(testing,aes(x=Petal.Width,y=Petal.Length))+
  geom_point(aes(col=PredRight))
```
![image](https://user-images.githubusercontent.com/43855029/114235296-fb257680-994d-11eb-93ff-54702cbf87b8.png)

We can see that Random Forest result has better prediction than Decision Tree

## Train model using Bagging (Bootstrap Aggregation)
- Ensemble approaches can reduce variance & Avoid Overfitting by combining results of multiple classifiers on different sub-samples
![image](https://user-images.githubusercontent.com/43855029/114235479-417ad580-994e-11eb-806b-2f73996f864d.png)
- The bootstrap method is a resampling technique used to estimate statistics on a population by sampling a dataset with replacement.

### Detail explaination of Bagging
There are 3 steps in Bagging
![image](https://user-images.githubusercontent.com/43855029/114235631-74bd6480-994e-11eb-84d0-3b0378860294.png)

Step 1: Here you replace the original data with new sub-sample data using bootstrapping.
Step 2: Train each sub-sample data using ML algorithm
Step 3: Lastly, you use an average value to combine the predictions of all the classifiers, depending on the problem. Generally, these combined values are more robust than a single model.

Bagging in R can be used in many different model:

ctreebag: used for Decision Tree
bagFDA: used for Flexible Discriminant Analysis
ldaBag: Bagging for Linear Discriminant Analysis
plsBag: Bagging for Principal Linear Regression
### Implementation of Bagging
```r
library(ElemStatLearn)
dozone <- data.frame(ozone$ozone)
temperature <- ozone$temperature
treebag <- bag(dozone,temperature,B=10,
               bagControl = bagControl(fit=ctreeBag$fit,
                                       pred=ctreeBag$pred,
                                       aggregate=ctreeBag$aggregate))
predict_bag1 <- predict(treebag$fits[[1]]$fit,dozone)
predict_bag2 <- predict(treebag$fits[[2]]$fit,dozone)
predict_bag  <- predict(treebag,dozone)

p1 <- ggplot(ozone,aes(ozone,temperature))+
      geom_point(color="grey")
p1
p2 <- p1+geom_point(aes(ozone,predict_bag1),color="blue")
p2
p3 <- p2+geom_point(aes(ozone,predict_bag2),color="green")
p3
p4 <- p3+geom_point(aes(ozone,predict_bag),color="red")
p4
```
Treebag for `iris`
```r
ModFit_bag <- train(as.factor(Species) ~ .,data=training,
                   method="treebag",
                   importance=TRUE)
predict_bag <- predict(ModFit_bag,testing)
confusionMatrix(predict_bag, testing$Species)
plot(varImp(ModFit_bag))
```

## Train model using Boosting
Boosting is an approach to convert weak predictors to get stronger predictors.
### Adaptive Boosting: Adaboost
- Adaptive: weaker learners are tweaked by misclassify from previous classifier
- AdaBoost is best used to boost the performance of decision trees on binary classification problems.
- Better for classification rather than regression.
- Sensitive to noise

In the following example, we use the package `adabag`, not from `caret`

```r
library(adabag)

ModFit_adaboost <- boosting(Species~.,data=training,mfinal = 10, coeflearn = "Breiman")
importanceplot(ModFit_adaboost)
predict_Ada <- predict(ModFit_adaboost,newdata=testing)
confusionMatrix(testing$Species,as.factor(predict_Ada$class))
```
![image](https://user-images.githubusercontent.com/43855029/114237033-77b95480-9950-11eb-854d-fe4ae34dd2e1.png)

You can see the weight of different predictors from boosting model

### Gradient Boosting Machines: 
- Extremely popular ML algorithm
- Widely used in Kaggle competition
- Ensemble of shallow and weak successive tree, with each tree learning and improving on the previous

```r
ModFit_GBM <- train(Species~.,data=training,method="gbm",verbose=FALSE)
ModFit_GBM$finalModel
predict_GBM <- predict(ModFit_GBM,newdata=testing)
confusionMatrix(testing$Species,predict_GBM)
```




## Tuning parameter using `trainControl`
- One of the most important part of training ML models is tuning parameters. 
- You can use the `trainControl` function to specify a number of parameters (including sampling parameters) in your model. 
- The object that is outputted from trainControl will be provided as an argument for train.
- `trainControl` is optional input. By default, it's gonna use bootstraping
- 
