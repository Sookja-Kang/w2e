
library(pacman)
p_load(tidyverse, rvest)

mypage <- "https://community.whattoexpect.com/forums/plus-size-moms-and-moms-to-be.html?page=27"

html <- read_html(mypage)


targetlinks <- 
  html_nodes(html, ".linkDiscussion") %>% 
  html_attr(name = "href")

stem <- "https://community.whattoexpect.com"

targetlinks <- paste0(stem, targetlinks)




Come visit <a href="www.netlify.app/lars">my page</a>. 

html_node()
html_nodes()
html_element()
html_elements()
xml_node()
xml_nodes()