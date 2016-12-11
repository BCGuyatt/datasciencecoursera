---
title: "generateCodebook"
author: "BCGuyatt"
date: "11/12/2016"
output: html_document
---



## Getting & Cleaning Data - Project Codebook

This is the codebook for the Getting & Cleaning Data project output,
named TidyDat

TidyDat Data Structure:

```r
summary(TidyDat)
```

```
## Error in summary(TidyDat): object 'TidyDat' not found
```

List of Key Variables in the TidyDat data table

```r
key(TidyDat)
```

```
## Error in key(TidyDat): object 'TidyDat' not found
```

The first few rows of the TidyDat data table

```r
TidyDat
```

```
## Error in eval(expr, envir, enclos): object 'TidyDat' not found
```

Summary of variables

```r
summary(TidyDat)
```

```
## Error in summary(TidyDat): object 'TidyDat' not found
```

List all possible combinations of features

```r
TidyDat[, .N, by=c(names(TidyDat)[grep("^feat", names(TidyDat))])]
```

```
## Error in eval(expr, envir, enclos): object 'TidyDat' not found
```

## Save to file

Save data table objects to a tab-delimited text file called DatasetHumanActivityRecognitionUsingSmartphones.txt.

```r
f <- file.path(pname, "DatasetHumanActivityRecognitionUsingSmartphones.txt")
write.table(TidyDat, f, quote=FALSE, sep="\t", row.names=FALSE)
```

```
## Error in is.data.frame(x): object 'TidyDat' not found
```
