#setwd("set the path to sourcecode directory")


library("VIM")
library("impute")


rmse <- function(x, y) {
  if (length(x) != length(y)) {
    stop(sprintf("x and y are different lengths : %d, %d",
                 length(x), length(y)))
  }

  residuals <- x-y
  res2      <- residuals^2
  res2.mean <- sum(res2) / length(x)
  rms       <- sqrt(res2.mean)

  return(rms)
  
}

################## Estimate for Dataset1 #########################

dataset1 <- read.table("../dataset/MissingData1.txt")
dataset1 <- as.matrix(dataset1)
dataset1[dataset1 == 1.00000000000000e+99] <- NA

################## Get Training Data #########################



#################### Training Data Ready #############
trainingData <- read.table("../dataset/MV_Train_Data1.txt")
trainingData <- as.matrix(trainingData)
 
trainingDataVec <- as.vector(trainingData)


euclidianDistVector <- vector("numeric", length = RANGE_OF_NEAREST_NEIGHBOR_K)
rmseDeviationVector <- vector("numeric", length = RANGE_OF_NEAREST_NEIGHBOR_K)
listImputedData <- list()

# Number of neighbors should not exceed row number, that is 14
RANGE_OF_NEAREST_NEIGHBOR_K <- 12
PERCENTAGE_OF_MISSING_VALUE <- 0.04  # 4% missing data in dataset1

sum(is.na(trainingData))

for(K in 1:RANGE_OF_NEAREST_NEIGHBOR_K)
{
	# Add NA by sampling
	noOfSamples <- floor(length(trainingDataVec) * PERCENTAGE_OF_MISSING_VALUE)

	s <- sample(1:length(trainingData), noOfSamples) 

	missingValueDataset <- trainingData
	missingValueDataset[s] <- NA
	missingValueDataset

	# Now impute the missing value consisting dataset
	m <- impute.knn(as.matrix(missingValueDataset) ,k = K, rng.seed=362436069)
	
	imputedDataset <- m$data
	imputedDataset <- as.matrix(imputedDataset)
	listImputedData[[K]] <- imputedDataset 
	 

	# Now measure Euclidean and RMSE distance

	rmseDeviation <- rmse(imputedDataset, trainingData)
	euclideanDistance <- sqrt(sum((imputedDataset - trainingData)^2))
	euclidianDistVector[K] <- euclideanDistance
	
	rmseDeviationVector[K] <- rmseDeviation
}

optimalIterationNoEu <- which(euclidianDistVector == min(euclidianDistVector))
optimalIterationNoRMSE <- which(rmseDeviationVector == min(rmseDeviationVector))
print("Optimal optimalIterationNo for Euclidean and RMSE respec. ::")
print(optimalIterationNoEu)
print(optimalIterationNoRMSE)


finalImputedResult1 <- impute.knn(t(dataset1), k = min(optimalIterationNoEu, optimalIterationNoRMSE), rng.seed=362436069)

finalImputedDataset1 <- t(finalImputedResult1$data)
write.table(data.frame(finalImputedDataset1), "../results/KnnSampledMissingResult1.txt", sep="\t",row.names=FALSE, col.names = FALSE)

##############################################################################
##############################################################################
##############################################################################

################## Estimate for Dataset2 #########################


dataset2 <- read.table("../dataset/MissingData2.txt")
dataset2 <- as.matrix(dataset2)
dataset2[dataset2 == 1.00000000000000e+99] <- NA

################## Get Training Data #########################



#################### Training Data Ready #############
trainingData <- read.table("../dataset/MV_Train_Data2.txt")
trainingData <- as.matrix(trainingData)
 
trainingDataVec <- as.vector(trainingData)


euclidianDistVector <- vector("numeric", length = RANGE_OF_NEAREST_NEIGHBOR_K)
rmseDeviationVector <- vector("numeric", length = RANGE_OF_NEAREST_NEIGHBOR_K)
listImputedData <- list()

# Number of neighbors should not exceed row number, that is 50
RANGE_OF_NEAREST_NEIGHBOR_K <- 40
PERCENTAGE_OF_MISSING_VALUE <- 0.1  # 4% missing data in dataset2

for(K in 1:RANGE_OF_NEAREST_NEIGHBOR_K)
{
	# Add NA by sampling
	noOfSamples <- floor(length(trainingDataVec) * PERCENTAGE_OF_MISSING_VALUE)

	s <- sample(1:length(trainingData), noOfSamples) 

	missingValueDataset <- trainingData
	missingValueDataset[s] <- NA
	missingValueDataset

	# Now impute the missing value consisting dataset
	m <- impute.knn(as.matrix(missingValueDataset) ,k = K, rng.seed=362436069)
	
	imputedDataset <- m$data
	imputedDataset <- as.matrix(imputedDataset)
	listImputedData[[K]] <- imputedDataset 
	 

	# Now measure Euclidean and RMSE distance

	rmseDeviation <- rmse(imputedDataset, trainingData)
	euclideanDistance <- sqrt(sum((imputedDataset - trainingData)^2))
	euclidianDistVector[K] <- euclideanDistance
	
	rmseDeviationVector[K] <- rmseDeviation
}

optimalIterationNoEu <- which(euclidianDistVector == min(euclidianDistVector))
optimalIterationNoRMSE <- which(rmseDeviationVector == min(rmseDeviationVector))
print("Optimal optimalIterationNo for Euclidean and RMSE respec. ::")
print(optimalIterationNoEu)
print(optimalIterationNoRMSE)


finalImputedResult2 <- impute.knn(t(dataset2), k = min(optimalIterationNoEu, optimalIterationNoRMSE), rng.seed=362436069)

finalImputedDataset2 <- t(finalImputedResult2$data)
write.table(data.frame(finalImputedDataset2), "../results/KnnSampledMissingResult2.txt", sep="\t",row.names=FALSE, col.names = FALSE)

##############################################################################
##############################################################################
##############################################################################

################## Estimate for Dataset3 #########################


dataset3 <- read.table("../dataset/FluDataMissingValue.txt")
dataset3 <- as.matrix(dataset3)
dataset3[dataset3 == 1.00000000000000e+99] <- NA

################## Get Training Data #########################



#################### Training Data Ready #############
trainingData <- read.table("../dataset/MV_Train_Data3.txt")
trainingData <- as.matrix(trainingData)
 
trainingDataVec <- as.vector(trainingData)


euclidianDistVector <- vector("numeric", length = RANGE_OF_NEAREST_NEIGHBOR_K)
rmseDeviationVector <- vector("numeric", length = RANGE_OF_NEAREST_NEIGHBOR_K)
listImputedData <- list()

# Number of neighbors should not exceed row number, that is 79
RANGE_OF_NEAREST_NEIGHBOR_K <- 70
PERCENTAGE_OF_MISSING_VALUE <- 0.1  # 4% missing data in dataset3

for(K in 1:RANGE_OF_NEAREST_NEIGHBOR_K)
{
	# Add NA by sampling
	noOfSamples <- floor(length(trainingDataVec) * PERCENTAGE_OF_MISSING_VALUE)

	s <- sample(1:length(trainingData), noOfSamples) 

	missingValueDataset <- trainingData
	missingValueDataset[s] <- NA
	missingValueDataset

	# Now impute the missing value consisting dataset
	m <- impute.knn(as.matrix(missingValueDataset) ,k = K, rng.seed=362436069)
	
	imputedDataset <- m$data
	imputedDataset <- as.matrix(imputedDataset)
	listImputedData[[K]] <- imputedDataset 
	 

	# Now measure Euclidean and RMSE distance

	rmseDeviation <- rmse(imputedDataset, trainingData)
	euclideanDistance <- sqrt(sum((imputedDataset - trainingData)^2))
	euclidianDistVector[K] <- euclideanDistance
	
	rmseDeviationVector[K] <- rmseDeviation
}

optimalIterationNoEu <- which(euclidianDistVector == min(euclidianDistVector))
optimalIterationNoRMSE <- which(rmseDeviationVector == min(rmseDeviationVector))
print("Optimal optimalIterationNo for Euclidean and RMSE respec. ::")
print(optimalIterationNoEu)
print(optimalIterationNoRMSE)


finalImputedResult3 <- impute.knn(t(dataset3), k = min(optimalIterationNoEu, optimalIterationNoRMSE), rng.seed=362436069)

finalImputedDataset3 <- t(finalImputedResult3$data)
write.table(data.frame(finalImputedDataset3), "../results/KnnSampledMissingResult3.txt", sep="\t",row.names=FALSE, col.names = FALSE)

