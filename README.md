# README

Analysis for (Tumino, et al., 2021) 

## To run:

In R

    install.packages("tidyverse")
    install.pakages("pzfx"")
    install.packages("brms"")
    install.packages("bayesplot")
    install.packages("remotes")
    remotes::install_github("momeara/MPStats")
    install.packages("rmarkdown")
    
    rmarkdown::render("analysis.Rmd", "html_document")
    
    
This will take ~10 minutes to run and generate `analysis.html`.