#setwd("set the path to sourcecode directory")


library("mice")

############## dataset1
dataset1 <- read.table("../dataset/FluDataMissingValue.txt")

dataset1 <- as.matrix(dataset1)

dataset1 <- t(dataset1)

imp  <- mice(dataset1,m=50,seed=245435)

write.table(imp, "../results/miceMissingResult1.txt", sep="\t",row.names=FALSE, col.names = FALSE)


############### dataset2
dataset2 <- read.table("../dataset/MissingData1.txt")

dataset2 <- as.matrix(dataset2)

dataset2 <- t(dataset2)

imp2  <- mice(dataset2,m=50,seed=245435)

write.table(imp2, "../results/miceMissingResult2.txt", sep="\t",row.names=FALSE, col.names = FALSE)


################ dataset3
dataset3 <- read.table("../dataset/FluDataMissingValue.txt")

dataset3 <- as.matrix(dataset3)

dataset3 <- t(dataset3)

imp3  <- mice(dataset3,m=50,seed=245435)

write.table(imp3, "../results/miceMissingResult3.txt", sep="\t",row.names=FALSE, col.names = FALSE)

