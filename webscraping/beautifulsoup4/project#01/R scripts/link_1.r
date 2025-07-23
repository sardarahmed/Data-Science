library(httr)
library(rvest)
library(xml2)
library(dplyr)

user_agents <- c(
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36",
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36",
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36",
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
)

Artiles <- c()
Links <- c()
Date <- c()

scrape_page <- function(url, handle, user_agent) {
  Sys.sleep(runif(1, 2, 5)) # Wait 2-5 seconds between pages
  page <- GET(url, handle = handle, add_headers("User-Agent" = user_agent))
  if (status_code(page) != 200) {
    message(paste("Failed to fetch:", url))
    return()
  }
  html <- read_html(page)
  lis <- html %>% html_elements("li")
  count <- 0
  for (li in lis) {
    title_div <- li %>% html_element("div.title")
    if (is.na(title_div)) next  # Only process li with div.title
    a_tag <- title_div %>% html_element("a")
    if (is.na(a_tag)) next
    title <- a_tag %>% html_text(trim = TRUE)
    href <- a_tag %>% html_attr("href")
    link <- url_absolute(href, url)
    date_div <- li %>% html_element("div.more")
    date_text <- if (!is.na(date_div)) date_div %>% html_text(trim = TRUE) else "No date available"
    Artiles <<- c(Artiles, title)
    Links <<- c(Links, link)
    Date <<- c(Date, date_text)
    count <- count + 1
  }
  message(sprintf("Scraped %d articles from %s", count, url))
}

start_page <- 0
end_page <- 20
batch_size <- 5

current <- start_page
while (current <= end_page) {
  # New handle and random user-agent for each batch
  handle <- handle("https://www.ccdi.gov.cn")
  ua <- sample(user_agents, 1)
  for (p in current:min(current + batch_size - 1, end_page)) {
    if (p == 0) {
      url <- "https://www.ccdi.gov.cn/scdcn/zggb/zjsc/index.html"
    } else {
      url <- sprintf("https://www.ccdi.gov.cn/scdcn/zggb/zjsc/index_%d.html", p)
    }
    scrape_page(url, handle, ua)
  }
  current <- current + batch_size
  message("Waiting 5 seconds before next batch...")
  Sys.sleep(5)
}

df <- tibble(
  Article = Artiles,
  Link = Links,
  Date = Date
)

write.csv(df, "Link-1-Articles.csv", row.names = FALSE, fileEncoding = "UTF-8")
print(paste("Total articles scraped:", nrow(df)))