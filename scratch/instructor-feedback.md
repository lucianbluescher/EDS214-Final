# Exceeds Spec
## Automate Running the entire analysis requires rendering one Quarto document
I believe my quarto doc is concise, organized and is a clear model of my project that hides all the background complexity. My belief is probably wrong, I would really like to know how I can make it of professional quality because at the end of the day in the workforce what matters most is what you show your boss. 

## At least one piece of functionality has been refactored into a function in its own file
I re factored the Environment Initialization (init_envi.R) and the function rolling_mean.R into their own files which makes running my analysis very clean. I used a roxygen for the function and both files explain what is happening in the footnotes. 

# Collaboration
My participation in peer feedback went very well. I chose to give extra attention to a few things because at the stage my partner was at, it was most helpful for me to help start organizing his folders so that once he got there, he had a good foundation to build off. I also give my reviewer ideas about what I needed help with and made it easy for her to give me feedback by checking in about where I was at in my process.

## Closed issues
ORGANIZE Issue: [Link Text](https://github.com/lucianbluescher/EDS214-Final/issues/6)
AUTOMATE Issue: [Link Text](https://github.com/lucianbluescher/EDS214-Final/issues/3)
DOCUMENT Issue: [Link Text](https://github.com/lucianbluescher/EDS214-Final/issues/7)


## Merge Conflict Resolve
[Link Text](https://github.com/lucianbluescher/EDS214-Final/commit/4292705e1f46faa54b02b41bf32c691bdac4ec5b)

# Instructor feedback

## Automate

[M] **Running the entire analysis requires rendering one Quarto document**

[M] The analysis runs without errors

[M] **The analysis produces the expected output**

[M] **Data import/cleaning is handled in its own script(s)**
- Fixed by splitting my 0_init_envi.R folder into 0_init_envi.R that initializes script by librarying packages and 1_data_download that cleans the needed data
- 1_data_download imports and cleans the data. I recommend renaming it to a title more reflective of the script's purpose (it's not downloading anything).

## Organize

[M] Raw data is contained in its own folder

[NY] Intermediate outputs are created and saved to a separate folder from raw data
- DONE Store in  `outputs`
- 1_download_data.R line 146 saves the intermediate output, but it's commented out so it doesn't do anything.

[M] **At least one piece of functionality has been refactored into a function in its own file**

## Document

[M] The repo has a README that explains where to find (1) data, (2) analysis script, (3) supporting code, and (4) outputs

[M] **The README includes a flowchart and text explaining how the analysis works**
Added flowchart to README
Added Short explanation of how analysis works

- Looks great!

[M] **The code is appropriately commented**

[M] **Variable and function names are descriptive and follow a consistent naming convention**
- Inconsitent capitalization and case: `fig3data` vs. `required_packages` vs. `BQ3`
FIXED

- Much more professional now

## Scale

After cloning the repo on Workbench:

[M] Running the environment initialization script installs all required packages
Fixed by isolating environment initialization script and labeling as 0

- Looks good!

[M] The analysis script runs without errors

## Collaborate

[M] **The student has provided attentive, constructive feedback in a peer review**

[M] **The student has contributed to a peer's repo by opening an issue and creating a pull request**

[M] The repo has at least three closed GitHub issues

[M] The commit history includes at least one merged branch and a resolved merge conflict

[NY] The rendered analysis is accessible via GitHub Pages
AFFIRMATIVE
