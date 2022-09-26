library(MASS)
library(corrplot)

removeCorr <- function(data, corr_thr) {
  # temporary y remove 
  data_exy <- data[, names(data) != "y"]
  
  # calculate correlation
  corr_data <- cor(data_exy)
  # set the upper triangle to zero
  corr_data[!lower.tri(corr_data)] <- 0
  
  # remove correlated columns
  data_exy_new <- data_exy[, !apply(corr_data, 2, function(x) any(abs(x) > corr_thr, na.rm = TRUE))]
  
  # recombine data
  data_new <- cbind(mydata$y, data_exy_new)
  names(data_new)[1] <- "y"
  return(data_new)
}

backwardElimination <- function(data, pvalue_thr) {
  numVars = length(colnames(data)) - 1 # minus y
  for(i in 1:numVars) {
    # use all available variables
    lm_tmp <- lm(y ~ ., data = data)
    
    # extract p-values
    pvs <- summary(lm_tmp)$coefficients[, 4]
    if (max(pvs) > pvalue_thr) {
      for(j in 1:length(pvs)) {
        if (pvs[j] == max(pvs)) {
          data <- data[-c(j)]
          break
        }
      }
    }
  }
  
  lm_final <- lm(y ~ ., data = data)
  return(lm_final)
}

#
# Feature Selection with step regression
#

data(airquality)
mydata <- subset(na.omit(airquality))
names(mydata)[names(mydata) == "Ozone"] <- "y"

par(mfrow=c(1, 1))
corrplot(cor(mydata))

# -----------------------
# ------ MASS Package
# -----------------------

lm1 <- lm(y ~ 1, data = mydata) # the intercept value is equal to mean(mydata$y)
colnames(lm1$model)
lm_full <- lm(y ~ ., data = mydata)
colnames(lm_full$model)

# --- both direction
lm_step_both <- stepAIC(lm_full, direction = "both")
summary(lm_step_both)
colnames(lm_step_both$model)

# --- forward direction
lm_step_f <- stepAIC(lm1, direction = "forward", scope = list(lower = lm1, upper = lm_full))
summary(lm_step_f)
colnames(lm_step_f$model)

# --- backward direction
lm_step_b <- stepAIC(lm_full, direction = "backward")
summary(lm_step_b)
colnames(lm_step_b$model)

# show barplot coefficients (excluded intercept)
par(mfrow=c(4, 1))
barplot(lm_step_both$coefficients[2:length(lm_step_both$coefficients)], main="both direction")
barplot(lm_step_f$coefficients[2:length(lm_step_f$coefficients)], main="forward direction")
barplot(lm_step_b$coefficients[2:length(lm_step_b$coefficients)], main="backward direction")

# -----------------------
# ------ another approach (check https://towardsdatascience.com/feature-selection-correlation-and-p-value-da8921bfb3cf)
# -----------------------

# remove correlated columns (one of the two)
mydata_nc <- removeCorr(mydata, 0.9)

# backward elimination
lm_step_b2 <- backwardElimination(mydata_nc, 0.05)

summary(lm_step_b2)
colnames(lm_step_b2$model)
barplot(lm_step_b2$coefficients[2:length(lm_step_b2$coefficients)], main="alternative approach")

