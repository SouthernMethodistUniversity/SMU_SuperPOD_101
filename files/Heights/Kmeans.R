rm(list=ls())
setwd("/home/tuev/Kaggle/Heights")
df <- read.csv("Height of Male and Female by Country 2022.csv",header = TRUE)


# Kmeans
library(ggplot2)
library(factoextra)
#library(purrr)
data(iris)
ggplot(iris,aes(x=Sepal.Length,y=Petal.Width))+
  geom_point(aes(color=Species))
set.seed(123)
km <- kmeans(iris[,3:4],3,nstart=20)

table(km$cluster,iris$Species)
fviz_cluster(km,data=iris[,3:4])



# Calculate the WSS:
fviz_nbclust(df[,3:4], kmeans, method = "wss")

km <- kmeans(df[,3:4],4,nstart=20)
fviz_cluster(km,data=df[,3:4])

ggplot(df,aes(x=Male.Height.in.Cm,y=Female.Height.in.Cm))+
  geom_point(aes(color=factor(km$cluster)))

#Plot with highlight data:

highlight_df <- select(filter(df, Country.Name %in% c("United States","Netherlands","Vietnam","Laos")),
                       c(Country.Name,Male.Height.in.Cm,Female.Height.in.Cm))


ggplot(df,aes(x=Male.Height.in.Cm,y=Female.Height.in.Cm))+
  geom_point(aes(color=factor(km$cluster)))+
  geom_point(data=highlight_df, 
             aes(x=Male.Height.in.Cm,y=Female.Height.in.Cm), 
             color='red',
             size=3)+
  annotate("text", x = highlight_df$Male.Height.in.Cm, y=highlight_df$Female.Height.in.Cm,
           label = highlight_df$Country.Name, colour = "blue")   


