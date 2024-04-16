##################################################
# Income Prediction Model
#
##################################################
### Basic Set Up                                ##
##################################################

# Clear plots
if(!is.null(dev.list())) dev.off()

# Clear console
cat("\014") 

# Clean workspace
rm(list=ls())

#Set work directory
setwd("../data")

options(scipen=9)

##################################################
### Install Libraries                           ##
##################################################

if(!require(tidyverse)){install.packages("tidyverse")}
library(tidyverse)

# For randomForest
if(!require(randomForest)){install.packages("randomForest")}
library(randomForest)

# For rpart
if(!require(rpart)){install.packages("rpart")}
library(rpart)

##################################################
### Read data and do preliminary data checks    ##
##################################################

# Read the data
train_data <- read.csv("train.csv")
test_data <- read.csv("test_final.csv")

# Display the first few rows of the dataset
head(train_data)
head(test_data)

# Check the structure of the dataset
str(train_data)
str(test_data)

# Summary statistics
summary(train_data)
summary(test_data)

# Check for missing values
sum(is.na(train_data))
sum(is.na(test_data))

##################################################
### Data Preparation                            ##
##################################################

# Convert categorical variables to factors
train_data <- train_data %>%
  mutate(across(where(is.character), as.factor))

test_data <- test_data %>%
  mutate(across(where(is.character), as.factor))

# Remove unnecessary columns
train_data <- select(train_data, -Id)
test_data <- select(test_data, -Id)

##################################################
### Data Visualization                          ##
##################################################

# Histogram for 'Inc' variable in training data
ggplot(train_data, aes(x = Inc)) +
  geom_bar(fill = "orange", alpha = 0.7) +
  ggtitle("Distribution of Inc in Training Data") +
  xlab("Inc") +
  ylab("Count")

# Boxplot for numerical variables in training data
numeric_vars <- train_data %>%
  select(where(is.numeric))

ggplot(gather(numeric_vars), aes(x = key, y = value)) +
  geom_boxplot(fill = "lightgreen", alpha = 0.7) +
  ggtitle("Boxplot of Numerical Variables in Training Data") +
  xlab("Variables") +
  ylab("Value")

##################################################
### Model Building                              ##
##################################################

# Decision Tree
tree_model <- rpart(Inc ~ ., data = train_data, method = "class")

# Random Forest
rf_model <- randomForest(Inc ~ ., data = train_data, ntree = 500, importance = TRUE)

##################################################
### Model Evaluation                            ##
##################################################

# Predict using Decision Tree
tree_pred <- predict(tree_model, newdata = train_data, type = "class")

# Predict using Random Forest
rf_pred <- predict(rf_model, newdata = train_data)

# Confusion matrices
tree_cm <- confusionMatrix(tree_pred, train_data$Inc)
rf_cm <- confusionMatrix(rf_pred, train_data$Inc)

print(tree_cm)
print(rf_cm)

# Plot confusion matrices
plot(tree_cm$table, main = "Decision Tree Confusion Matrix", 
     col = c("lightblue", "pink"))
plot(rf_cm$table, main = "Random Forest Confusion Matrix", 
     col = c("lightblue", "pink"))

# Feature importance plot for Random Forest
importance <- importance(rf_model)
varImpPlot(rf_model, main = "Random Forest Feature Importance")

##################################################
### Model Selection                              ##
##################################################

# Print accuracies
cat("Decision Tree Accuracy: ", round(tree_cm$overall['Accuracy'] * 100, 2), "%\n")
cat("Random Forest Accuracy: ", round(rf_cm$overall['Accuracy'] * 100, 2), "%\n")

# Model Selection
cat("Based on the evaluation results, the Random Forest model seems to be the best suitable.")

##################################################
### Predict on Test Data                        ##
##################################################

# Predict using Decision Tree on test data
tree_test_pred <- predict(tree_model, newdata = test_data, type = "class")

# Predict using Random Forest on test data
rf_test_pred <- predict(rf_model, newdata = test_data)

##################################################
### Add Predictions to Test Data                 ##
##################################################

# Add predictions to test data
test_data$tree_pred <- tree_test_pred
test_data$rf_pred <- rf_test_pred

##################################################
### Write Predictions to CSV File                ##
##################################################

# Write test data with predictions to CSV
write.csv(test_data, "test_data_with_pred.csv", row.names = FALSE)

cat("Predictions added to test_data_with_pred.csv file.\n")
