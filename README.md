# FeatureSelectionStepwise
Feature selection with Stepwise regression algorithm

**Language: R**

**Start: 2022**

## Why
I wanted to try the [Stepwise regression algorithm](https://en.wikipedia.org/wiki/Stepwise_regression) for feature selection. 

Used _data(airquality)_ data for the test:

![correlation matrix plot](/images/plot1.jpg)

The _R_ MASS package contains an implementation that allows to define the direction of the selection / elimination (both, forward or backward). I also implemented an alternative approach I found online. Here are the coefficients of the resulting linear regression models:

![coefficients](/images/coefficients.jpg)