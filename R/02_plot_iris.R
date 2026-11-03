# =============================================================================
# 02_plot_iris.R
# Visualising the Iris dataset: a histogram, a boxplot and a scatter plot
# =============================================================================
#
# What this script does:
#   1. Loads the dataset from a CSV file in the data/ folder
#   2. Draws three plots and shows them in RStudio's Plots panel
#   3. Saves each plot as a PNG image in the output/ folder
#
# How to run it:
#   Open the project in RStudio, open this file, click "Source".
#   Use the arrows in the Plots panel to flip between the three plots.
#
# Needs the ggplot2 package. Install it once with:
#   install.packages("ggplot2")
#
# The PNG files in output/ are GENERATED: anyone can recreate them by running
# this script, so they are not stored in git (see .gitignore).
# =============================================================================

library(ggplot2)


# ---- Settings: change these to customise the plots --------------------------

data_file     <- "data/iris.csv"   # where the data lives (relative to the project)
output_folder <- "output"          # where the PNG images are saved

# Colours for each species (names or hex codes like "#1b9e77").
species_colours <- c(setosa = "#1b9e77", versicolor = "#d95f02", virginica = "#7570b3")

# Histogram
histogram_variable <- "Petal.Length"
histogram_title    <- "Distribution of petal length"
histogram_x_label  <- "Petal length (cm)"
histogram_bins     <- 20

# Boxplot
boxplot_variable <- "Sepal.Length"
boxplot_title    <- "Sepal length by species"
boxplot_y_label  <- "Sepal length (cm)"

# Scatter plot
scatter_x       <- "Sepal.Length"
scatter_y       <- "Petal.Length"
scatter_title   <- "Sepal length vs petal length"
scatter_x_label <- "Sepal length (cm)"
scatter_y_label <- "Petal length (cm)"


# ---- 1. Load the data -------------------------------------------------------

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
iris_data$Species <- factor(iris_data$Species)

# Create the output folder if it doesn't exist yet.
dir.create(output_folder, showWarnings = FALSE)


# ---- 2. Histogram: how is one measurement distributed? ----------------------

histogram_plot <- ggplot(iris_data, aes(x = .data[[histogram_variable]], fill = Species)) +
  geom_histogram(bins = histogram_bins, colour = "white", alpha = 0.8) +
  scale_fill_manual(values = species_colours) +
  labs(title = histogram_title, x = histogram_x_label, y = "Number of flowers") +
  theme_minimal()

print(histogram_plot)
ggsave(file.path(output_folder, "histogram.png"), histogram_plot, width = 7, height = 5, dpi = 150)


# ---- 3. Boxplot: compare a measurement between species ----------------------

boxplot_plot <- ggplot(iris_data, aes(x = Species, y = .data[[boxplot_variable]], fill = Species)) +
  geom_boxplot(alpha = 0.8, show.legend = FALSE) +
  scale_fill_manual(values = species_colours) +
  labs(title = boxplot_title, x = "Species", y = boxplot_y_label) +
  theme_minimal()

print(boxplot_plot)
ggsave(file.path(output_folder, "boxplot.png"), boxplot_plot, width = 7, height = 5, dpi = 150)


# ---- 4. Scatter plot: how do two measurements relate? -----------------------

scatter_plot <- ggplot(iris_data, aes(x = .data[[scatter_x]], y = .data[[scatter_y]], colour = Species)) +
  geom_point(size = 2.5, alpha = 0.8) +
  scale_colour_manual(values = species_colours) +
  labs(title = scatter_title, x = scatter_x_label, y = scatter_y_label) +
  theme_minimal()

print(scatter_plot)
ggsave(file.path(output_folder, "scatter.png"), scatter_plot, width = 7, height = 5, dpi = 150)


cat("\nDone! Three plots saved in the", output_folder, "folder:\n")
print(list.files(output_folder, pattern = "\\.png$"))
