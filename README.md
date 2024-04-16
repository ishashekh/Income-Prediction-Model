# Income Prediction Model

## Overview
This project aims to build a predictive model to determine whether an individual's income level is high or low based on various demographic and employment-related factors. The model is trained on a provided dataset containing information on individuals' demographics, employment sectors, education levels, and other relevant features.

## Dataset
The dataset consists of two main files:
- **train.csv**: Contains predictor variables along with the target variable "Inc" indicating high or low income.
- **test_final.csv**: Similar to the training data but lacks the "Inc" variable, which needs to be predicted.

### Features
- **Capital**: Capital gains of the individual.
- **Hours**: Hours worked in a typical week.
- **Age**: Age of the individual.
- **Employer**: Employment sector of the individual.
- **Education**: Education level of the individual.
- **Marital_Status**: Marital status of the individual.
- **Occupation**: Occupation type of the individual.

## Tasks
1. **Data Preprocessing**: Perform data cleaning, handle missing values, and convert categorical variables to appropriate formats.
2. **Exploratory Data Analysis (EDA)**: Visualize the data to understand the distribution of features and their relationships with the target variable.
3. **Model Building**: Employ machine learning techniques such as Decision Trees and Random Forests to build predictive models.
4. **Model Evaluation**: Assess the performance of the models using metrics like accuracy and precision.
5. **Model Selection**: Choose the most suitable model based on evaluation results and explain the rationale behind the selection.
6. **Prediction on Test Data**: Apply the selected model to predict income levels for observations in the test data.
7. **Output Generation**: Add predicted labels to the test dataset and write the dataset with predictions to a file for further analysis.

## Model Selection
The project utilizes both Decision Trees and Random Forests for predicting income levels. After evaluating the performance of both models, the Random Forest model is selected based on its higher accuracy and precision. Random Forests offer better generalization and robustness by aggregating multiple decision trees, making them suitable for this classification task.

## Conclusion
This project demonstrates the application of machine learning techniques to predict income levels based on demographic and employment-related factors. The selected model can be further optimized and deployed in real-world scenarios for income prediction and financial planning purposes.
