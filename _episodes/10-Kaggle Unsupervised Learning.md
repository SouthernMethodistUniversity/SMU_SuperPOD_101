---
title: "Participating in Kaggle online competition"
teaching: 20
exercises: 0
questions:
- "How to participate in a Kaggle online compeition"
objectives:
- "Download Kaggle data and apply some algorithm technique that you have learnt to solve the actual data"
keypoints:
- "Kaggle"
---
# 10. Kaggle online competition

In previous chapter, you have worked with Supervised Learning data, now in this chapter, let's confront with another type of ML problem, which is Unsupervised Learning

https://www.kaggle.com/majyhain/height-of-male-and-female-by-country-2022

![image](https://user-images.githubusercontent.com/43855029/156072300-db4c4630-6653-4fea-9fed-76925011b855.png)

_**Project description:**_
The metric system is used in most nations to measure height.Despite the fact that the metric system is the most widely used measurement method, we will offer average heights in both metric and imperial units for each country.To be clear, the imperial system utilises feet and inches to measure height, whereas the metric system uses metres and centimetres.Although switching between these measurement units is not difficult, countries tend to choose one over the other in order to maintain uniformity.


For simpilicity: I downloaded the data for you and put it here:
https://github.com/vuminhtue/SMU_Data_Science_workflow_R/tree/master/data/Heights


## 9.1 Understand the data

There is only 1 csv file: Height of Male and Female by Country 2022

The dataset contains six columns:
• Rank
• Country Name
• Male height in Cm
• Female height in Cm
• Male height in Ft
• Female height in Ft


**Objective:**
- We will use Unsupervised ML to classify the groups of countries having similar heights of male and female
- Visualize the output

## 9.2 Create the Rmd format with following Data Science workflow:

### Step 1: Load library, Load data

```r

```

### Step 2: Find the optimimum number of clusters

```r

```

### Step 3: Use Kmeans clustering to classify clusters

```r

```

### Step 4: Visualize the difference

```r

```

### Step 5: Knit the documentation

```r

```

!> [Solution](https://github.com/vuminhtue/SMU_Data_Science_workflow_R/blob/master/files/Heights/Kmeans.Rmd)
