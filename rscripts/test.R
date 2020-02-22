# This script downloads data about danish beaches from an API
# It then prints the data at the end.

# Give some user feedback
m <- glue::glue("We made a small R script. It ran at {Sys.time()}")
message(m)

# Load libraries and custom functions
library(tidyverse)

# We build a custom function to turn NULL values in a list into NAs
null_to_na <- function(mylist){
  lapply(mylist, function(x){
    if(is.list(x)){
      null_to_na(x)
    } else {
      if(is.null(x)) NA else x
    }
  })
}

# Get API data
url <- "http://api.vandudsigten.dk/beaches"
data <- jsonlite::read_json(url)

# Clean and parse data in to table
data <- null_to_na(data)

out <- map_dfr(data, function(beach){

  beach_data <- beach$data

  beach$links <- NULL
  beach$data <- NULL

  beach_df <- beach_data %>% map_dfr(as_tibble)
  beach <- beach %>% as_tibble()

  df <- crossing(beach, beach_df)

  df

})

# Print it out so we can see some beach data
print(out)
