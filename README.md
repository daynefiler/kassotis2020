# kassotis2020

Distributable and reproducible record in the format of an R package for the research presented in:

Filer DL, Hoffman K, Sargis RM, Trasande L, Kassotis CD. On the utility of ToxCast-based predictive models to evaluate potential metabolic disruption by environmental chemicals. 2022. Environmental Health Perspectives (provisionally accepted). 

### Installation

```r
if (!require(remotes)) install.packages("remotes")
remotes::install_github("daynefiler/kassotis2020", 
                        dependencies = TRUE, 
                        build_vignettes = TRUE)
```
