
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


################## Get Sample Dataset1 #########################


dataset1 <- read.table("../dataset/MissingData1.txt")
dataset1 <- as.matrix(dataset1)
dataset1[dataset1 == 1.00000000000000e+99] <- NA
dataset1vec <- as.vector(t(dataset1))


transPosedData <- t(dataset1)

isBreak <- FALSE
row <- nrow(transPosedData)
col <- ncol(transPosedData)


for(m in row :1) {
  	for(n in col :1) {		
		for(i in 1: (row  - m + 1) ) {		
  			for(j in 1: (col - n + 1)) {
				# These nested parenthesis are very inportant
				subMatrix <- transPosedData [i: (i+m-1), j: (j+n-1)] 
				numberOfNA <- as.integer(sum(is.na(subMatrix)))	
				if(numberOfNA  < 1){										
					isBreak <- TRUE
					break;
				}
  			}
			if(isBreak){
				break;
			}	
		}
		if(isBreak){
			break;
		}
	}
	if(isBreak){
		break;
	}
}

trainingData <- subMatrix

write.table(data.frame(trainingData), "../dataset/MV_Train_Data1.txt", sep="\t",row.names=FALSE, col.names = FALSE)


##############################################################################
##############################################################################
##############################################################################


################## Get Sample Dataset2 #########################


dataset2 <- read.table("../dataset/MissingData2.txt")
dataset2 <- as.matrix(dataset2)
dataset2[dataset2 == 1.00000000000000e+99] <- NA
dataset1vec <- as.vector(t(dataset2))


transPosedData <- t(dataset2)

isBreak <- FALSE
row <- nrow(transPosedData)
col <- ncol(transPosedData)


for(m in row :1) {
  	for(n in col :1) {		
		for(i in 1: (row  - m + 1) ) {		
  			for(j in 1: (col - n + 1)) {
				# These nested parenthesis are very inportant
				subMatrix <- transPosedData [i: (i+m-1), j: (j+n-1)] 
				numberOfNA <- as.integer(sum(is.na(subMatrix)))	
				if(numberOfNA  < 1){										
					isBreak <- TRUE
					break;
				}
  			}
			if(isBreak){
				break;
			}	
		}
		if(isBreak){
			break;
		}
	}
	if(isBreak){
		break;
	}
}

trainingData <- subMatrix

write.table(data.frame(trainingData), "../dataset/MV_Train_Data2.txt", sep="\t",row.names=FALSE, col.names = FALSE)


##############################################################################
##############################################################################
##############################################################################


################## Get Sample Dataset3 #########################


dataset3 <- read.table("../dataset/FluDataMissingValue.txt")
dataset3 <- as.matrix(dataset3)
dataset3[dataset3 == 1.00000000000000e+99] <- NA
dataset1vec <- as.vector(t(dataset3))


transPosedData <- t(dataset3)

isBreak <- FALSE
row <- nrow(transPosedData)
col <- ncol(transPosedData)


for(m in row :1) {
  	for(n in col :1) {		
		for(i in 1: (row  - m + 1) ) {		
  			for(j in 1: (col - n + 1)) {
				# These nested parenthesis are very inportant
				subMatrix <- transPosedData [i: (i+m-1), j: (j+n-1)] 
				numberOfNA <- as.integer(sum(is.na(subMatrix)))	
				if(numberOfNA  < 1){										
					isBreak <- TRUE
					break;
				}
  			}
			if(isBreak){
				break;
			}	
		}
		if(isBreak){
			break;
		}
	}
	if(isBreak){
		break;
	}
}

trainingData <- subMatrix

write.table(data.frame(trainingData), "../dataset/MV_Train_Data3.txt", sep="\t",row.names=FALSE, col.names = FALSE)
