---
title: "Training Machine Learning model using Ensemble approach"
teaching: 20
exercises: 0
questions:
- "How to overcome limitation of single ML model?"
objectives:
- "Learn to use different Ensemble ML algorithm for Machine Learning training"
keypoints:
- "Bagging, Boosting"
---
## Why Ensemble:
Ensemble is a method in Machine Learning that **combine decision from several ML models** to obtain optimum output.

![image](https://user-images.githubusercontent.com/43855029/115078334-7b5b5700-9ecd-11eb-93fb-c3f69e740a5c.png)
[Source: Patheos.com](https://www.patheos.com/blogs/driventoabstraction/2018/07/blind-men-elephant-folklore-knowledge/)

Ensemble approaches can reduce variance & Avoid Overfitting by combining results of multiple classifiers on different sub-samples

![image](https://user-images.githubusercontent.com/43855029/114235479-417ad580-994e-11eb-806b-2f73996f864d.png)

## Train model using Ensemble Approach
Ensemble methods use multiple learning algorithms to obtain better predictive performance than could be obtained from any of the constituent learning algorithms alone.
Unlike a statistical ensemble in statistical mechanics, which is usually infinite, a machine learning ensemble consists of only a concrete finite set of alternative models, but typically allows for much more flexible structure to exist among those alternatives.
Here we will be learning several ensemble models:
- Random Forest
- Bagging
- Boosting with AdaBoost
- Boosting with Gradient Boosting Machine

## Train model using Bagging (Bootstrap Aggregation)
- The bootstrap method is a resampling technique used to estimate statistics on a population by sampling a dataset with replacement.
- Bootstrap randomly create a small subsets of data from entire dataset
- The subset data has similar characteristic as the entire dataset.

![image](https://user-images.githubusercontent.com/43855029/115078743-0f2d2300-9ece-11eb-8f2b-608b3c926877.png)

### Detail explaination of Bagging
There are 3 steps in Bagging
![image](https://user-images.githubusercontent.com/43855029/114235631-74bd6480-994e-11eb-84d0-3b0378860294.png)

Step 1: Here you replace the original data with new sub-sample data using bootstrapping.

Step 2: Train each sub-sample data using ML algorithm

Step 3: Lastly, you use an average value to combine the predictions of all the classifiers, depending on the problem. Generally, these combined values are more robust than a single model.

Bagging in R can be used in many different model:

- ctreebag: used for Decision Tree
- bagFDA: used for Flexible Discriminant Analysis
- ldaBag: Bagging for Linear Discriminant Analysis
- plsBag: Bagging for Principal Linear Regression

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
