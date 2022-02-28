---
title: "R Markdown"
teaching: 10
exercises: 10
questions:
- "How to visualize the analyses in R for public format"
objectives:
- "Learn how to write analyses in R using R Markdown"
keypoints:
- "Rmd"
---

# 8. R Markdown

R markdown is a simple and easy to use plain text language used to combine your R code, results from your data analysis (including plots and tables) and written commentary into a single nicely formatted and reproducible document (like a report, publication, thesis chapter or a web page like this one).

## 8.1 Create an R Markdown file:

From R-Studio: File\New File\R Markdown...:

![image](https://user-images.githubusercontent.com/43855029/156048782-99202d87-7c97-4a1b-a311-0ad176fc0137.png)

Choose Title and output format 

![image](https://user-images.githubusercontent.com/43855029/156048910-107936ff-33e6-4fbf-8277-d0b317a42f96.png)


## 8.2 Component of R Markdown:

- The title part: grouped by 3 "-"
- The R code including plot: grouped by "```{r} ... ```"
- The level of headline: similar to github, the headline can be represented by the level of # (# for 1st level heading, ## for 2nd level and so on)


## 8.3 Knit the document

Use the Knit button to knit the RMarkdown file to different format:

![image](https://user-images.githubusercontent.com/43855029/156049452-914fc381-4fa8-4893-989c-11c4fff03811.png)

## 8.4 Convert the Rmd file to md 

Sometime, if you want to save the R Markdown (Rmd) format to Github markdown (md) format.
Save the script and type the command in terminal 

```r
library(knitr)
knit("file.Rmd")
```

The md file will be created in the same working directory.
