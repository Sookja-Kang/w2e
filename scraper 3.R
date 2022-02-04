
# FUNCTION TO SCRAPE FIRST PAGE OF THREAD

scrape_page1 <- 
  function(url){
    
    html <- read_html(url)
    
    newpage1 <- tibble()
    
    # START ROUTINE
    #-------------------------------------#
    
    # get doc id op
    op_id <- 
      html %>% 
      wte.get.id.op()
    
    # get doc id replies
    id.replies <- 
      html %>% 
      wte.get.id.replies()
    
    # collate doc_ids
    doc_id <- 
      c(op_id, id.replies)
    
    #-------------------------------------#
    
    # get date op and replies and collate in situ
    date <- 
      c(wte.get.date.op(html),
        wte.get.date.replies(html))
    
    #-------------------------------------#
    
    # get author op
    author.op <- 
      html %>% 
      wte.get.author.op()
    
    # get author replies
    author.replies <- 
      html %>% 
      wte.get.author.replies()
    
    # collate author
    author <- c(author.op, author.replies)
    
    #-------------------------------------#
    
    # get type
    type <- 
      c("op", rep("re", length(doc_id)-1))
    
    #-------------------------------------#
    
    # get text 
    text <- 
      html %>% 
      wte.get.text()
    
    #-------------------------------------#
    
    # get thread_title
    thread_title <- 
      html %>% 
      wte.get.threadtitle()
    thread_title <- rep(thread_title, length(doc_id))
    
    #-------------------------------------#
    
    # get op_id
    op_id <- 
      rep(op_id, length(doc_id))
    
    #-------------------------------------#
    
    # get url
    url <- 
      rep(url, length(doc_id))
    
    #-------------------------------------#
    
    # assemble newly scraped page data
    
    checklength <- length(doc_id)
    
    if (length(date)         == checklength &
        length(author)       == checklength &
        length(type)         == checklength &
        length(text)         == checklength &
        length(thread_title) == checklength &
        length(op_id)        == checklength &
        length(url)          == checklength
    ) {
      error <- "no"
    } else {
      error        <- "yes"
      doc_id       <- length(doc_id)
      date         <- length(date)
      author       <- length(author)
      type         <- length(type)
      text         <- length(text)
      thread_title <- length(thread_title)
      op_id        <- length(op_id)
      url          <- length(url)
    }
    
    newpage1 <- 
      tibble(error, doc_id, date, author, type, 
             text, thread_title, op_id, url) %>% 
      mutate(thread_page = 1)
    
    newpage1
  }
  
 
