# kassotis2020

Distributable and reproducible record in the format of an R package for the research presented in:

Filer DL, Hoffman K, Sargis RM, Trasande L, Kassotis CD. On the utility of ToxCast-based predictive models to evaluate potential metabolic disruption by environmental chemicals. 2022. Environmental Health Perspectives (provisionally accepted). 

The analysis is replicated within 3 vignettes, published freely [here](https://daynefiler.com/kassotis2020).

Additionally, the specific figures and supplemental tables included in the paper are created by two scripts, 'makeFigs.R' and 'makeSuppTables.R' in the above 'inst' directory.

### Installation

```r
if (!require(remotes)) install.packages("remotes")
remotes::install_github("daynefiler/kassotis2020", 
                        dependencies = TRUE, 
                        build_vignettes = TRUE)
```
