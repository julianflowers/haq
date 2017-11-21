## function for downloading abstracts from pubmed

pubmedAbstractR <- function(search, n = 1000, start = 2000, end = 2017){
  
  require(RISmed)
  require(tidyverse)
  
  search <- search
  n <- n
  start <- start
  end <- end
  
s1 <- EUtilsSummary(search, 
                      type = "esearch", 
                      db = "pubmed",
                      datetype = "pdat",
                      retmax = n,
                      mindate = start, 
                      maxdate = end)
  
fetch <- EUtilsGet(s1, type = "efetch", db = "pubmed")
  
abstracts <- data.frame(title = fetch@ArticleTitle,
                          abstract = fetch@AbstractText, 
                          journal = fetch@Title,
                          DOI = fetch@PMID, 
                          year = fetch@YearPubmed) %>%
    mutate(abstract = as.character(abstract))

## returns latest 1000 abstracts unless n value changed           
abstracts           }





