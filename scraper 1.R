
# .group-discussion__list__item__block

# .linkDiscussion


library(pacman)
p_load(rvest, tidyverse, tidytext, rio)

# data range
# from march 21
# https://community.whattoexpect.com/forums/plus-size-moms-and-moms-to-be.html?page=27
# to march 19
# https://community.whattoexpect.com/forums/plus-size-moms-and-moms-to-be.html?page=80

base_url <- "https://community.whattoexpect.com/forums/plus-size-moms-and-moms-to-be"

# create range of all the URLs we want to scrape for threads

range <- c(27:80)  

url_list <- c()

for (i in range){
    url <- paste0(base_url, ".html?page=", i)
    url_list <- c(url_list, url)
}


# treatment of each index page
allthreads <- c()
for (i in c(1:length(url_list))){
  page <- url_list[i]
  html <- read_html(page)
  threads <- 
    html_nodes(html, ".linkDiscussion") %>% 
    html_attr(name = "href")
  threads <- 
    paste0("https://community.whattoexpect.com", threads)
  allthreads <- c(allthreads, threads)
  cat("done with page", i, "of", length(url_list), "\n")
}
cat("\n\ncollected", length(allthreads), "thread URLs.\n")



