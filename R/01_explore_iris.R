# =============================================================================
# 01_explore_iris.R
# Exploratory data analysis (EDA) of the Iris dataset
# =============================================================================
#
# What this script does:
#   1. Loads the dataset from a CSV file in the data/ folder
#   2. Checks its structure (rows, columns, variable types, missing values)
#   3. Calculates summary statistics, overall and by species
#   4. Compares variables (correlations and group differences)
#
# How to run it:
#   Open the project in RStudio (double-click git-practice.Rproj), open
#   this file, then click "Source" (top right of this panel) or press
#   Ctrl+Shift+S (Windows) / Cmd+Shift+S (Mac). Results print in the Console.
#
# Before you run it:
#   Download iris.csv into the data/ folder (README, Module 2).
#   The data is deliberately NOT stored in this repository. We treat it as if
#   it were restricted research data. See data/README.md.
# =============================================================================


# ---- Settings ---------------------------------------------------------------

# Where the data lives, RELATIVE to the project folder.
# If you move or rename the data file, this is the line to update.
data_file <- "data/iris.csv"


# ---- 1. Load the data -------------------------------------------------------

# Stop early with a helpful message if the file isn't where we expect it.
if (!file.exists(data_file)) {
  stop(
    "Can't find the data file: ", data_file, "\n",
    "  R is looking inside this folder: ", getwd(), "\n",
    "  Check that:\n",
    "  - you downloaded iris.csv into the data/ folder (README, Module 2)\n",
    "  - you opened the project by double-clicking git-practice.Rproj\n",
    "  - the file name matches data_file exactly (capitals and .csv included)",
    call. = FALSE
  )
}

iris_data <- read.csv(data_file)

# Species is a category (a "factor"), not free text.
iris_data$Species <- factor(iris_data$Species)

cat("\n=== 1. Data loaded from", data_file, "===\n")


# ---- 2. Examine the structure -----------------------------------------------

cat("\n=== 2. Structure ===\n")

cat("Rows (flowers):", nrow(iris_data), "  Columns (variables):", ncol(iris_data), "\n\n")

# str() shows every column, its type and its first few values.
str(iris_data)

cat("\nFirst six rows:\n")
print(head(iris_data))

# Always check for missing values before analysing data.
cat("\nMissing values in each column:\n")
print(colSums(is.na(iris_data)))

cat("\nNumber of flowers of each species:\n")
print(table(iris_data$Species))


# ---- 3. Summary statistics --------------------------------------------------

cat("\n=== 3. Summary statistics ===\n")

# The four measurement columns (all in centimetres).
measurements <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")

# Overall summary: one row per measurement.
overall_summary <- data.frame(
  mean   = sapply(iris_data[measurements], mean),
  sd     = sapply(iris_data[measurements], sd),
  median = sapply(iris_data[measurements], median),
  min    = sapply(iris_data[measurements], min),
  max    = sapply(iris_data[measurements], max)
)
cat("\nOverall (all 150 flowers):\n")
print(round(overall_summary, 2))

# Mean of each measurement, separately for each species.
species_means <- aggregate(iris_data[measurements],
                           by = list(Species = iris_data$Species),
                           FUN = mean)
cat("\nMean of each measurement by species:\n")
print(species_means, digits = 3)


# ---- 4. Compare variables ---------------------------------------------------

cat("\n=== 4. Comparing variables ===\n")

# Correlation between each pair of measurements (-1 to 1).
cat("\nCorrelation matrix:\n")
print(round(cor(iris_data[measurements]), 2))

# Does petal length differ between species? Compare means and spread.
cat("\nPetal length by species (mean and standard deviation):\n")
petal_by_species <- data.frame(
  mean = tapply(iris_data$Petal.Length, iris_data$Species, mean),
  sd   = tapply(iris_data$Petal.Length, iris_data$Species, sd)
)
print(round(petal_by_species, 2))

# A simple two-group comparison, as an illustration:
# is mean sepal length different between setosa and versicolor?
two_species <- droplevels(subset(iris_data, Species %in% c("setosa", "versicolor")))
cat("\nWelch t-test: sepal length, setosa vs versicolor\n")
print(t.test(Sepal.Length ~ Species, data = two_species))


# ---- Record the software used (helps others reproduce the analysis) ---------

cat("\n=== Done. R version used:", R.version.string, "===\n")
