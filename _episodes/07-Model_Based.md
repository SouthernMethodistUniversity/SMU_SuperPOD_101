---
title: "Training Machine Learning model using Model based Prediction"
teaching: 20
exercises: 0
questions:
- "What is model based prediction algorithm in ML?"
objectives:
- "Learn to use different Model based prediction for Machine Learning training"
keypoints:
- "Naive Bayes, Linear Discriminent Analyst"
---

## Naive Bayes
- Assuming data follow a probabilistic model
- Assuming all predictors are independent (Naïve assumption)
- Use Bayes’s theorem to identify optimal classifiers
![image](https://user-images.githubusercontent.com/43855029/114339414-20b7a900-9b23-11eb-9ae1-39640f50e06c.png)
![image](https://user-images.githubusercontent.com/43855029/114339497-62485400-9b23-11eb-8511-29e1c9077946.png)

![image](https://user-images.githubusercontent.com/43855029/114339516-6f654300-9b23-11eb-838c-aaf600ca922a.png)

### Implementation Naive Bayes
```r
ModFit_NB <- train(Species~., data=training, method="nb")

predict_NB <- predict(ModFit_NB,testing)
confusionMatrix(testing$Species,predict_NB)
```

## Linear Discriminent Analysis
- LDA is a supervised learning model that is similar to logistic regression in that the outcome variable is categorical and can therefore be used for classification.
- LDA is useful with two or more class of objects

![image](https://user-images.githubusercontent.com/43855029/114339862-3bd6e880-9b24-11eb-9f4f-8f3af989c724.png)


### Implementation LDA
```r
ModFit_LDA <- train(Species~., data=training, method="lda")

predict_LDA <- predict(ModFit_LDA,testing)
confusionMatrix(testing$Species,predict_LDA)
```

- Ensemble approach (Bagging) with LDA
```r
ModFit_ldabag <- train(training[,-5],training$Species,method="bag",B=500,
                       bagControl=bagControl(fit=ldaBag$fit,
                                             predict=ldaBag$pred,
                                             aggregate = ldaBag$aggregate))

predict_bag <- predict(ModFit_ldabag,testing)
confusionMatrix(predict_bag, testing$Species)
```
