library("MASS")
library("coefplot")

#
# Feature Selection with MASS Package
#

data(airquality)
ozone <- subset(na.omit(airquality))

lm1 <- lm(Ozone ~ 1, data = ozone) # the intercept value is equal to mean(ozone$Ozone)
colnames(lm1$model)
lm_full <- lm(Ozone ~ ., data = ozone)
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
par(mfrow=c(3, 1))
barplot(lm_step_both$coefficients[2:length(lm_step_both$coefficients)])
barplot(lm_step_f$coefficients[2:length(lm_step_f$coefficients)])
barplot(lm_step_b$coefficients[2:length(lm_step_b$coefficients)])
