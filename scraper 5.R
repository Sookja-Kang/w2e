
# FULL ASSEMBLY 

fullread <- tibble()
#for (i in c(14:34)){

for (i in c(2676:length(allthreads))){
  page <- allthreads[i]
  
  p1 <- 
    scrape_page1(page) 
  fullread <- rbind(fullread, p1)
  cat("\nscraped page", i, "of", length(allthreads), "and added data")
  
  #----------#
  
  stem <- "https://community.whattoexpect.com"
  xpages <- c()
  xpages <- 
    page %>% 
    scrape_getxpages()
  n <- length(xpages)
  
  
  if (n > 0){
    xpages <- 
      paste0(stem, xpages)
    to.add <- tibble()
    for (i in c(1:n)){
      to.add <- 
        xpages[i] %>% 
        scrape_page1plusn() %>% 
        mutate(thread_page = (i+1))
      fullread <- 
        rbind(fullread, to.add)
    }
    cat("\n  this page has more than 1 p. worth of replies; added them")
  } 
}

cat("\n\nfinal dataset:", nrow(fullread), "messages")

fullread %>% export(paste0("data_full_", Sys.Date(), ".xlsx"))

cat("\n\nwrote full dataset to file. done.\n")
