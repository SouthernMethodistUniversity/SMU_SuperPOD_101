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
training1 <- iris[ind1,]
testing1  <- iris[-ind1,] 
```

## Data spliting using `K-fold`
The procedure has a single parameter called k that refers to the number of groups that a given data sample is to be split into. As such, the procedure is often called k-fold cross-validation. When a specific value for k is chosen, it may be used in place of k in the reference to the model, such as k=10 becoming 10-fold cross-validation.
![image](https://user-images.githubusercontent.com/43855029/114211785-103edd00-992f-11eb-89d0-bbd7bd0c0178.png)
```r
train_fold <- createFolds(y=iris$Species,k=10,list=TRUE,returnTrain=TRUE)
testi_fold  <- createFolds(y=iris$Species,k=10,list=TRUE,returnTrain=FALSE)
sapply(train_fold,length)
sapply(test_fold,length)
train_fold1 <- iris[train_fold$Fold01,]
test_fold1  <- iris[test_fold$Fold01,]
```
`returnTrain`: is logical. When true, the values returned are the sample positions corresponding to the data used during training. This argument only works in conjunction with list = TRUE

