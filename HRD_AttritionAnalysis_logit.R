
## Reading the data
data <- read.csv("C:/Users/Tanveer Jamadar/Downloads/WA_Fn-UseC_-HR-Employee-Attrition.csv")

head(data)
summary(data)
colnames(data)
str(data)

#Cleaning the data

levels(data$Department)
levels(data$Over18)
levels(data$OverTime)
levels(data$MaritalStatus)
levels(data$JobRole)
levels(data$Gender)
levels(data$BusinessTravel)
levels(data$Attrition)

str(data)

data$JobInvolvement <- as.factor(data$JobInvolvement)
data$JobInvolvement

data$JobLevel <- as.factor(data$JobLevel)
data$PerformanceRating <- as.factor(data$PerformanceRating)
data$JobSatisfaction <- as.factor(data$JobSatisfaction)
data$RelationshipSatisfaction <- as.factor(data$RelationshipSatisfaction)
data$EnvironmentSatisfaction <- as.factor(data$EnvironmentSatisfaction)

str(data)
summary(data)
head(data)

#modeling and analysis

install.packages("ggplot2")
library(ggplot2)
qplot(data=data, y= data$Attrition,x=data$ï..Age)


xtabs(~data$Attrition + data$ï..Age,data=data)
xtabs(~data$Attrition + data$Education,data=data)
xtabs(~data$Attrition + data$Gender,data=data)
xtabs(~data$Attrition + data$EnvironmentSatisfaction,data=data)
xtabs(~data$Attrition + data$JobInvolvement,data=data)
xtabs(~data$Attrition + data$JobSatisfaction,data=data)
xtabs(~data$Attrition + data$MaritalStatus,data=data)
xtabs(~data$Attrition + data$PerformanceRating,data=data)
xtabs(~data$Attrition + data$RelationshipSatisfaction,data=data)

## Let's first try to find how gender impacts attrition ~~what are the odds with gender? 
logistic1 <- glm(data$Attrition ~ data$Gender ,data = data, family = "binomial")
summary(logistic1)

## looking at pvalue we can clearly see that model isn't significant

## lets try with environment sastisfaction
logistic2 <- glm(data$Attrition ~ data$EnvironmentSatisfaction ,data = data, family = "binomial")
summary(logistic2)

# we can see that environment satisfaction is a good variable contributing 
## to attrition due to pvalue being less than 0.05


## We take a summarized view of factor variables to understand their impact on attrition
logistic3 <- glm( data$Attrition ~ data$MaritalStatus + 
                    data$EnvironmentSatisfaction +
                    data$JobSatisfaction + 
                    data$JobInvolvement + 
                    data$RelationshipSatisfaction,data=data,family = "binomial")
summary(logistic3)

levels(data$EnvironmentSatisfaction)
levels(data$JobInvolvement)

## Summary
## As we can see few clear factors having impact on odds
## Marital status being single, 
## Environment satisfaction is 3 or 4 (i.e. High or very high respectively)
## Job Satisfaction is 4 (i.e. Very High)
## Job Involvement is 3 or 4 (i.e. High or Very High respectively)

## We are taking p-values less than 0.001


## Considering the above key factors, the summary for odds can be expressed as below  
## For every one unit increase in single member, the odds for attrition increase by 1.1658 
## For every one unit increase in High Environment Satisfaction, the odds for attrition decrease by -0.7664
## For every one unit increase in Very High Environment Satisfaction, the odds for attrition decrease by -0.8221
## For every one unit increase in Very High Job Satisfaction, the odds for attrition decrease by -0.9731
## For every one unit increase in High Job involvement, the odds for attrition decrease by -1.1849
## For every one unit increase in Very High Job involvement, the odds for attrition decrease by -1.7571
