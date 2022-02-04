library(pacman)
p_load(rvest, tidyverse, purrr)

# ===============================================================
# HELPER FUNCTIONS
# ===============================================================

# Get thread info (thread title and url)

page_url <- "https://community.whattoexpect.com/forums/plus-size-moms-and-moms-to-be.html"

scrape_thread_info(page_url)

scrape_thread_info <- function(page_url){
  
  html <- page_url %>%
    read_html() %>%
    html_nodes(css = ".linkDiscussion a")
  
  tibble(
    title = html %>% html_text(),
    url = html %>% html_attr(name = "href")
  )
  
}


# Check if thread has a single page

has_single_page <- function(thread_url){
  
  thread_url %>%
    read_html() %>%
    html_node(css = ".brace") %>%
    html_text() %>%
    is.na()
}

# Scrape posts

scrape_posts <- function(thread_link){
  
  thread_link %>%
    read_html() %>%
    html_nodes(css = ".message_data") %>%
    html_text() %>%
    str_squish()
  
}

# ================================================================
# MAIN FUNCTION FOR SCRAPING
# ================================================================

scrape_gs_pages <- function(pages){
  
  # Find number of pages in the forum and get the link for each page
  
  page_1_url <- "https://www.gearslutz.com/board/mastering-forum/"
  page_1_html <- read_html(page_1_url)
  
  n_pages <- page_1_html %>%
    html_nodes(css = ".inner_nav .smallfont") %>%
    html_text() %>%
    str_extract(pattern = "\\d+") %>%
    as.numeric() %>%
    max(na.rm = TRUE)
  
  page_urls <- c(
    page_1_url,
    paste0("https://www.gearslutz.com/board/mastering-forum/index", 2:n_pages, ".html")
  )[pages]
  
  
  # Get threads info for the pages of interest
  
  master <- map_dfr(page_urls, scrape_thread_info)
  
  master %>%
    mutate(
      posts = url %>% map(scrape_posts)
    )
  
}

forum_data <- scrape_gs_pages(pages = c(1, 2))


