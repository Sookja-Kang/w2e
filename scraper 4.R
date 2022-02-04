
# FUNCTION THAT CHECKS IF THERE IS MORE THAN 1 PAGE IN THREAD

scrape_getxpages <- 
  
  function(url){
    html <- read_html(url)
    xpages <- c()
    xpages <- 
      html %>% 
      html_nodes(".d-none li .page-link") %>% 
      html_attr("href") %>% 
      unique()
    xpages
  }

# FUNCTION THAT SCRAPES A 1+Nth PAGE

scrape_page1plusn <- 
  function(url){
    
    htmlx <- read_html(url)
    
    xpagedata <- tibble()
    
    # get doc id op
    op_id <- 
      htmlx %>% 
      wte.get.id.op()
    
    #----------#
    
    doc_id <- 
      htmlx %>% 
      wte.get.id.replies()
    
    #----------#
    
    thread_title <- 
      htmlx %>% 
      wte.get.threadtitle()
    
    #-------------------------------------#
    
    # get date replies
    date <- 
      htmlx %>% 
      wte.get.date.replies()
    
    #-------------------------------------#
    
    # get author replies
    author <- 
      htmlx %>% 
      wte.get.author.replies()
    
    #-------------------------------------#
    
    # get type
    type <- 
      rep("re", length(doc_id))
    
    #-------------------------------------#
    
    # get text 
    text <- 
      htmlx %>% 
      wte.get.text() %>% 
      .[-1]

    
    #-------------------------------------#
      
    checklength <- length(doc_id)
    
    if (length(date)         == checklength &
        length(author)       == checklength &
        length(type)         == checklength &
        length(text)         == checklength 
    ) { 
      error <- "no"
    } else {
      error        <- "yes"
      doc_id       <- length(doc_id)
      date         <- length(date)
      author       <- length(author)
      type         <- length(type)
      text         <- length(text)
    }
    
    newdoc <- 
      tibble(error, doc_id, date, author, type, 
             text) %>% 
      mutate(
        thread_title = thread_title,
        op_id = op_id,
        url = url
      )
    
    xpagedata <- 
      rbind(xpagedata, newdoc)
    
    xpagedata
  }
      
