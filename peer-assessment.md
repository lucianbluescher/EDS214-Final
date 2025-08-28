# Peer Review

## Automate
### [ ] Running the entire analysis requires rendering one Quarto document
Not yet: Working code from spageti.R needs to be transferred to Quarto doc, but Quarto doc is set up in the correct folder.

### [ ] The analysis runs without errors
Not yet: When running code, some errors pop up where the objects are not found, may need to got through and make sure variable names are correct.

### [ ] The analysis produces the expected output
Not yet: In the process of calculating the moving average, once that is done creating ggplots will create the expected output. The quarto document is also set up to create a GitHub page website, which is the expected output.

### [ ] Data import/cleaning is handled in its own script(s)
Meets spec: Data cleaning is done in the spageti.R file

## Organize 
### [ ] Raw data is contained in its own folder
Meets spec: Raw data is stored in the data folder.

### [ ] Intermediate outputs are created and saved to a separate folder from raw data
Not Yet: Moving average function was written in the spageti.R file and can then be sourced into the Quarto doc. Cleaned data can be stored in the spageti.R file then sourced to the Quarto doc as well.

### [ ] At least one piece of functionality has been refactored into a function in its own file
Not Yet: Refer to previous spec.

## Document
### [ ] The repo has a README that explains where to find (1) data, (2) analysis script, (3) supporting code, and (4) outputs
Meets spec: README file was created. Description of folders are included, with a citation, and a brief introduction of the analysis.

### [ ] The README includes a flowchart and text explaining how the analysis works
Not Yet: Flow chart of the analysis not included.

### [ ] The code is appropriately commented
Meets spec: Comments describe what each function/chunk of code is doing.

### [ ] Variable and function names are descriptive and follow a consistent naming convention
Meets spec: Variable and function names are easy to read, understand, and are consistent.

## Scale 
### [ ] Running the environment initialization script installs all required packages
Meets spec: spageti.R includes a chunk of code that calls in the required packages, this chunk should be transferred to the Quarto doc.

### [ ] The analysis script runs without errors.
Not Yet: Errors within the spageti.R are a result of objects not being found.
