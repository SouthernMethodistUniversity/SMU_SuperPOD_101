---
title: "Kaggle online competition: Supervised Learning"
teaching: 20
exercises: 0
questions:
- "How to participate in a Kaggle online compeition"
objectives:
- "Download Kaggle data and apply some algorithm technique that you have learnt to solve the actual data"
keypoints:
- "Kaggle"
---
# 9. Kaggle online competition: Supervised Learning
 
This is a perfect competition for data science students who have completed an online course in machine learning and are looking to expand their skill set before trying a featured competition. 

https://www.kaggle.com/c/house-prices-advanced-regression-techniques/overview
 
![image](https://user-images.githubusercontent.com/43855029/156053760-007e3d08-3472-47e5-ba96-c07d8d3fa325.png)

_**Project description:**_

Ask a home buyer to describe their dream house, and they probably won't begin with the height of the basement ceiling or the proximity to an east-west railroad. But this playground competition's dataset proves that much more influences price negotiations than the number of bedrooms or a white-picket fence.

With 79 explanatory variables describing (almost) every aspect of residential homes in Ames, Iowa, this competition challenges you to predict the final price of each home. 


For simpilicity: I downloaded the data for you and put it here:
https://github.com/vuminhtue/SMU_Data_Science_workflow_R/tree/master/data/Kaggle_house_prices


## 9.1 Understand the data

There are 4 files in this folder: 
- train.csv: the trained data with 1460 rows and 81 columns. The last column "**SalePrice**" is for output with continuous value
- test.csv: the test data with 1459 rows and 80 columns. Note: There is no  "**SalePrice**" in the last column
- data_description.txt: contains informations on all columns
- sample_submission.csv: is where you save the output from model prediction and upload it to Kaggle for competition

**Objective:**
- We will use the **train.csv**__ data to create the actual train/test set and apply several algorithm to find the optimal ML algorithm to work with this data
- Once model built and trained, apply to the **test.csv**__ and create the output as in format of sample_submission.csv
- Write all analyses in Rmd format.

## 9.2 Create the Rmd format with following Data Science workflow:

### Step 1: Load library, Load data

```r

```

### Step 2: Select variables.
- Since there are 80 input variables, we should not use all of them to avoid collinearity.
- For simplicity, select the following columns: "OverallQual","OverallCond","YearBuilt","X1stFlrSF","FullBath","GarageCars","SaleCondition","SalePrice"
- Visualize the importancy of variables

```r

```

### Step 3: Create partition for the data

```r

```

### Step 4: Apply 1 ML algorithm to the data and calculate prediction

```r

```

### Step 5: Evaluate the model output

```r

```

### Step 6: Knit the documentation

```r

```

>! [Solution](https://raw.githubusercontent.com/vuminhtue/SMU_Data_Science_workflow_R/master/files/house-prices/Kaggle_house_price.Rmd)


