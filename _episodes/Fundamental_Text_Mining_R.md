---
title: "Fundamental Text Mining with R"
author: "Tue Vu"
date: "2022-08-12"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Text Mining Introduction

We will walk through the Text Mining using an example with Shakespear sonnet:

Set working directory

```{r}
rm(list=ls())
setwd('c:/SMU/Workshop/SMU/R_Text_Mining/')
```

## Opening an example

```{r}
mytxt <- readLines('monster_mash.txt')
```
## Basic Data Transformation


```{r}
library(dplyr)
library(tidytext)

df <- tibble(line=1:length(mytxt),text=mytxt)  
```

### Tokenization 

First of all, we need to both break the text into individual tokens (a process called tokenization) and transform it to a tidy data structure (i.e. each variable must have its own column, each observation must have its own row and each value must have its own cell). To do this, we use tidytext’s unnest_tokens() function. We also remove the rarest words in that step, keeping only words in our dataset that occur more than 3 times.


```{r}
df_unigram <- df %>% unnest_tokens(unigram,text,token="ngrams",n=1)
df_bigram  <- df %>% unnest_tokens(bigram,text,token="ngrams",n=2)
df_trigram <- df %>% unnest_tokens(trigram,text,token="ngrams",n=3)
```

```{r}
df_trigram
```

### Stop words

Now that the data is in a tidy “one-word-per-row” format, we can manipulate it with packages like dplyr. Often in text analysis, we will want to remove stop words: Stop words are words that are not useful for an analysis, typically extremely common words such as “the”, “of”, “to”, and so forth. We can remove stop words in our data by using the stop words provided in the package stopwords with an anti_join() from the package dplyr.

```{r}
library(dplyr)
tidydf <- df %>% anti_join((stop_words))
```
```
