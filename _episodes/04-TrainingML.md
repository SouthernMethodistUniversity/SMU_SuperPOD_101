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

# Simple Training using Linear Modeling algorithm
```r
modelFit <- train(y~x,data=training,method="lm")
```
Here, user can change the method to other algorithm with following abbreviation:

- Stepwise Linear Regression: `lmStepAIC`
- Decision TreeL `rpart`
- - Random Forest: `rf`
- Generalized Linear Modeling: `glm` for Logistic Regression
- Principal Component Regression: `pcr`
- Bootstrap Aggregating: `treebag`, `bag`
- Gradial Boosting Machines: `gbm`
- Naive Bayes: `nb`
- Linear Discriminant Analysis: `lda`
- K-nearest neighbour: `knn`
- Support Vector Machine: `svmLinear`

There are many other algorithms, which we suggest user to read more in [caret page](https://topepo.github.io/caret/)
