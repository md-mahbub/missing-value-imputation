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


RANGE_OF_NEAREST_NEIGHBOR_K <- 12
NO_OF_SAMPING_ITERATIONS <- 100

dataset1 <- read.table("../dataset/MissingData1.txt")
dataset1 <- as.matrix(dataset1)
dataset1[dataset1 == 1.00000000000000e+99] <- NA
dataset1vec <- as.vector(t(dataset1))

transposed <- t(dataset1)
print("Dataset 1")
optimalNeighborNumbersEU <- 0
optimalNeighborNumbersRMSE <- 0
euclidianDistVector1 <- vector("numeric", length = RANGE_OF_NEAREST_NEIGHBOR_K)
rmseDeviationVector1 <- vector("numeric", length = RANGE_OF_NEAREST_NEIGHBOR_K)

for(K in 1:RANGE_OF_NEAREST_NEIGHBOR_K)
{
	m <- impute.knn(as.matrix(transposed) ,k = K, rng.seed=362436069)
	imputedDataset1 <- m$data
	imputedDataset1 <- as.matrix(imputedDataset1)

	
	totalEuclideanDistant <- 0 
	totalRMSEDistant <- 0 
	avgEuclideanDistant <- 0
	avgRMSEDistant <- 0
	
	percentageOfMissingVal <- 0.04 # 4% missing data in dataset1
	noOfSamples <- floor(length(dataset1vec) * percentageOfMissingVal)
	
	for (i in 1:NO_OF_SAMPING_ITERATIONS)
		{
		
			samples <- sample(1:length(imputedDataset1), noOfSamples, replace = T) # Sampling from the whole set
			
			imputedDataset1 <- as.matrix(imputedDataset1)
			sampledDataset <- imputedDataset1 
			sampledDataset[samples] <-  NA
			
			imputedSample <- impute.knn(as.matrix(sampledDataset) ,k = K, rng.seed=362436069)
			
			sampledImputedDataset <- imputedSample$data
				
			euclideanDistance <- sqrt(sum((imputedDataset1 - sampledImputedDataset )^2))
			rmseDeviation <- rmse(imputedDataset1, sampledImputedDataset)
	
			totalEuclideanDistant <- totalEuclideanDistant + euclideanDistance
			totalRMSEDistant <- totalRMSEDistant + rmseDeviation
		}
	avgEuclideanDistant <- totalEuclideanDistant / NO_OF_SAMPING_ITERATIONS
	avgRMSEDistant <- totalRMSEDistant / NO_OF_SAMPING_ITERATIONS
	euclidianDistVector1[K] <- avgEuclideanDistant
	rmseDeviationVector1[K] <- avgRMSEDistant
}

optimalNeighborNumbersEU <- which(euclidianDistVector1 == min(euclidianDistVector1))
optimalNeighborNumbersRMSE <- which(rmseDeviationVector1 == min(rmseDeviationVector1))
print("Optimal optimalIterationNo for Euclidean and RMSE respec. ::")
print(optimalNeighborNumbersEU)
print(optimalNeighborNumbersRMSE)


finalImputedResult1 <- impute.knn(t(dataset1), k = min(optimalNeighborNumbersEU, optimalNeighborNumbersRMSE), rng.seed=362436069)
finalImputedDataset1 <- t(finalImputedResult1$data)

write.table(finalImputedDataset1, "../results/KnnMissingResult1.txt", sep="\t",row.names=FALSE, col.names = FALSE)

##############################################################################
##############################################################################
##############################################################################



RANGE_OF_NEAREST_NEIGHBOR_K <- 40
NO_OF_SAMPING_ITERATIONS <- 100

dataset2 <- read.table("../dataset/MissingData2.txt")
dataset2 <- as.matrix(dataset2)
dataset2[dataset2 == 1.00000000000000e+99] <- NA
dataset1vec <- as.vector(t(dataset2))

transposed <- t(dataset2)
print("Dataset 2")
optimalNeighborNumbersEU <- 0
optimalNeighborNumbersRMSE <- 0
euclidianDistVector1 <- vector("numeric", length = RANGE_OF_NEAREST_NEIGHBOR_K)
rmseDeviationVector1 <- vector("numeric", length = RANGE_OF_NEAREST_NEIGHBOR_K)

for(K in 1:RANGE_OF_NEAREST_NEIGHBOR_K)
{
	m <- impute.knn(as.matrix(transposed) ,k = K, rng.seed=362436069)
	imputedDataset1 <- m$data
	imputedDataset1 <- as.matrix(imputedDataset1)

	
	totalEuclideanDistant <- 0 
	totalRMSEDistant <- 0 
	avgEuclideanDistant <- 0
	avgRMSEDistant <- 0
	
	percentageOfMissingVal <- 0.1 # 10% missing data in dataset2
	noOfSamples <- floor(length(dataset1vec) * percentageOfMissingVal)
	
	for (i in 1:NO_OF_SAMPING_ITERATIONS)
		{
		
			samples <- sample(1:length(imputedDataset1), noOfSamples, replace = T) # Sampling from the whole set
			
			imputedDataset1 <- as.matrix(imputedDataset1)
			sampledDataset <- imputedDataset1 
			sampledDataset[samples] <-  NA
			
			imputedSample <- impute.knn(as.matrix(sampledDataset) ,k = K, rng.seed=362436069)
			
			sampledImputedDataset <- imputedSample$data
				
			euclideanDistance <- sqrt(sum((imputedDataset1 - sampledImputedDataset )^2))
			rmseDeviation <- rmse(imputedDataset1, sampledImputedDataset)
	
			totalEuclideanDistant <- totalEuclideanDistant + euclideanDistance
			totalRMSEDistant <- totalRMSEDistant + rmseDeviation
		}
	avgEuclideanDistant <- totalEuclideanDistant / NO_OF_SAMPING_ITERATIONS
	avgRMSEDistant <- totalRMSEDistant / NO_OF_SAMPING_ITERATIONS
	euclidianDistVector1[K] <- avgEuclideanDistant
	rmseDeviationVector1[K] <- avgRMSEDistant
}

optimalNeighborNumbersEU <- which(euclidianDistVector1 == min(euclidianDistVector1))
optimalNeighborNumbersRMSE <- which(rmseDeviationVector1 == min(rmseDeviationVector1))
print("Optimal optimalIterationNo for Euclidean and RMSE respec. ::")
print(optimalNeighborNumbersEU)
print(optimalNeighborNumbersRMSE)


finalImputedResult2 <- impute.knn(t(dataset2), k = min(optimalNeighborNumbersEU, optimalNeighborNumbersRMSE), rng.seed=362436069)
finalImputedDataset2 <- t(finalImputedResult2$data)

write.table(finalImputedDataset2, "../results/KnnMissingResult2.txt", sep="\t",row.names=FALSE, col.names = FALSE)




##############################################################################
##############################################################################
##############################################################################


RANGE_OF_NEAREST_NEIGHBOR_K <- 70
NO_OF_SAMPING_ITERATIONS <- 100

dataset3 <- read.table("../dataset/FluDataMissingValue.txt")
dataset3 <- as.matrix(dataset3)
dataset3[dataset3 == 1.00000000000000e+99] <- NA
dataset1vec <- as.vector(t(dataset3))

transposed <- t(dataset3)
print("Dataset 3")
optimalNeighborNumbersEU <- 0
optimalNeighborNumbersRMSE <- 0
euclidianDistVector <- vector("numeric", length = RANGE_OF_NEAREST_NEIGHBOR_K)
rmseDeviationVector <- vector("numeric", length = RANGE_OF_NEAREST_NEIGHBOR_K)

for(K in 1:RANGE_OF_NEAREST_NEIGHBOR_K)
{
	m <- impute.knn(as.matrix(transposed) ,k = K, rng.seed=362436069)
	imputedDataset1 <- m$data
	imputedDataset1 <- as.matrix(imputedDataset1)

	
	totalEuclideanDistant <- 0 
	totalRMSEDistant <- 0 
	avgEuclideanDistant <- 0
	avgRMSEDistant <- 0
	
	percentageOfMissingVal <- 0.83 # 83% missing data in dataset3
	noOfSamples <- floor(length(dataset1vec) * percentageOfMissingVal)
	
	for (i in 1:NO_OF_SAMPING_ITERATIONS)
		{
		
			samples <- sample(1:length(imputedDataset1), noOfSamples, replace = T) # Sampling from the whole set
			
			imputedDataset1 <- as.matrix(imputedDataset1)
			sampledDataset <- imputedDataset1 
			sampledDataset[samples] <-  NA
			
			imputedSample <- impute.knn(as.matrix(sampledDataset) ,k = K, rng.seed=362436069)
			
			sampledImputedDataset <- imputedSample$data
				
			euclideanDistance <- sqrt(sum((imputedDataset1 - sampledImputedDataset )^2))
			rmseDeviation <- rmse(imputedDataset1, sampledImputedDataset)
	
			totalEuclideanDistant <- totalEuclideanDistant + euclideanDistance
			totalRMSEDistant <- totalRMSEDistant + rmseDeviation
		}
	avgEuclideanDistant <- totalEuclideanDistant / NO_OF_SAMPING_ITERATIONS
	avgRMSEDistant <- totalRMSEDistant / NO_OF_SAMPING_ITERATIONS
	euclidianDistVector[K] <- avgEuclideanDistant
	rmseDeviationVector[K] <- avgRMSEDistant
}

optimalNeighborNumbersEU <- which(euclidianDistVector == min(euclidianDistVector))
optimalNeighborNumbersRMSE <- which(rmseDeviationVector == min(rmseDeviationVector))
print("Optimal optimalIterationNo for Euclidean and RMSE respec. ::")
print(optimalNeighborNumbersEU)
print(optimalNeighborNumbersRMSE)


finalImputedResult3 <- impute.knn(t(dataset3), k = min(optimalNeighborNumbersEU, optimalNeighborNumbersRMSE), rng.seed=362436069)
finalImputedDataset3 <- t(finalImputedResult3$data)

write.table(finalImputedDataset3, "../results/KnnMissingResult3.txt", sep="\t",row.names=FALSE, col.names = FALSE)


