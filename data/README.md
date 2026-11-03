# data/

Put your copy of the dataset here: **`data/iris.csv`**.
Download instructions are in the main README, Module 2.

## Why is this folder empty on GitHub?

Everything in this folder **except this README** is listed in `.gitignore`, so git never tracks it.
Your `iris.csv` exists on your computer, but it is never committed or pushed.

Iris is public, but in this practice project we treat it as if it were **restricted research data**,
like patient records, cohort data or anything covered by a data-sharing agreement. The rule for real projects is the same:

- ✅ **Code** goes in the repository: scripts, documentation, `.gitignore`.
- ❌ **Data** stays out: on your computer, a secure network drive, or an approved data platform.
- 📝 **Document** where the data comes from and where it should be saved, so others can reproduce your analysis.

## About the dataset

| | |
|---|---|
| **File** | `iris.csv`: 150 rows, 5 columns |
| **Columns** | `Sepal.Length`, `Sepal.Width`, `Petal.Length`, `Petal.Width` (all in cm), `Species` |
| **Species** | `setosa`, `versicolor`, `virginica` (50 flowers each) |
| **Source** | Fisher, R.A. (1936) and Anderson, E. (1935). The same data ships with R as `datasets::iris`. |
