---
title: "K-Nearest Neighbour"
teaching: 20
exercises: 0
questions:
- "How to use K-Nearest Neighbour in Machine Learning model"
objectives:
- "Learn how to use KNN in ML model"
keypoints:
- "KNN"
---

## K-Nearest Neighbour
- Simplicity but powerful and fast for certain task
- Work for both classification and regression
- Named as Instance Based Learning; Non-parametrics; Lazy learner
- Work well with small number of inputs

![image](https://user-images.githubusercontent.com/43855029/114582045-3d043480-9c4e-11eb-8698-e1c31840401a.png)

### Explanation

![image](https://user-images.githubusercontent.com/43855029/114582162-573e1280-9c4e-11eb-8a17-e0d91a38452e.png)

- In KNN, the most important parameter is the K group and the distance computed between points.
- Euclide distance:
![image](https://user-images.githubusercontent.com/43855029/114582319-7a68c200-9c4e-11eb-93f2-37324c034784.png)
- Manhattan distance:
![image](https://user-images.githubusercontent.com/43855029/114582389-8a80a180-9c4e-11eb-8147-c6fb4a5a8ca9.png)
- Hamming distance:
![image](https://user-images.githubusercontent.com/43855029/114582423-91a7af80-9c4e-11eb-8e84-0981899f5000.png)

Other distances: **Mahalanobis, Minkowski, Tanimoto, Jaccard, etc.**

### How to find the optimum number of K?
In general practice, the **Elbow approach** should be used to compute the RMSE/MAE with corresponding K-value.
Letting K running, we have the following graph for  the **Elbow approach**:
![image](https://user-images.githubusercontent.com/43855029/114583036-2f02e380-9c4f-11eb-81e3-6f82e4ea943c.png)

### Implementation
```r
library(caret)
data(iris)
set.seed(123)
indT <- createDataPartition(y=iris$Species,p=0.6,list=FALSE)
training <- iris[indT,]
testing  <- iris[-indT,]

ModFit_KNN <- train(Species~.,training,method="knn",preProc=c("center","scale"),tuneLength=20)

ggplot(ModFit_KNN$results,aes(k,AccuracySD))+
      geom_point(color="blue")+
      labs(title=paste("Optimum K is ",ModFit_KNN$bestTune),
           y="Error")
      
predict_KNN<- predict(ModFit_KNN,newdata=testing)
confusionMatrix(testing$Species,predict_KNN)
```
![image](https://user-images.githubusercontent.com/43855029/114583370-86a14f00-9c4f-11eb-96a0-59b3c5376952.png)

