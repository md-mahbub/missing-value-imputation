#setwd("set the path to sourcecode directory")


library("VIM")

################## Get Training Data #########################

dataset1 <- read.table("../dataset/MissingData1.txt")
dataset1 <- as.matrix(dataset1)
dataset1[dataset1 == 1.00000000000000e+99] <- NA
dataset1vec <- as.vector(t(dataset1))


transPosedData <- t(dataset1)

#################### Training Data Ready #############
trainingData <- read.table("../dataset/MV_Train_Data3.txt")
trainingData <- as.matrix(trainingData)
 
trainingDataVec <- as.vector(trainingData)

optimalIterationNo <- 0
euclidianDistVector1 <- vector("numeric", length = 10)
listImputedData <- list()
for(K in 1:10)
{
	
	# Add NA by sampling
	percentageOfMissingVal <- 0.04 # 4% missing data in dataset1
	noOfSamples <- floor(length(trainingDataVec) * percentageOfMissingVal)
	
	s <- sample(1:length(trainingData), noOfSamples) 
	
	missingValueDataset <- trainingData
	missingValueDataset[s] <- NA
	missingValueDataset
	# Now impute the missing value consisting dataset
	
	v <- as.vector(missingValueDataset)

	m <- matrix(v, nrow = 14, ncol = 9, byrow = F)
	
	m 		
	#imputedDataset <- kNN(m , variable = colnames(m), k = 1)
	# imputedDataset <- subset(imputedDataset , select = V1:V9)
	imputedDataset  <- irmi(m, eps = 5, maxit = K*10, mixed = NULL, mixed.constant = NULL,
		count = NULL, step = FALSE, robust = FALSE, takeAll = TRUE,
		noise = TRUE, noise.factor = 1, force = FALSE, robMethod = "MM",
		force.mixed = TRUE, mi = 1, addMixedFactors = FALSE, trace = FALSE,
		init.method = "kNN", modelFormulas = NULL, multinom.method = "multinom")

	imputedDataset <- as.matrix(imputedDataset)
	listImputedData[[K]] <- imputedDataset 
	imputedDataset 

	# Now measure Euclidean distance
	
	euclideanDistance <- sqrt(sum((imputedDataset - trainingData)^2))
	
	euclidianDistVector1[K] <- euclideanDistance
	
}

optimalIterationNo <- which(euclidianDistVector1 == min(euclidianDistVector1))
print("Optimal optimalIterationNo is ::")
print(optimalIterationNo)

euclidianDistVector1

plot(imputedDataset[[optimalIterationNo]])

finalDataset1 <- irmi(transPosedData, eps = 5, maxit = optimalIterationNo * 10, mixed = NULL, mixed.constant = NULL,
		count = NULL, step = FALSE, robust = FALSE, takeAll = TRUE,
		noise = TRUE, noise.factor = 1, force = FALSE, robMethod = "MM",
		force.mixed = TRUE, mi = 1, addMixedFactors = FALSE, trace = FALSE,
		init.method = "kNN", modelFormulas = NULL, multinom.method = "multinom")
	
finalDataset1  <- t(finalDataset1)
write.table(finalDataset1, "../results/IrmiSampleMissingResult1.txt", sep="\t",row.names=FALSE, col.names = FALSE)


