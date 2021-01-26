# Elantra_Sales_Prediction_R
Prediction of monthly sales of the Hyundai Elantra in the United States

About the data:
In this problem, we will try to predict monthly sales of the Hyundai Elantra in the United States. The Hyundai Motor Company is a major automobile manufacturer based in South Korea. The Elantra is a car model that has been produced by Hyundai since 1990 and is sold all over the world, including the United States. Each observation is a month, from January 2010 to February 2014. For each month, we have the following variables:

1. Month = the month of the year for the observation (1 = January, 2 = February, 3 = March, ...). 
2. Year = the year of the observation. 
3. ElantraSales = the number of units of the Hyundai Elantra sold in the United States in the given month. 
4. Unemployment = the estimated unemployment percentage in the United States in the given month. 
5. Queries = a (normalized) approximation of the number of Google searches for "hyundai elantra" in the given month. 
6. CPI_energy = the monthly consumer price index (CPI) for energy for the given month. 
7. CPI_all = the consumer price index (CPI) for all products for the given month; this is a measure of the magnitude of the prices paid by consumer households for goods and services (e.g., food, clothing, electricity, etc.).

The dataset has 50 observations and 7 variables.

Problem Statement:
Build an analytical model to predict monthly sales of the Hyundai Elantra in the United States. 

Here the dependent variable is ElantraSales which is continuous in nature and all others are independent varaibles. So Multiple Linear Regression Model is used for prediction and analysis. 

The model is run on the entire dataset after preprocessing without splitting into train and test sets since the number of observations are very low.

After running the MLRM model, the test results are given as follows:
1. Model multiple R-squared: 0.8088 or 80.88% and Adjusted R-squared: 0.7597 or 75.97%
2. MAPE: 11.88%
3. D-W test p-value: 0.066
4. B-P test p-value: 0.007413

Significant variables at 99% confidence level:

1. Postitively Significant: Months excluding January, February, October and November and CPI_Energy
2. Negatively Significant: Unemployment

Interpretation of significant variables:
1. Months excluding January, February, October and November: The sales excluding these months are consistently good. This means the customers are not preferring to buy Elantra during year end for the winter season.
2. CPI_Energy: Higher CPI for energy is increasing Elantra sales. Maybe because Elantra is more fuel efficient than other cars in the market as customers are getting more mileage for less fuel.
3. Unemployment: Increase in unemployment is badly affecting sales of Elantra. This is natural as with unemployment, the purchasing power of customers decreases.
