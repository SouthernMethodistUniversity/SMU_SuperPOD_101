---
title: "Data Partition with caret"
teaching: 20
exercises: 0
questions:
- "What is Data Partition"
objectives:
- "Learn how to split data using caret"
keypoints:
- "Caret"
---

# Data partition: training and testing

![image](https://user-images.githubusercontent.com/43855029/122599105-cd3e6b80-d03b-11eb-9aa4-2b8f39427c20.png)


- In Machine Learning, it is mandatory to have training and testing set. Some time a verification set is also recommended.
Here are some functions for spliting training/testing set in `caret`:

- `createDataPartition`: create series of test/training partitions
- `createResample` creates one or more bootstrap samples.
- `createFolds` splits the data into k groups
- `createTimeSlices` creates cross-validation split for series data. 
- `groupKFold` splits the data based on a grouping factor.

Due to time constraint, we only focus on `createDataPartition` and `createFolds`

## Data spliting using `Data Partition`
Here we use `createDataPartition` to randomly split 60% data for training and the rest for testing:
![image](https://user-images.githubusercontent.com/43855029/114209883-22b81700-992d-11eb-83a4-c4ab1538a1e5.png)

```r
ind1 <- createDataPartition(y=iris$Species,p=0.6,list=FALSE,times=1)
#list=FALSE, prevent returning result as a list
#times=1 to create the resample size. Default value is 1.
training <- iris[ind1,]
testing  <- iris[-ind1,] 
```

## Data spliting using `K-fold`: Cross validation approach
The procedure has a single parameter called k that refers to the number of groups that a given data sample is to be split into. As such, the procedure is often called k-fold cross-validation. When a specific value for k is chosen, it may be used in place of k in the reference to the model, such as k=10 becoming 10-fold cross-validation.
![image](https://user-images.githubusercontent.com/43855029/114211785-103edd00-992f-11eb-89d0-bbd7bd0c0178.png)

```r
fitControl <- trainControl(method="cv", number=10)
# train the model
model <- train(Species~., data=training1, 
               trControl=fitControl, method="nb")
# summarize results
print(model)
predict1 <- predict(model,testing1)
```

## Other Cross-Validation approach
method: The resampling method: "boot", "cv", "LOOCV", "LGOCV", "repeatedcv", "timeslice", "none" and "oob"

More information on model tuning using caret can be found [here](https://topepo.github.io/caret/model-training-and-tuning.html)
