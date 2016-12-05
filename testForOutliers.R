# http://goo.gl/gQRwa4

# Get your IQR (Interquartile range) and lower/upper quartile using:
lowerq = quantile(data)[2]
upperq = quantile(data)[4]
iqr = upperq - lowerq #Or use IQR(data)

# Compute the bounds for a mild outlier:
mild.threshold.upper = (iqr * 1.5) + upperq
mild.threshold.lower = lowerq - (iqr * 1.5)
# Any data point outside (> mild.threshold.upper or < mild.threshold.lower)
# these values is a mild outlier

# To detect extreme outliers do the same, but multiply by 3 instead:
extreme.threshold.upper = (iqr * 3) + upperq
extreme.threshold.lower = lowerq - (iqr * 3)
# Any data point outside (> extreme.threshold.upper or < extreme.threshold.lower)
# these values is an extreme outlier
