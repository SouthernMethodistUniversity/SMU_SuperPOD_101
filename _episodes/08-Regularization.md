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
- One of the major aspects of training your machine learning model is avoiding overfitting (making your model low **accuracy**).
- The concept of balancing bias and variance, is helpful in understanding the phenomenon of overfitting

## Regularization
- In order to reduce the Model Complexity or to avoid Multi-Collinearity, one needs to reduce the number of covariates 
(or set the coefficient to be zero). If the covariates are too large, let’s penalize them to enforce them to be smaller
- Regularization is a form of regression, that constrains/ regularizes or shrinks the coefficient estimates towards zero.
In other words, this technique discourages learning a more complex or flexible model, so as to avoid the risk of overfitting
- A simple Multi-Linear Regression look like this:
- ![image](https://user-images.githubusercontent.com/43855029/114341464-da187d80-9b27-11eb-84f2-2023590ce652.png)
β represents the coefficient estimates for different variables or predictors(X)

- The fitting procedure involves a loss function, known as residual sum of squares or RSS. 
The coefficients are chosen, such that they minimize this loss function.

![image](https://user-images.githubusercontent.com/43855029/114342821-92dfbc00-9b2a-11eb-8ddd-5337ef9b92a6.png)

There are 3 main types of Regularization. Please see details in [here](https://towardsdatascience.com/regularization-in-machine-learning-76441ddcf99a)
- Ridge Regression
- LASSO
- Elastics Nets

### Implementation
