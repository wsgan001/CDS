heart_data <- read.table("data/heart.dat", col.names = c("age", "sex", "cpt", "rbp", "sc", "fbs", "rest ecg", "max hr", "eia", "oldpeak", "sop", "num mv", "thal", "hdap"))

heart_data$sex <- factor(heart_data$sex)
heart_data$cpt <- factor(heart_data$cpt)
heart_data$fbs <- factor(heart_data$fbs)
heart_data$rest.ecg <- factor(heart_data$rest.ecg)
heart_data$eia <- factor(heart_data$eia)
heart_data$sop <- factor(heart_data$sop)
heart_data$thal <- factor(heart_data$thal)
heart_data$hdap <- factor(heart_data$hdap)


summary(heart_data)

library(evtree)
shw <- array(1, nrow(heart_data))
shw[heart_data$hdap == "2"] <- 5
sht <- evtree(hdap ~ . , data = heart_data, weights = shw, control = evtree.control(maxdepth = 3))
sht
table(predict(sht), heart_data$hdap)
plot(sht)

library(bnlearn)

res <- hc(heart_data, score = "aic")
plot(res)

acyclic(res)

bn.gs <- gs(heart_data)
plot(bn.gs)

bn2 <- iamb(heart_data)
plot(bn2)
bn3 <- fast.iamb(heart_data)
plot(bn3)
bn4 <- inter.iamb(heart_data)
plot(bn4)

library(graphwiz)

par(mfrow = c(1,2))
plot(bn.gs, main = "Constraint-based algorithms")
plot(res, main = "Hill-Climbing")


