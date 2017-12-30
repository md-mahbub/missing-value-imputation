############################################

1. Missing Value Imputation

	- Environment Setup
		a. Install R. See https://cran.r-project.org/.
		b. Execute below command from R commandline to install these packages
				install.packages("VIM")
				install.packages("mice")
				install.packages("robCompositions")
				install.packages("missForest")

				source("https://bioconductor.org/biocLite.R")
				install.packages("impute")

				install.packages("devtools")
				library(devtools)
				install_github("Bioconductor-mirror/DeconRNASeq")

				
	- Set up your working directory
		The working directory should contain:
			a. Data files 
			b. Source codes 
			
				-- buildSampleDataset.R 
					[To generate sample dataset from given missing value consisting dataset. 
					This sample data set is a submatrix of give dataset that doesn't have 
					any missing value. It will work as a ground truth.]
					
				-- KnnWithSampleData.R
					[Used KNN to impute and use sample data to measure error]
				-- KnnWithoutSampling.R
					[Used KNN to impute and does NOT use sample data to measure error]
				-- IrmiWithSampleData.R
					[Iterative robust model-based imputation (IRMI) of 'VIM' package]
				-- mice.R
					[Multivariate Imputation by Chained Equations (mice) of 'mice' package]
				-- missForest.R
					[Nonparametric Missing Value Imputation using Random Forest of 'missForest' package]
			 
	- Run the source code files
		a. Set your working where the source files are
			-- Run command in R cosole: "setwd('your working directory')
		b. Run below commands : 
				source("buildSampleDataset.R")
				source("KnnWithSampleData.R")
				source("KnnWithoutSampling.R")
				source("IrmiWithSampleData.R")
				source("mice.R")
				source("missForest.R")
		
	- Expected Outputs 
		All imputed datasets will be found under "Results" directory
			-- KnnWithSampleData.R <- will create 2 files 
			-- KnnWithoutSampling.R <- will create 2 files 
			-- IrmiWithSampleData.R <- will create 3 files 
			-- missForest.R <- will create 3 files 
		 
		 
