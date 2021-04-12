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

=> in which: β represents the coefficient estimates for different variables or predictors(x)

The residual sum of squares **RSS** is the loss function of the fitting procedure.
And we need to determine the optimal coefficients 𝛽 to minimize the loss function

![image](https://user-images.githubusercontent.com/43855029/114417635-c39e1080-9b7f-11eb-8465-cbb9e0dff39e.png)

This procedure will adjust the 𝛽 based on the training data. 
If there is any noise in training data, the model will not perform well for testing data. Thus, Regularization comes in and regularizes/shrinkage these 𝛽 towards zero.

There are 3 main types of Regularization. 
- Ridge Regression
- LASSO
- Elastics Nets

### Implementation
