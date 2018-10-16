install.packages("rfishbase", 
                 repos = c("http://packages.ropensci.org", "http://cran.rstudio.com"), 
                 type="source")
library("rfishbase")

common_names("Badejo", Language="Portuguese")
common_names("badejo", limit = 1000, server = getOption("FISHBASE_API",
                                                            FISHBASE_API), Language = NULL, fields = c("ComName", "Language",
                                                                                                       "C_Code", "SpecCode"))
species.names = read.csv("species_names.csv")
sci = read.csv("sci.csv")
sci$eng = NA
species.names[,1] = iconv(species.names[,1],to="ASCII//TRANSLIT")
species.names$sci_name = NA
species.names$english_name = NA

for(n in 1:nrow(species.names)){
  species.names$sci_name[n] = common_to_sci(species.names[n,1], Language = "Portuguese") %>% 
    filter(Language=="Portuguese" & ComName==species.names[n,1]) %>%
    select(Species) %>%
    slice(1) 
}

for(n in 1:nrow(species.names)){
  species.names$english_name[n] = sci_to_common(species.names[[n,2]]) %>% 
    filter(Language=="English") %>%
    slice(1) %>% 
    select(ComName)
}
species.names = species.names %>% filter(!sci_name == "character(0)" & !english_name == "character(0)")
species.names$sci_name = unlist(species.names)
write.csv(species.names, file = "species.csv")
names = species.names %>% 
        common_to_sci("badejo", Language = "Portuguese") %>% 
        filter(Language=="Portuguese" & ComName=="Badejo") %>%
          select(Species) %>%
            slice(1) 
          

sci_to_common("Litopenaeus schimitti") %>% 
  filter(Language=="English") %>%
  slice(1) %>% 
  select(ComName)


sci.eng = sci %>% 
  sci_to_common("Epinephelus adscensionis") %>% 
  filter(Language=="English") %>%
  slice(1) %>% 
  select(ComName)

#############################


for(n in 1:nrow(sci)){
  sci$eng[n] = sci_to_common(sci[[n,1]]) %>% 
    filter(Language=="English") %>%
    slice(1) %>% 
    select(ComName)
}
sci = sci %>% filter(!eng == "character(0)")
sci$eng = unlist(sci$eng)
write.csv(sci, file = "sci_english.csv")

