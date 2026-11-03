# Git & GitHub practice: an R analysis project

A hands-on, self-paced guide to managing a real R analysis project with **Git**, **GitHub** and **GitHub Desktop**,
for members of the epidemiology lab. No command line, and nothing to memorise.

You'll work on a small exploratory data analysis (EDA) of the Iris dataset. Along the way you'll fork, clone, commit,
push, branch, open pull requests, resolve a merge conflict and recover from mistakes, on a project where breaking
things is completely safe.

> Builds on Laura Biggins' [March Example R Project](https://github.com/laurabiggins/March_example_R_project) and the
> [Babraham Bioinformatics Git/RStudio exercises](https://www.bioinformatics.babraham.ac.uk/training/RStudio_GitHub/Exercises_GitHub_RStudio.html),
> adapted for GitHub Desktop and for research data that must stay private.

---

## About the analysis

| | |
|---|---|
| **Question** | How do flower measurements differ between three iris species? |
| **Data** | `iris.csv`: 150 flowers, 4 measurements (cm) + species. **Not stored in this repository** (see [`data/README.md`](data/README.md)) |
| **`R/01_explore_iris.R`** | loads the data, checks its structure and missing values, computes summary statistics, compares variables |
| **`R/02_plot_iris.R`** | draws a histogram, a boxplot and a scatter plot, and saves them to `output/` |

### How to reproduce this analysis

1. Clone this repository and open `git-practice.Rproj` in RStudio.
2. Install the one package needed: `install.packages("ggplot2")`.
3. Download [`iris.csv`](https://github.com/riamahajan/git-practice/releases/download/data-v1/iris.csv) and save it as `data/iris.csv`.
4. Source `R/01_explore_iris.R`, then `R/02_plot_iris.R`. Plots appear in `output/`.

Every analysis repository should have a section like this. It's what lets a colleague (or you, in a year's time) rerun your work.

### What's in the repository

```
git-practice/
├── README.md                  ← you are here: the project description and the learning guide
├── git-practice.Rproj         ← double-click to open the project in RStudio
├── .gitignore                 ← files git must NOT track (data, outputs, personal settings)
├── R/
│   ├── 01_explore_iris.R      ← exploratory analysis
│   └── 02_plot_iris.R         ← plots
├── data/
│   └── README.md              ← your iris.csv goes here, but never into git
├── output/
│   └── README.md              ← generated plots go here, also never into git
└── contributions/             ← where you contribute to the shared project (Module 8)
    ├── README.md
    └── TEMPLATE.R
```

---

## The learning guide

Work through the modules in order. Each one has:

> 🎯 **Goal** · 💡 **Why it matters** · 🪜 **Steps** · ✍️ **Your turn** · ✅ **Expected result** · 🛠️ **Troubleshooting**

| Part | Module | You'll learn | Time |
|---|---|---|---|
| **A. Essentials** | [0. Before you start](#module-0--before-you-start) | install, sign in, the key ideas | 15 min |
| | [1. Fork and clone](#module-1--fork-and-clone) | fork, clone, open in RStudio | 10 min |
| | [2. Keep data out of git](#module-2--keep-data-out-of-git) | `.gitignore`, why data isn't on GitHub | 15 min |
| | [3. Run the analysis](#module-3--run-the-analysis-and-understand-file-paths) | relative paths, moved and renamed files | 20 min |
| | [4. Change code and commit](#module-4--change-the-code-review-the-diff-commit) | diffs, commit messages, small commits | 20 min |
| | [5. Push to GitHub](#module-5--push-to-github) | save vs commit vs push | 10 min |
| | [6. Explore the history](#module-6--explore-the-history) | history, comparing versions | 15 min |
| **B. Collaboration** | [7. Branches](#module-7--branches) | when and how to branch | 25 min |
| | [8. Pull requests](#module-8--contribute-with-a-pull-request) | propose, review, respond, merge | 30 min |
| | [9. Stay up to date](#module-9--stay-up-to-date-fetch-pull-and-sync) | fetch, pull, sync your fork | 15 min |
| | [10. Merge conflicts](#module-10--merge-conflicts) | why they happen, how to resolve them | 30 min |
| **C. Recovery** | [11. Undo and recover](#module-11--troubleshooting-and-recovery) | discard, undo, reset, revert | 30 min |
| **D. Beyond** | [12. Good practice](#module-12--good-practice-checklist) | habits for real research projects | 5 min |
| | [13. Optional challenges](#module-13--optional-intermediate-challenges) | functions, `here`, tags, cherry-pick… | your pace |
| | [Quick reference](#quick-reference) | every button in one table, plus a glossary | |

In this guide, **bold** means a button or menu item, and *Menu → Item* means "open the menu, then click the item".
On a Mac, GitHub Desktop's settings live under *GitHub Desktop → Settings*. On Windows they're under *File → Options*.

---

# Part A. Essentials

## Module 0 · Before you start

🎯 **Goal:** have the tools installed, and understand the four ideas everything else builds on.

### 🪜 Steps

1. **Create a GitHub account** at [github.com/signup](https://github.com/signup) if you don't have one.
2. **Install** (all free):
   - R: [cran.r-project.org](https://cran.r-project.org/)
   - RStudio Desktop: [posit.co/download/rstudio-desktop](https://posit.co/download/rstudio-desktop/)
   - GitHub Desktop: [desktop.github.com](https://desktop.github.com/)
3. **Sign in to GitHub Desktop:** *Settings (Mac) / Options (Windows) → Accounts → Sign in*. Your browser opens. Approve, and return to Desktop.
4. **Tell git who you are:** *Settings / Options → Git*. Check your **Name** and **Email**. Use the email on your GitHub account, so your commits link to your profile.
5. **Install ggplot2:** open RStudio and type this in the **Console** (bottom-left panel), then press Enter:
   ```r
   install.packages("ggplot2")
   ```

### 💡 The four key ideas

| Idea | What it is | Analogy |
|---|---|---|
| **Git** | software that records versions of your files | a lab notebook that writes itself |
| **Repository (repo)** | a project folder plus its full history | the notebook |
| **GitHub** | a website that stores repositories online | the shared lab shelf |
| **GitHub Desktop** | an app that gives git friendly buttons | the pen |

And the most important distinction in this whole guide:

| Action | Where | What it does | Who can see it |
|---|---|---|---|
| **Save** (Ctrl/Cmd + S in RStudio) | your computer | writes the file to disk | only you |
| **Commit** (GitHub Desktop) | your computer | records a named *version* in the history | only you |
| **Push** (GitHub Desktop) | GitHub | uploads your commits | everyone with access to the repo |

```
   save          commit                push
 RStudio ──►  your files  ──►  your history  ──►  GitHub
              (disk)           (on your computer)  (online)
```

### ✅ Expected result
GitHub Desktop shows your GitHub account under *Accounts*. In RStudio, `library(ggplot2)` runs without an error.

### 🛠️ Troubleshooting
- **`install.packages` asks to use a "personal library"**: answer **Yes**.
- **`library(ggplot2)` says "there is no package called ggplot2"**: the install didn't finish. Run `install.packages("ggplot2")` again and read any error message.
- **Desktop sign-in loops in the browser**: sign in to github.com in your browser first, then try again.

---

## Module 1 · Fork and clone

🎯 **Goal:** your own copy of this project on GitHub (a **fork**) and on your computer (a **clone**).

💡 **Why:** you can't change the lab's central repository directly, and you shouldn't need to. A fork is your own
copy to experiment in. Later you'll *propose* changes back to the central repository with a pull request.

```
  CENTRAL repo  ──fork──►  YOUR fork    ──clone──►  YOUR computer
  (riamahajan)             (on GitHub)              (GitHub Desktop + RStudio)
  "upstream"               "origin"
```

### 🪜 Steps

1. Go to the central repository: **https://github.com/riamahajan/git-practice**
2. Click **Fork** (top right), then **Create fork**. After a moment you're on `github.com/<your-username>/git-practice`. The small grey text under the name says *"forked from riamahajan/git-practice"*.
3. In GitHub Desktop: *File → Clone Repository… →* **GitHub.com** tab.
4. Select **`<your-username>/git-practice`**. Make sure it's yours, not `riamahajan`'s.
5. Under **Local Path**, choose where the folder goes (e.g. `Documents/GitHub/git-practice`). Avoid OneDrive, Dropbox or other synced folders. Then click **Clone**.
6. Desktop asks **"How are you planning to use this fork?"** Choose **To contribute to the parent project**, then **Continue**.
7. Open the project in RStudio: *Repository → Show in Finder* (Mac) / *Show in Explorer* (Windows), then **double-click `git-practice.Rproj`**.

### ✍️ Your turn
In RStudio's **Files** panel (bottom right), click through the folders. Open `.gitignore` and `data/README.md` and read them.

### ✅ Expected result
- GitHub Desktop: *Current Repository* says **git-practice** and *Current Branch* says **main**.
- RStudio: the top-right corner says **git-practice** (the project is open), and the Files panel shows `R/`, `data/`, `output/` and the other files.

### 🛠️ Troubleshooting
- **I cloned `riamahajan`'s repo instead of my fork**: in Desktop, *Repository → Remove…*, then delete the folder. Fork first (steps 1–2), then clone again.
- **I picked "For my own purposes"**: change it under *Repository → Repository Settings → Fork Behavior*.
- **The `.Rproj` file opens as text**: open RStudio first, then *File → Open Project…* and pick the `.Rproj` file.
- **I can't see `.gitignore` in Finder/Explorer**: names starting with a dot are hidden. RStudio's Files panel shows it (if not: *More → Show Hidden Files*).

---

## Module 2 · Keep data out of git

🎯 **Goal:** download the dataset into the project, and see for yourself that git ignores it.

💡 **Why:** in research we version **code**, not **data**. Patient records, cohort data, linked datasets and anything
under a data-sharing agreement must **never** be uploaded to GitHub, even to a private repository. Once data
is pushed, it is very hard to fully remove. The `.gitignore` file is the guard rail: it tells git which files to
pretend not to see. Here we treat the public Iris data *as if* it were restricted.

### 🪜 Steps

1. Download the dataset: **[iris.csv](https://github.com/riamahajan/git-practice/releases/download/data-v1/iris.csv)**
   (it lives on the central repository's [Releases page](https://github.com/riamahajan/git-practice/releases), outside the code).
2. Move it into your project's **`data`** folder, so its path is `git-practice/data/iris.csv`.
3. In RStudio's Files panel, open the `data` folder. You should see `iris.csv` and `README.md`.
4. Now look at GitHub Desktop's **Changes** tab. It says **No local changes**, even though you just added a file!
5. Open `.gitignore` in RStudio and find these lines:
   ```
   data/*
   !data/README.md
   ```
   The first means "ignore everything in `data/`". The second (`!`) means "except the README".
6. On github.com, open **your fork** and click into the `data` folder. Only `README.md` is there.
   Your data exists on your computer **only**.

### ✍️ Your turn
1. In RStudio: *File → New File → Text File*. Type anything and save it as **`data/notes.txt`**. Does it appear in Desktop's Changes tab?
2. Save the same file again, this time as **`my_notes.txt`** in the main project folder. Does it appear now?
3. Delete `my_notes.txt` in RStudio's Files panel (tick it → **Delete**) and watch it vanish from the Changes tab.

### ✅ Expected result
- `data/iris.csv` and `data/notes.txt` **never** appear in the Changes tab (they're ignored).
- `my_notes.txt` **does** appear (nothing ignores it), until you delete it.

> 📌 **Key point:** `.gitignore` only stops **untracked** files from being added. If a file was committed *before*
> it was added to `.gitignore`, git keeps tracking it. That's why the data rules go in on day one.
> (See [Challenge 4](#module-13--optional-intermediate-challenges) to fix that situation.)

### 🛠️ Troubleshooting
- **The file downloaded as `iris.csv.txt` or `iris (1).csv`**: rename it to exactly `iris.csv`. On Windows, turn on *File Explorer → View → File name extensions* to see the real name.
- **`iris.csv` shows up in the Changes tab**: it's in the wrong folder (e.g. the project's main folder instead of `data/`), or `.gitignore` was edited. Move the file into `data/`. **Don't commit it.**
- **The download link doesn't work**: create an identical file from R's built-in copy. In the RStudio Console, run:
  ```r
  write.csv(iris, "data/iris.csv", row.names = FALSE)
  ```

---

## Module 3 · Run the analysis and understand file paths

🎯 **Goal:** run both scripts, then break and fix a file path on purpose.

💡 **Why:** scripts find data through **file paths**. A path that only works on your computer
(`C:/Users/ria/Downloads/iris.csv`) breaks for everyone else. A **relative path** (`data/iris.csv`) is measured from
the project folder. It works on any computer where the project is laid out the same way. Opening the `.Rproj` file
sets that starting folder for you.

### 🪜 Steps

1. In RStudio, open `R/01_explore_iris.R` and click **Source** (top right of the script panel).
   The Console prints the structure, summary statistics, correlations and a t-test.
2. Open `R/02_plot_iris.R` and click **Source**. Three plots appear in the **Plots** panel (use its arrows to flip between them),
   and three PNG files appear in the `output/` folder.
3. Look at Desktop's Changes tab. Still **No local changes**: the images in `output/` are ignored too, because anyone
   can recreate them by running the script.
4. In the Console, type `getwd()` and press Enter. It prints your project folder. That's where `data/iris.csv` is measured from.

### ✍️ Your turn: move and rename the data
1. **Rename the data:** in the Files panel, tick `data/iris.csv` → **Rename** → `iris_measurements.csv`.
2. Source `R/02_plot_iris.R` again. Read the error: it tells you exactly what it looked for, and where.
3. Look at Desktop: **still no changes**. Git doesn't know (or care) that you renamed an ignored file.
4. **Fix the scripts:** in *both* scripts, change the line near the top to
   `data_file <- "data/iris_measurements.csv"`. Save both, and Source both again. They work.
5. Look at Desktop: **now** there are two changed files, the two scripts. Click each to see the one-line change.
   This is what a colleague would receive if you committed it, and they'd also need to rename *their* data file.
6. **Put it back** (we'll keep the standard name for the rest of the guide):
   - rename the file back to `iris.csv`;
   - in Desktop, right-click each script → **Discard Changes…** → confirm. Both scripts go back to `data/iris.csv`.
7. *(Bonus)* Make a folder `data/raw/`, move `iris.csv` into it, and update the path to `data/raw/iris.csv`. Then put it back the same way.

### ✅ Expected result
Both scripts run without errors and the Changes tab is empty again. You've seen that renaming data needs a matching
code change, and that the code change is what git tracks.

### 🛠️ Troubleshooting
- **"Can't find the data file … R is looking inside this folder: …"**: if that folder isn't `git-practice`, you didn't open the project. Double-click `git-practice.Rproj`. Otherwise check the file name and location.
- **"could not find function ggplot"** or **"there is no package called 'ggplot2'"**: `install.packages("ggplot2")`.
- **The Plots panel is empty**: it's probably too small. Drag it larger, or click **Zoom**.

---

## Module 4 · Change the code, review the diff, commit

🎯 **Goal:** make small, meaningful changes and record each one as a commit with a clear message.

💡 **Why:** a commit is a labelled snapshot you can always go back to. Small commits with clear messages turn your
history into a readable lab notebook ("Use colour-blind-friendly palette"). A single giant "updates" commit
tells you nothing.

> **Is it OK to commit straight to `main` here?** Yes. This is *your own fork* and you're the only person working in it.
> Module 7 covers when you should use a branch instead.

### 🪜 Steps

1. Open `R/02_plot_iris.R`. Near the top is a **Settings** section, one setting per line.
2. Change the colours, for example to:
   ```r
   species_colours <- c(setosa = "#E69F00", versicolor = "#56B4E9", virginica = "#009E73")
   ```
   Save (Ctrl/Cmd + S) and Source the script to see the result.
3. In GitHub Desktop's Changes tab, click `R/02_plot_iris.R`. The **diff** shows the old line in **red (−)** and the new one in **green (+)**.
4. At the bottom left, write a **Summary**, e.g. `Use colour-blind-friendly species colours`.
   Optionally add a **Description**: *why* you made the change.
5. Click **Commit to main**. The Changes tab empties and your commit appears in the **History** tab.

### ✍️ Your turn: three more commits, one change each
Make each change, save, Source to check it works, then commit it **on its own** with a clear message:

| Change | Example commit message |
|---|---|
| Change `histogram_variable` to `"Sepal.Width"`, and update `histogram_title` and `histogram_x_label` to match | `Plot sepal width in the histogram` |
| Change `boxplot_title` and `boxplot_y_label` to something more descriptive | `Clarify boxplot title and axis label` |
| In the boxplot section, change `geom_boxplot(` to `geom_violin(` | `Show sepal length as a violin plot` |

**Good vs. not-so-good messages:**

| ✅ Clear | ❌ Unclear |
|---|---|
| `Fix y-axis label units on boxplot` | `fix` |
| `Add petal width histogram` | `changes` |
| `Exclude flowers with missing sepal width` | `updated script again` |

Tips: start with a verb (Add, Fix, Change, Remove), keep it under about 50 characters, and put the *why* in the Description.

> 💡 **Two changes, one file, two commits?** Click a changed line's number in the diff to include or exclude just that line.
> Only the highlighted lines go into the commit.

### ✅ Expected result
The History tab shows your four commits at the top, newest first. The top bar says **Push origin** with a ↑ number:
those commits are on your computer only, so far.

### 🛠️ Troubleshooting
- **The Commit button is greyed out**: type a Summary, and make sure at least one file is ticked.
- **The change doesn't appear in Desktop**: did you save the file in RStudio? (Unsaved file names show in red, with a `*`.)
- **I committed the wrong thing**: if you haven't pushed, click **Undo** just below the commit button (see Module 11).

---

## Module 5 · Push to GitHub

🎯 **Goal:** upload your commits to your fork on GitHub, and feel the difference between save, commit and push.

💡 **Why:** until you push, your commits exist only on your laptop. Pushing backs them up and makes them visible to collaborators.

### 🪜 Steps

1. In GitHub Desktop, click **Push origin** (top bar).
2. In your browser, go to `https://github.com/<your-username>/git-practice` and open `R/02_plot_iris.R`. Your changes are there.
3. Click the **commits** link (the clock icon with a number, near the top of the file list). There are your commit messages.

### ✍️ Your turn: save vs commit vs push
1. Change `scatter_title` to anything you like and **save only**. Refresh the file on GitHub: unchanged.
2. **Commit** it (`Rename scatter plot title`). Refresh GitHub: still unchanged.
3. **Push origin**. Refresh GitHub: there it is.

| After you… | On your computer | In your history | On GitHub |
|---|---|---|---|
| save | ✅ | ❌ | ❌ |
| commit | ✅ | ✅ | ❌ |
| push | ✅ | ✅ | ✅ |

### ✅ Expected result
The top bar of Desktop says **Fetch origin** again (nothing left to push), and GitHub shows all your commits.
Your `data/` folder on GitHub still contains only `README.md`.

### 🛠️ Troubleshooting
- **"Authentication failed"**: sign in again under *Settings/Options → Accounts*.
- **"Push rejected" / Desktop says to fetch or pull first**: GitHub has commits you don't (for example, you edited a file on the website). Click **Pull origin**, then **Push origin**. See Module 9.
- **Changes are on GitHub, but in `riamahajan`'s repo?** That can't happen. You can't push to a repository you don't own. Make sure you're looking at *your* fork's page.

---

## Module 6 · Explore the history

🎯 **Goal:** find out what changed, when and why, and look at old versions without changing anything.

💡 **Why:** "Which version of the script made Figure 2?", "When did this number change?" The history answers
those questions, but only if you commit regularly with clear messages.

### 🪜 Steps

1. In Desktop, open the **History** tab. Click any commit to see its message, author, date, and the files and lines it changed.
2. Right-click a commit → **Copy SHA**. The SHA is the commit's unique ID (like `a1b2c3d`).
3. On github.com (your fork) → **commits** link → click a commit → **Browse files** (top right). This shows the
   *entire project* exactly as it was at that moment. Nothing changes; you're just looking.
4. **History of one file:** on github.com, open `R/02_plot_iris.R` → **History** button (top right). It lists only the commits that touched that file.
5. **Compare two versions:** on github.com, type
   `https://github.com/<your-username>/git-practice/compare/<older-SHA>...<newer-SHA>`
   with two SHAs from your history. It shows everything that changed between them.

### ✍️ Your turn
1. Find the commit where you changed the colours. What were the colours *before*?
2. Use **Browse files** to open `R/02_plot_iris.R` as it was in the very first commit ("Set up the practice project").
3. Compare your first and latest commits. How many lines changed in total?

### ✅ Expected result
You can answer "what changed, when, and why" for your own work, without changing any files.

### 🛠️ Troubleshooting
- **The compare page says "There isn't anything to compare"**: you may have swapped the SHAs. Put the older one first.
- **I can't see my newest commits on github.com**: you haven't pushed them (Module 5).

---

# Part B. Collaboration

## Module 7 · Branches

🎯 **Goal:** know when to branch, and practise creating, switching, committing on and publishing a branch.

💡 **Why:** a **branch** is a separate line of work. `main` stays clean and working while you experiment elsewhere.
If the experiment works, you merge it in. If not, you delete the branch and nothing is harmed.

```
main:              A───B───C──────────────F   ← merge
                            \            /
try-density-plot:            D────E─────
```

### When is committing straight to `main` fine, and when should you branch?

| Situation | Commit to `main`? | Branch? |
|---|---|---|
| Your own practice repo, or a solo project nobody else uses, small safe change | ✅ fine | optional |
| Trying an analysis you might throw away | | ✅ e.g. `try-mixed-model` |
| A new feature that takes several commits (a new figure, a new script) | | ✅ e.g. `add-density-plot` |
| Fixing a bug in code that others rely on | | ✅ e.g. `fix-missing-age-filter` |
| **Any** change to a shared lab repository | ❌ never | ✅ always, then a pull request |

Good branch names are short, lowercase, use hyphens, and say what the work is: `add-density-plot`, `fix-axis-labels`.
Not `test`, `branch2` or `ria`.

### 🪜 Steps

1. Commit any open changes first. Desktop's Changes tab should be empty.
2. *Current Branch* (top bar) → **New Branch**. Name it `add-density-plot`. If asked what to base it on, choose **main**. Click **Create Branch**.
3. The top bar now says *Current Branch: add-density-plot*.
4. In `R/02_plot_iris.R`, copy the whole histogram section and paste it below the scatter-plot section. In the copy, change:
   - `histogram_plot` to `density_plot` (everywhere in your copy),
   - `geom_histogram(bins = histogram_bins, colour = "white", alpha = 0.8)` to `geom_density(alpha = 0.5)`,
   - `"histogram.png"` to `"density.png"`.

   Save, Source, and check the new plot. **Commit**: `Add density plot`.
5. Make a **second commit** on the branch, e.g. a nicer y-axis label for the density plot (`y = "Density"`): `Label density plot y-axis`.
6. **Switch branches and watch the code change:** *Current Branch →* **main**. Look at `02_plot_iris.R` in RStudio:
   the density section has gone! Switch back to **add-density-plot** and it's back.
   (If RStudio asks whether to reload the file, say **Yes**.)
7. **Publish the branch:** while on `add-density-plot`, click **Publish branch** (top bar).
   On your fork on github.com, the branch menu (it says `main`) now lists `add-density-plot`.

### ✍️ Your turn: finish the experiment
The density plot works, so bring it into your `main`:
1. *Current Branch →* **main**.
2. *Branch → Merge into Current Branch…* → choose **add-density-plot** → **Create a merge commit**.
3. **Push origin**.
4. Delete the finished branch: *Current Branch →* select `add-density-plot` → *Branch → Delete…* → also tick **delete from the remote**.

### ✅ Expected result
`main` now has the density plot. The History tab shows your two branch commits and a merge commit. The branch is gone from Desktop and GitHub.

### 🛠️ Troubleshooting
- **"You have changes on this branch. What would you like to do with them?"** when switching: easiest is **Cancel**, commit first, then switch. (*Leave my changes on …* stashes them on the current branch. *Bring my changes to …* carries them over.)
- **My file "disappeared" after switching**: it's committed on the other branch. Switch back and it's there.
- **RStudio still shows the old code after switching**: close and reopen the file, or say **Yes** when it offers to reload.

---

## Module 8 · Contribute with a pull request

🎯 **Goal:** propose a change to the **central** lab repository, respond to review, and see it merged.

💡 **Why:** a **pull request (PR)** says *"here are my changes on this branch; please review them and merge them
into the main project."* It's how shared lab code stays correct: nothing reaches `main` without someone else looking at it first.

Each participant adds **one new file**, `contributions/<your-github-username>.R`, so contributions don't clash.

### 🪜 Steps: propose

1. Make sure your Changes tab is empty and you're on **main**.
2. *Current Branch →* **New Branch** → name it `add-<your-username>-plot`.
   If Desktop asks what to base it on, choose **upstream/main** (the central repository's version). Click **Create Branch**.
3. In RStudio's Files panel, open `contributions/`, tick `TEMPLATE.R` → *More →* **Copy…** → name the copy `<your-github-username>.R`.
4. Edit your new file: put your name in the header, write one sentence about what your plot shows, and change the plot
   (a different variable, plot type or title). Save and **Source** it to make sure it runs.
5. **Commit**: `Add <your name>'s contribution plot`.
6. **Publish branch**.
7. Click **Preview Pull Request** (or *Branch → Create Pull Request*, which opens your browser).
8. **Check before you create it.** At the top of the GitHub page:
   - **base repository:** `riamahajan/git-practice` · **base:** `main`
   - **head repository:** `<your-username>/git-practice` · **compare:** `add-<your-username>-plot`
   - **Files changed** shows **only** `contributions/<your-username>.R`.

   If other files appear, see Troubleshooting before continuing.
9. Write a **title** and **description**, then click **Create pull request**:
   ```
   Title:       Add violin plot of petal width by species

   Description: What:  adds contributions/jdoe.R, a violin plot of petal width.
                Why:   shows the spread within each species better than a boxplot.
                Check: Source the file; it needs data/iris.csv and ggplot2.
   ```

### 🪜 Steps: respond to review

10. A reviewer (the facilitator or a colleague) will comment on your PR, perhaps *"Please add axis units to the y label."*
    You'll get an email, and the PR's **Conversation** tab shows the comment.
11. Don't open a new PR. **Fix it on the same branch:** in Desktop, make sure *Current Branch* is `add-<your-username>-plot`,
    edit the file, save, **commit** (`Add units to y-axis label`) and **Push origin**.
12. Refresh the PR page: your new commit is already there. Reply to the comment ("Done in a1b2c3d") and click **Resolve conversation**.

### 🪜 Steps: merge (done by the maintainer)

13. When the reviewer is happy they **Approve** and **Merge** the PR. You can't merge it yourself, because you don't own the
    central repository. In real lab projects, the maintainer or a second analyst does this.
14. After it's merged, click **Delete branch** on the PR page, and delete the branch in Desktop too (*Branch → Delete…*).

### ✍️ Your turn: review someone else
Open a colleague's PR on the central repository → **Files changed**. Hover over a line, click the blue **+**, and leave a helpful, specific comment.
Then *Review changes →* **Comment** (or **Approve**). Reviewing is a skill. Be kind, and say what and why.

### ✅ Expected result
Your PR shows your commits, the review conversation, and finally a purple **Merged** badge. Your file is in
`contributions/` on the central repository.

### 🛠️ Troubleshooting
- **Files changed shows my Module 4–7 edits too** (e.g. `R/02_plot_iris.R`): your branch started from *your* `main`, which
  contains your personal practice commits. Don't create the PR. Instead, use the website route, which always starts from the central version:
  1. On **https://github.com/riamahajan/git-practice**, open the `contributions` folder → **Add file → Create new file**.
  2. Name it `<your-username>.R`, paste in your code, then **Commit changes… → Propose changes → Create pull request**.
     GitHub creates the branch in your fork for you.
  3. To respond to review from Desktop later: **Fetch origin** → *Current Branch* → pick the new branch (e.g. `patch-1`) under *Other branches*.
- **The base repository is my fork, not `riamahajan`'s**: change *base repository* on the compare page. (Desktop's fork setting decides the default. See Module 1 Troubleshooting.)
- **"Can't automatically merge"**: someone changed the same lines. That's Module 10.
- **My new commit doesn't appear on the PR**: you committed on a different branch, or haven't pushed. Check *Current Branch*, then **Push origin**.

---

## Module 9 · Stay up to date: fetch, pull and sync

🎯 **Goal:** get changes made by other people (or made on the website) into your fork and onto your computer.

💡 **Why:** your fork does **not** update itself when the central repository changes, and your computer doesn't
update itself when GitHub changes. Before starting new work, always get the latest version, so you build on
everyone else's work instead of an old copy.

| Button | What it does |
|---|---|
| **Fetch origin** | asks GitHub "is there anything new?" and downloads it, **without changing your files** |
| **Pull origin** | merges what was fetched into your current branch, so your files update |
| **Sync fork** (github.com) | copies new commits from the central repo into your fork on GitHub |

```
  CENTRAL (upstream) ──Sync fork──►  YOUR FORK (origin) ──Fetch + Pull──►  YOUR COMPUTER
```

### 🪜 Steps

1. On github.com, open **your fork**. Under the green Code button it says something like *"This branch is 3 commits behind riamahajan:main"*.
2. Click **Sync fork → Update branch**.
3. In GitHub Desktop, switch to **main** and click **Fetch origin**. The button changes to **Pull origin ↓**. Click it.
4. In RStudio, open the `contributions/` folder. Everyone's merged contributions are there.

### ✍️ Your turn: a change made elsewhere
1. On github.com, in **your fork**, open `README.md` → the ✏️ pencil icon → add a line at the end (e.g. "Ria was here") →
   **Commit changes…** → **Commit changes**.
2. In Desktop, click **Fetch origin**. Notice your files *haven't* changed yet, but Desktop tells you there's 1 commit to pull.
3. Click **Pull origin**. Now the line is in your README in RStudio.

### ✅ Expected result
Your fork and your computer both include the latest central changes, plus your own. Desktop's top bar says **Fetch origin** with nothing to push or pull.

### 🛠️ Troubleshooting
- **Sync fork says there are conflicts**: someone changed lines that you also changed in your fork. Click **Open pull request**, or ask the facilitator. Module 10 explains conflicts.
- **Desktop won't pull because of uncommitted changes**: commit them first (or stash them: right-click in the Changes tab → **Stash All Changes**).
- **Alternative to Sync fork, all in Desktop:** on `main`, *Branch → Merge into Current Branch…* → **upstream/main** → **Create a merge commit** → **Push origin**.

---

## Module 10 · Merge conflicts

🎯 **Goal:** create a conflict on purpose, understand it, and resolve it calmly.

💡 **Why:** git combines changes automatically when they touch **different** lines. When two people change the
**same line** in different ways, git can't know which is right, so it stops and asks you. That's a merge conflict.
It's not an error, and nothing is lost.

When it happens, git writes **both** versions into the file between markers:

```r
<<<<<<< HEAD
scatter_title <- "Sepal vs petal length (all species)"
=======
scatter_title <- "Longer sepals, longer petals"
>>>>>>> title-b
```

The top part (`HEAD`) is the branch you're on, the one you're merging **into**. The bottom part is the branch being merged in. You decide the final
text, delete the three marker lines, save, and finish the merge.

### 🪜 Part 1, on your own (everyone)

1. On **main**, with no uncommitted changes: *Current Branch →* **New Branch** → `title-a` (based on **main**).
   Change `scatter_title` to `"Sepal vs petal length (all species)"`. Save and **commit**.
2. *Current Branch →* **main**. Then **New Branch** → `title-b`, based on **main**.
   Change the **same line** to `"Longer sepals, longer petals"`. Save and **commit**.
3. *Current Branch →* **main**. *Branch → Merge into Current Branch…* → **title-a** → **Create a merge commit**. It merges cleanly.
4. Now *Branch → Merge into Current Branch…* → **title-b**. Desktop warns: **"There will be 1 conflicted file."**
   Click the merge button anyway.
5. The **Resolve conflicts** window lists `R/02_plot_iris.R`. Either:
   - click the arrow next to the file and choose **Use the modified file from main** or **…from title-b**, *or*
   - open the file in RStudio, find the `<<<<<<<` markers, keep one line (or write a new combined title),
     delete the three marker lines, and **save**.
6. When Desktop shows the file as resolved, click **Continue merge**. Source the script to check it still runs, then **Push origin**.
7. Tidy up: delete branches `title-a` and `title-b` (*Branch → Delete…*).

### 🪜 Part 2, with a partner (facilitated)

This is the realistic version: two people, two pull requests, the same line. Pair up with someone whose
contribution from Module 8 has been **merged**. We'll call them Partner A, and you both edit A's file.

1. **Both:** sync your forks and pull (Module 9), so you both have `contributions/<A's-username>.R`.
2. **Both:** create a branch (based on **upstream/main** if offered): `A-title-<your-username>`.
3. **Both:** change the **same line**, `my_title <- ...`, to *different* titles. Commit, publish, and open a PR to the central repository.
4. **Facilitator:** merges one of the two PRs.
5. **The other person** now sees *"This branch has conflicts that must be resolved"* on their PR. Resolve it either:
   - **on github.com:** click **Resolve conflicts**, edit the file in the browser (keep the title you agree on, delete the markers) → **Mark as resolved** → **Commit merge**; *or*
   - **in Desktop:** on your branch, *Branch → Merge into Current Branch…* → **upstream/main** → resolve as in Part 1 → **Continue merge** → **Push origin**.
6. The PR no longer shows a conflict, and the facilitator can merge it.

### ✅ Expected result
You've resolved a conflict locally and on a pull request. The final file contains no `<<<<<<<`, `=======` or `>>>>>>>` lines, and the script runs.

### 🛠️ Troubleshooting
- **I want to stop and think**: click **Abort merge** in the conflict window. Everything goes back to how it was before the merge.
- **Desktop still says "conflicted"**: a marker line is still in the file. Search it for `<<<<<<<`.
- **The script errors after resolving**: you probably deleted a quote or bracket along with the markers. Compare with the History tab.
- **How to avoid conflicts in real projects:** pull often, keep branches short-lived, and agree who is editing which file.

---

# Part C. Recovery

## Module 11 · Troubleshooting and recovery

🎯 **Goal:** know the right "undo" for each situation, and practise every one.

💡 **Why:** fear of breaking things is the biggest barrier to using git. In fact git is very forgiving. Almost
everything can be undone, **as long as you pick the right tool for where the change is**:

| Where is the mistake? | Tool | Safe after pushing? |
|---|---|---|
| Edited but **not committed** | **Discard Changes** | n/a |
| Committed, **not pushed**, last commit only | **Undo** | ❌ (before pushing only) |
| Committed, **not pushed**, wrong message or forgot a file | **Amend Commit** | ❌ |
| Several commits, **not pushed** | **Reset to Commit** | ❌ |
| Committed **and pushed** | **Revert Changes in Commit** | ✅ the only safe choice |
| Just want to *look* at an old version | **History** / **Browse files** | ✅ changes nothing |

> ⚠️ **The golden rule:** once a commit is **pushed**, others may already have it. Don't undo or reset it.
> **Revert** it instead: revert adds a *new* commit that reverses the change, so shared history stays intact.

### 11.1 Discard edits you haven't committed
1. Make a mess in `R/01_explore_iris.R` (delete a few lines) and save.
2. In Desktop's Changes tab, right-click the file → **Discard Changes…** → confirm.
3. ✅ The file is back to its last committed version. *(To discard just some lines: right-click those lines in the diff.)*

⚠️ Discarded changes can't be recovered. That's the point. *(Desktop moves them to the Trash/Recycle Bin, as a last resort.)*

### 11.2 Undo a commit you haven't pushed
1. Change a title, save, and commit it with a deliberately bad message (`oops`).
2. Click **Undo** in the box just below the commit button (or right-click the commit in History → **Undo Commit…**).
3. ✅ The commit is gone and your change is back in the Changes tab. Fix it and commit again properly.

### 11.3 Fix the last commit (amend)
1. Commit a change with a typo in the message, and **don't push**.
2. History tab → right-click that commit → **Amend Commit…**. Edit the message (or tick more files), then click **Amend last commit**.
3. ✅ One clean commit instead of two.

### 11.4 Reset several unpushed commits
1. Make two small commits, and **don't push**.
2. History tab → right-click the commit *before* them → **Reset to Commit…** (needs GitHub Desktop 3.4 or newer. If you don't see it: *Help → Check for Updates*, or on a Mac *GitHub Desktop → Check for Updates*).
3. ✅ The two commits are removed from history, and their changes come back as **uncommitted** changes in the Changes tab.
   Keep them and recommit, or discard them (11.1).

### 11.5 View or recover an old version
- **Look:** History tab → click a commit. Or on github.com: commit → **Browse files**.
- **Recover an old version of one file:** on github.com, browse to the file at the old commit → **Raw** → copy the contents into your file in RStudio → save → commit (`Restore scatter plot settings from <SHA>`).

### 11.6 Revert a commit that's already pushed
1. Make a change, commit it (`Make all plots grey`) and **push**.
2. History tab → right-click that commit → **Revert Changes in Commit**.
3. A new commit, `Revert "Make all plots grey"`, appears. **Push origin**.
4. ✅ The change is undone, and the history honestly shows both what happened and that it was reversed.

### 11.7 Put work aside without committing (stash)
1. Start an edit, and suddenly you need to switch branch.
2. Changes tab → right-click → **Stash All Changes**. Your files are clean again.
3. Later, on the same branch: click **Stashed Changes** (bottom of the Changes tab) → **Restore**.

### 11.8 "I committed data or a password!"
- **Not pushed yet:** **Undo** the commit (11.2), untick or delete the file, and add it to `.gitignore`. ✅ Nothing left your computer.
- **Already pushed:** **stop and tell your supervisor or the facilitator straight away.** Reverting is *not* enough: the
  file stays in the history. Passwords and tokens must be **revoked** (changed). Data exposure may need to be reported
  under your data-sharing agreement or your institution's procedures. Removing it from history needs specialist help.
- *Practice it safely:* create `data_backup.csv` in the **main project folder** (not in `data/`), notice it **does** show in Changes,
  commit it, then **Undo** the commit and delete the file. Then think: what line could you add to `.gitignore` so that any
  `.csv` anywhere is ignored? (Answer: `*.csv`.)

### ✍️ Your turn
Without looking back, decide which tool fixes each one. Then try any you haven't done yet:
1. You deleted a function by accident 5 minutes ago and haven't committed.
2. You committed to `main` with message "asdf" and haven't pushed.
3. You pushed a change last week that broke the boxplot, and a colleague has already pulled it.

<details><summary>Answers</summary>

1. Discard Changes · 2. Undo (or Amend Commit) · 3. Revert Changes in Commit, then push

</details>

---

# Part D. Beyond the basics

## Module 12 · Good-practice checklist

Habits that will save you (and your colleagues) in real research projects:

- [ ] **Commit small and often.** One logical change per commit.
- [ ] **Write clear messages.** Start with a verb, say what and why.
- [ ] **Pull before you start**, and before you push.
- [ ] **Branch for anything shared**, and merge through a pull request with a review.
- [ ] **Review before merging.** Run the code, don't just read it.
- [ ] **Never commit data, credentials or personal information.** Set up `.gitignore` on day one.
- [ ] **Don't commit generated files** (plots, rendered reports, `.RData`). Commit the code that makes them.
- [ ] **Use relative paths** and an RStudio project. No `setwd("C:/Users/...")`.
- [ ] **Document how to reproduce** the analysis: data source, where to save it, packages, the order to run scripts.
- [ ] **Push regularly.** Your laptop is not a backup.

---

## Module 13 · Optional intermediate challenges

Pick any, in any order. Use a branch for each one!

1. **Write a function.** Like the March example's `custom_scatter()`, turn the scatter plot into a function in a new file
   `R/plot_functions.R`: `make_scatter(data, x_var, y_var, title)`. Call it from `02_plot_iris.R` using `source("R/plot_functions.R")`.
2. **Bullet-proof paths with `here`.** `install.packages("here")`, then use `read.csv(here::here("data", "iris.csv"))`.
   Why is this more robust than `"data/iris.csv"`? (Hint: try running a script from a subfolder.)
3. **A report.** Write `report.Rmd` that runs the analysis and knits to HTML. Should `report.html` be committed?
   Add the right line to `.gitignore`, and explain your choice in the commit message.
4. **Untrack a file that's already committed.** Commit a file `scratch.txt`, *then* add `scratch.txt` to `.gitignore`.
   Notice it's still tracked! Fix it: move `scratch.txt` out of the project folder, commit the deletion, then move it back. It's now ignored.
5. **Cherry-pick.** Make a commit on one branch, then drag it from the History tab onto another branch in the *Current Branch* list.
6. **Squash.** Make three tiny unpushed commits, then drag one onto another in the History tab to combine them.
7. **Tag a version.** History → right-click a commit → **Create Tag…** → `v1.0-paper-submission`. Push. Find it on GitHub under *Tags*.
   (In real projects: "this is exactly the code used for the paper".)
8. **Protect your `main`.** In your fork on github.com: *Settings → Branches → Add rule* for `main` → *Require a pull request before merging*.
   Now try to push straight to `main` and see what happens.
9. **Suggested changes.** When reviewing a PR, click the ± icon in a line comment to suggest an exact edit that the author can accept with one click.
10. **Draft pull requests.** Open a PR as a **Draft** to share work in progress, and mark it *Ready for review* later.

---

## Quick reference

| I want to… | GitHub Desktop / RStudio | git command (for reference) |
|---|---|---|
| copy a repo to my computer | *File → Clone Repository* | `git clone` |
| see what I changed | **Changes** tab | `git status`, `git diff` |
| choose what goes in a commit | tick boxes / click line numbers | `git add` |
| record a version | Summary → **Commit to …** | `git commit` |
| upload my commits | **Push origin** / **Publish branch** | `git push` |
| check for new commits | **Fetch origin** | `git fetch` |
| download and apply them | **Pull origin** | `git pull` |
| update my fork from the central repo | github.com → **Sync fork** | `git pull upstream main` |
| see the history | **History** tab | `git log` |
| make a branch | *Current Branch → New Branch* | `git switch -c` |
| switch branch | *Current Branch →* click a name | `git switch` |
| merge a branch in | *Branch → Merge into Current Branch* | `git merge` |
| open a pull request | **Preview Pull Request** / *Branch → Create Pull Request* | (github.com) |
| throw away uncommitted edits | right-click → **Discard Changes** | `git restore` |
| undo the last unpushed commit | **Undo** | `git reset --soft HEAD~1` |
| fix the last unpushed commit | History → **Amend Commit** | `git commit --amend` |
| go back to an earlier unpushed commit | History → **Reset to Commit** | `git reset` |
| undo a pushed commit safely | History → **Revert Changes in Commit** | `git revert` |
| put work aside | right-click → **Stash All Changes** | `git stash` |
| run a script | RStudio → **Source** | `Rscript` |
| check where R is looking for files | Console: `getwd()` | |

### Glossary
- **Repository (repo):** a project folder plus its full history.
- **Commit:** a recorded version, with a message, author, date and a unique **SHA**.
- **Branch:** a separate line of commits. **`main`** is the default, trusted line.
- **Fork:** your own copy of someone else's repository, on GitHub.
- **Clone:** a copy of a repository on your computer.
- **Remote:** a repository's online address. **origin** = your fork, **upstream** = the central repository.
- **Push / fetch / pull:** upload commits / download without applying / download and apply.
- **Pull request (PR):** a request to merge a branch, with review and discussion.
- **Merge conflict:** two changes to the same lines that git can't combine by itself.
- **`.gitignore`:** a list of files and folders git should never track.
- **Relative path:** a file location measured from the project folder, e.g. `data/iris.csv`.

### Getting help
- Ask in the lab channel, or ask the facilitator. Every mistake in this repo is safe.
- [GitHub Desktop documentation](https://docs.github.com/en/desktop)
- [Happy Git and GitHub for the useR](https://happygitwithr.com/), the classic guide for R users
- [Babraham Bioinformatics training](https://www.bioinformatics.babraham.ac.uk/training.html)

---

*Iris data: Fisher, R. A. (1936) and Anderson, E. (1935). Example project structure inspired by
[laurabiggins/March_example_R_project](https://github.com/laurabiggins/March_example_R_project).*
