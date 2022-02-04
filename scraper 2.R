
page <- allthreads[7]

html <- read_html(page)

# get thread title (will be thread)
wte.get.threadtitle <- 
  function(html){
  html %>% 
    html_elements("h1") %>% 
    html_text2()
  }

# get the ID of the OP (will be doc_id)
wte.get.id.op <- 
  function(html){
    html %>% 
      html_nodes(".discussion-original-post__content") %>% 
      html_attr("id") %>% 
      str_replace_all("message-", "m-")
  }

# get text of OP and all replies (will be text)
wte.get.text <- 
  function(html){
    x <- 
      html %>% 
      html_nodes(".__messageContent") %>% 
      html_text2() 
    x[x != ""]
  }


# get the IDs of all replies (will be doc_id)
wte.get.id.replies <- 
  function(html){
  html %>% 
      html_nodes(".wte-reply") %>% 
      html_attr("id") %>% 
      str_replace_all("message-", "m-")
  }

# get date OP
wte.get.date.op <- 
  function(html){
      html %>% 
      html_nodes(".discussion-original-post__author__updated") %>% 
      html_attr("data-date") %>% 
      as.numeric() %>% 
      `/`(1000) %>% 
      as.POSIXct(origin="1970-01-01")
  }

wte.get.date.op(html)

# get date replies
wte.get.date.replies <- 
  function(html){
    html %>% 
      html_nodes(".wte-reply__author__updated") %>% 
      html_attr("data-date") %>% 
      as.numeric() %>% 
      `/`(1000) %>% 
      as.POSIXct(origin="1970-01-01")
  }


# get author OP
wte.get.author.op <- 
  function(html){
  html %>% 
  html_nodes(".discussion-original-post__author__name") %>% 
    html_text2()
  }

# get author reply
wte.get.author.replies <- 
  function(html){
    html %>% 
      html_nodes(".wte-reply__author__name") %>% 
      html_text2()
  }






