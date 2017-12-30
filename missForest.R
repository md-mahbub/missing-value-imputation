#setwd("set the path to sourcecode directory")

library("missForest")

############## dataset1
dataset1 <- read.table("../dataset/MissingData1.txt")
dataset1 <- as.matrix(dataset1)
dataset1[dataset1 == 1.00000000000000e+99] <- NA

t <- t(dataset1)

imp <- missForest(t)

imputedData <- t(imp$ximp)

write.table(imputedData, "../results/missForest_MissingResult1.txt", sep="\t",row.names=FALSE, col.names = FALSE)


############### dataset2
dataset2 <- read.table("../dataset/MissingData2.txt")
dataset2 <- as.matrix(dataset2)
dataset2[dataset2 == 1.00000000000000e+99] <- NA

t2 <- t(dataset2)

imp2 <- missForest(t2)

imputedData2 <- t(imp2$ximp)

write.table(imputedData2, "../results/missForest_MissingResult2.txt", sep="\t",row.names=FALSE, col.names = FALSE)


################ dataset3
dataset3 <- read.table("../dataset/FluDataMissingValue.txt")
dataset3 <- as.matrix(dataset3)
dataset3[dataset3 == 1.00000000000000e+99] <- NA

t3 <- t(dataset3)

imp3 <- missForest(t3)

imputedData3 <- t(imp3$ximp)

write.table(imputedData3, "../results/missForest_MissingResult3.txt", sep="\t",row.names=FALSE, col.names = FALSE)
