---
title: "Evaluation Metrics with caret"
teaching: 40
exercises: 0
questions:
- "How do we measure the accuracy of ML model"
objectives:
- "Learn different metrics with caret"
keypoints:
- "Caret"
---

# 4 Evaluation Metrics 
- Evaluation Metric is an essential part in any Machine Learning project.
- It measures how good or bad is your Machine Learning model
- Different Evaluation Metrics are used for Regression model (Continuous output) or Classification model (Categorical output).

## 4.1 Regression model Evaluation Metrics

### 4.1.1 Correlation Coefficient (R) or Coefficient of Determination (R2):

![image](https://user-images.githubusercontent.com/43855029/120700259-72274900-c47f-11eb-8959-a4bbe4eafccc.png)

```r
cor(prediction,testing)
cor.test(prediction,testing)
```

### 4.1.2 Root Mean Square Error (RMSE) or Mean Square Error (MSE)

![image](https://user-images.githubusercontent.com/43855029/120700533-c5010080-c47f-11eb-8050-b1cd8c63746e.png)

The postResample function gives RMSE, R2 and MAE at the same time:

```r
postResample(prediction,testing$Ozone)

```

## 4.2. Classification model Evaluation Metrics

### 4.2.1 Confusion Matrix
- A confusion matrix is a technique for summarizing the performance of a classification algorithm.
- You can learn more about Confusion Matrix [here](https://www.analyticsvidhya.com/blog/2020/04/confusion-matrix-machine-learning/)

For binary output (classification problem with only 2 output type, also most popular):
![image](https://user-images.githubusercontent.com/43855029/120687356-efe35880-c46f-11eb-950f-5feef237a4c1.png)

