---
title: "Regularization and Variable Selection"
teaching: 20
exercises: 0
questions:
- "Why do we need Regularization and Variable Selection in ML model"
objectives:
- "Learn how to apply Regularization and Variable selection in ML model"
keypoints:
- "Regularization, Ridge Regression, LASSO, Elastic Nets"
---
![image](https://user-images.githubusercontent.com/43855029/114340188-ff57bc80-9b24-11eb-826a-69cb444687d4.png)
- One of the major aspects of training your machine learning model is to avoid overfitting (Using more parameter to best fit the training but on the other hand, failed to evaluate the testing).
- The concept of balancing bias and variance, is helpful in understanding the phenomenon of overfitting

## Regularization
- In order to reduce the Model Complexity or to avoid Multi-Collinearity, one needs to reduce the number of covariates 
(or set the coefficient to be zero).
- If the coefficients are too large, let’s penalize them to enforce them to be smaller
- Regularization is a form of multilinear regression, that constrains/regularizes or shrinks the coefficient estimates towards zero.
- In other words, this technique discourages learning a more complex or flexible model, so as to avoid the risk of overfitting
- A simple Multi-Linear Regression look like this:
![image](https://user-images.githubusercontent.com/43855029/114416230-766d6f00-9b7e-11eb-800b-2b7a65782859.png)

=> in which: **β** represents the coefficient estimates for different variables or predictors(x)

The residual sum of squares **RSS** is the loss function of the fitting procedure.
And we need to determine the optimal coefficients **𝛽** to minimize the loss function

![image](https://user-images.githubusercontent.com/43855029/114417635-c39e1080-9b7f-11eb-8465-cbb9e0dff39e.png)

This procedure will adjust the **β** based on the training data. 
If there is any noise in training data, the model will not perform well for testing data. Thus, Regularization comes in and regularizes/shrinkage these 𝛽 towards zero.

There are 3 main types of Regularization. 
- Ridge Regression
- LASSO
- Elastics Nets

### Ridge Regression
![image](https://user-images.githubusercontent.com/43855029/114420842-b171a180-9b82-11eb-92a8-16c873b564c7.png)
**𝜆**: Regularization Penalty, to be selected that the model minimized the error

The Ridge Regression loss function contains 2 elements: (1) RSS is actually the Ordinary Least Square (OLS) function for MLR and (2) The regularization term with **𝜆**:

![image](https://user-images.githubusercontent.com/43855029/114422155-04982400-9b84-11eb-9f87-65a3d7aec3f3.png)
- Selecting good **𝜆** is essential. In this case, Cross Validation method should be used
- Ridge Regression enforces **β** to be lower but not 0. By doing so, it will not get rid of irrelevant features but rather minimize their impact on the trained model.
- It is good practice to normalize predictors to the same sacle before performing Ridge Regression (Because in OLS, the coefficients are scale equivalent)

### Implementation
Setting up training/testing model:
```r
library(caret)
library(ElemStatLearn)
data(prostate)
set.seed(123)
indT <- which(prostate$train==TRUE)
training <- prostate[indT,]
testing  <- prostate[-indT,]

library(PerformanceAnalytics)
chart.Correlation(training[,-10])
```
Predict using Ridge Regression method:
```r
library(glmnet)
library(plotmo)
y <- training$lpsa
x <- training[,-c(9,10)]
x <- as.matrix(x)

cvfit_Ridge    <- cv.glmnet(x,y,alpha=0)
plot(cvfit_Ridge)

log(cvfit_Ridge$lambda.min)
log(cvfit_Ridge$lambda.1se)
coef(cvfit_Ridge,s=cvfit_Ridge$lambda.1se)
```
![image](https://user-images.githubusercontent.com/43855029/114437356-70828880-9b94-11eb-9463-ca9d33b20746.png)

- The plot shows the Mean Square Error based on training model with **𝜆** variation. 
- Top of the chart shows number of predictors used.
- There are 2 **𝜆** values: (1) **𝜆.min** which can be computed using `log(cvfit_Ridge$lambda.min)` and (2) **𝜆.1se** (1 standard error from min value) which can be computed using `log(cvfit_Ridge$lambda.1se)`
- The **β** values for each predictors can be found using `coef(cvfit_Ridge,s=cvfit_Ridge$lambda.1se)`

```r
Fit_Ridge <- glmnet(x,y,alpha=0,standardize = TRUE)
plot_glmnet(Fit_Ridge,label=TRUE,xvar="lambda",
            col=seq(1,8),grid.col = 'lightgray')

xtest <- testing[,-c(9,10)]
xtest <- as.matrix(xtest)
predict_Ridge <- predict(cvfit_Ridge,newx=xtest,s="lambda.1se")
```

![image](https://user-images.githubusercontent.com/43855029/114437734-ef77c100-9b94-11eb-94ac-df2794777c81.png)

The plot shows different coefficients for all predictors with **𝜆** variation.
Using **𝜆.1se**, we obtain reasonable result.

```r
> cor.test(predict_Ridge,testing$lpsa)

	Pearson's product-moment correlation

data:  predict_Ridge and testing$lpsa
t = 5.5527, df = 28, p-value = 6.138e-06
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.4919694 0.8599222
sample estimates:
      cor 
0.7239285 

> postResample(predict_Ridge,testing$lpsa)
     RMSE  Rsquared       MAE 
0.7365551 0.5240725 0.5499648
```


