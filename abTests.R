library(ggplot2)
library(reshape2)
# 2 populations: LPA, LPB. A not affected by the experiment

set.seed(1)
n <- 500
spontaneous <- 0.1 # effectiveness of landing page alone
effectiveness <- c(0, 0.95)
names(effectiveness) <- c("LPA", "LPB")

# set the HF for the population
hfcoin <- runif(n)
hf <- ifelse(hfcoin < 0.9, "LPA", "LPB")

# assign control and treatment groups
group <- runif(n)
group <- ifelse(group < 0.5, "control", "experiment")

# assign outcomes
controlcoin <- runif(n)
experimentcoin <- runif(n)
outcome <- ( (controlcoin < spontaneous) |
               (experimentcoin < effectiveness[hf] * (group == "experiment")) )

expframe <- data.frame(group <- group, hf <- hf, improved <- outcome)

# Here are the summaries I got when I ran the code:

summary(expframe)

with(expframe[group == "control", ], table(hf, improved))

with(expframe[group == "experiment", ], table(hf, improved))

tab <- with(expframe, table(group, improved))
tab

# Frequentist test
fisher.test(tab)

# Bayesian test
betaMean <- function(alpha, beta)
  alpha / (alpha + beta)

betaMode <- function(alpha, beta)
  (alpha + 1) / (alpha + beta - 2)

alpha <- 0.1
beta <- 0.9

improved.control <- tab[1, 2]     # 20
notimproved.control <- tab[1, 1]  # 235
improved.experiment <- tab[2, 2]        # 43
notimproved.experiment <- tab[2, 1]     # 202

alpha.experiment <- alpha + improved.experiment
beta.experiment <- beta + notimproved.experiment

betaMean(alpha.experiment, beta.experiment) # 0.1752033
betaMode(alpha.experiment, beta.experiment) # 0.1807377

alpha.control <- alpha + improved.control
beta.control <- beta + notimproved.control

betaMean(alpha.control, beta.control) # 0.07851563
betaMode(alpha.control, beta.control) # 0.08307087

x <- seq(from = 0.0, to = 0.3, by = 0.005)
frame <- melt(data.frame(x = x,
  control = dbeta(x, alpha.control, beta.control),
  experiment = dbeta(x, alpha.experiment, beta.experiment)),
           measure.vars = c("control", "experiment"),
           variable.name = "treatment",
           value.name = "y")
ggplot(frame, aes(x = x, y = y, color = treatment)) + geom_line()

tabfull <- aggregate(numeric(dim(expframe)[1]) + 1,
                    by = list(expframe$group, expframe$hf, expframe$improved),
                    FUN = sum)
tabfull
