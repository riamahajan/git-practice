# =============================================================================
# Contribution by: <your name>  (GitHub: <your-github-username>)
# =============================================================================
# What this plot shows (one or two sentences):
#   <e.g. "Petal width for each species, as a violin plot.">
#
# How to run: open the project in RStudio and Source this file.
# Needs: data/iris.csv (README, Module 2) and the ggplot2 package.
# =============================================================================

library(ggplot2)

iris_data <- read.csv("data/iris.csv")

my_title <- "My contribution plot"

my_plot <- ggplot(iris_data, aes(x = Species, y = Petal.Width, fill = Species)) +
  geom_violin(alpha = 0.7, show.legend = FALSE) +
  labs(title = my_title, x = "Species", y = "Petal width (cm)") +
  theme_minimal()

print(my_plot)
