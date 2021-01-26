#MLRM Model

#Build an analytical model to predict monthly sales of the Hyundai Elantra in the United States.

#Preparing environment for MLRM

#Step 1: Calling libraries

library(boot) 
library(car)
library(QuantPsyc)
library(lmtest)
library(sandwich)
library(vars)
library(nortest)
library(MASS)
library(caTools)
library(dplyr)
options(scipen = 999)

#Step 2: Setting Working Directory
Path<-"E:/IVY PRO SCHOOL/R/05 PREDICTIVE ANALYTICS PROJECTS/01 MULTIVARIATE LINEAR REGRESSION/CASE STUDY2/02DATA"
setwd(Path)
getwd()

Data<-read.csv("elantra.csv")
Data1<-Data #backup data

#Step 3: Basic exploration of the data
str(Data1)
summary(Data1)

#Step 4: Outlier Treatment of Dependent variable by Quantile method
quantile(Data1$ElantraSales,c(0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,0.99,0.995,1))
#Outliers are mostly not present

#Step 5: Checking missing values
as.data.frame(colSums(is.na(Data1)))
#Presence of missing values not found

#Step 6: Splitting dataset into train and test datasets
#The dataset is not split into train and test sets since number of observations are too low 
#for the model to converge. The analysis is done on the entire dataset.
set.seed(234)

#Converting relevant variables to factor variables
Data1$Month<-as.factor(Data1$Month)
Data1$Year<-as.factor(Data1$Year)

#Step 9: Fitting the model by Backward Selection

#Iteration 1:Taking all variables
linearmodel1<-lm(ElantraSales~., data = Data1)
summary(linearmodel1)

#Iteration 2:dropping queries
linearmodel2<-lm(ElantraSales~.-Queries, data = Data1)
summary(linearmodel2)

#Iteration 2:dropping year
linearmodel3<-lm(ElantraSales~Month+Unemployment+CPI_energy+CPI_all, data = Data1)
summary(linearmodel3)

#Iteration 2:fixing month classes
linearmodel4<-lm(ElantraSales~I(Month == 3)+I(Month == 4)+I(Month == 5)+I(Month == 6)+I(Month == 7)+I(Month == 8)+I(Month == 9)+I(Month == 10)+I(Month == 11)+I(Month == 12)+Unemployment+CPI_energy+CPI_all, data = Data1)
summary(linearmodel4)

#Iteration 2:dropping month = 10 
linearmodel5<-lm(ElantraSales~I(Month == 3)+I(Month == 4)+I(Month == 5)+I(Month == 6)+I(Month == 7)+I(Month == 8)+I(Month == 9)+I(Month == 11)+I(Month == 12)+Unemployment+CPI_energy+CPI_all, data = Data1)
summary(linearmodel5)

#Iteration 2:dropping month = 11 
linearmodel6<-lm(ElantraSales~I(Month == 3)+I(Month == 4)+I(Month == 5)+I(Month == 6)+I(Month == 7)+I(Month == 8)+I(Month == 9)+I(Month == 12)+Unemployment+CPI_energy+CPI_all, data = Data1)
summary(linearmodel6)

#Iteration 2:dropping cpi_all
linearmodel7<-lm(ElantraSales~I(Month == 3)+I(Month == 4)+I(Month == 5)+I(Month == 6)+I(Month == 7)+I(Month == 8)+I(Month == 9)+I(Month == 12)+Unemployment+CPI_energy, data = Data1)
summary(linearmodel7)

#Checking VIF:
as.data.frame(vif(linearmodel7))

##Getting predicted values
fitted(linearmodel7)
Data1$pred<-fitted(linearmodel7)

#MAPE
attach(Data1)
MAPE<-print((sum((abs(ElantraSales-pred))/ElantraSales))/nrow(Data1)) #MAPE=0.1188013 OR 11.88% and Accuracy=88.12%

#Step 14: Autocorrelation
#Durbin-Watson test
dwt(linearmodel7) #p-value = 0.066
#So we reject the null Hypothesis that the residuals from a linear regression model are uncorrelated.

#Step 15: Constant error variance (Heteroscedasticity)
# Breusch-Pagan test
bptest(linearmodel7) #p-value = 0.007413
#So we reject the null hypothesis that the errors are non-homogeneous.

#Model R-squared:0.8088 or 80.88% and Adjusted R-squared:  0.7597 or 75.97%

#Significant Variables at 95% confidence level:
#Months excluding 1,2,10 and 11, Unemployment and CPI_Energy