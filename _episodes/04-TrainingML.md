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
