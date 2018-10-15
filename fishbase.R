install.packages("rfishbase", 
                 repos = c("http://packages.ropensci.org", "http://cran.rstudio.com"), 
                 type="source")
library("rfishbase")

common_names("Badejo", Language="Portuguese")
common_names("badejo", limit = 1000, server = getOption("FISHBASE_API",
                                                            FISHBASE_API), Language = NULL, fields = c("ComName", "Language",
                                                                                                       "C_Code", "SpecCode"))

names = common_to_sci("badejo", Language = "Portuguese") %>% 
        filter(Language=="Portuguese" & ComName=="Badejo") %>%
          select(Species) %>%
            slice(1)
          

sci_to_common("Epinephelus adscensionis")
