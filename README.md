# FeatureSelectionStepwise
Feature selection with the Stepwise regression algorithm.

**Language: R**

**Start: 2022**

## Why
I wanted to try the [Stepwise regression algorithm](https://en.wikipedia.org/wiki/Stepwise_regression) for feature selection.

I used _data(airquality)_ data for the test:

![correlation matrix plot](/images/plot1.jpg)

The _R_ MASS package contains an implementation that allows defining the direction of the selection / elimination (both, forward or backward). I also implemented an alternative approach I found [online](https://towardsdatascience.com/feature-selection-correlation-and-p-value-da8921bfb3cf). Here are the coefficients of the resulting linear regression models:

![coefficients](/images/coefficients.jpg)