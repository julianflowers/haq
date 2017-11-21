library(RISmed)
library(tidyverse)
library(tidytext)
library(wordcloud)

search <- "amenable mortality"

s <- EUtilsSummary(search, 
              type = "esearch", 
              db = "pubmed",
              datetype = "pdat",
              retmax = 12000,
              mindate = 2005, 
              maxdate = 2016)
fetch <- EUtilsGet(s, type = "efetch", db = "pubmed")

abstracts <- data.frame(title = fetch@ArticleTitle,
                        abstract = fetch@AbstractText, 
                        journal = fetch@Title,
                        DOI = fetch@PMID, 
                        year = fetch@YearPubmed) %>%
  mutate(abstract = as.character(abstract))

abstracts %>%
  group_by(year) %>%
  tally() %>%
  ggplot(aes(year, n)) +
  geom_col(fill = "blue") +
  labs(title = paste0("Articles on ", search))

s@count

## there are 21 direct articles
am_abs <- abstracts %>%
  filter(stringr::str_detect(title, "[Aa]menable [Mm]ortality")) 

am_abs$abstract <- tm::removeNumbers(am_abs$abstract)

am_cloud <- am_abs %>%
  unnest_tokens(ngram, abstract, token = "ngrams", n=2) %>%
    count(ngram, sort = TRUE) %>%
   separate(ngram, c("word1", "word2"), sep = " ") %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word) %>%
  mutate(bigram = paste(word1, word2, sep = " ") )
   

am_cloud %>%
  with(wordcloud(bigram, n, min.freq = 3, max.words = 1000, colors = brewer.pal(8, "Dark2")), scale = c(8,.3), per.rot = 0.4)

am_abs %>%
  DT::datatable()

