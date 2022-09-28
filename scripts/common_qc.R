# Common QC script

# Make column of Brand + change colname to Make
mtcars <- mtcars %>% 
  dplyr::mutate(Brand = unlist(lapply(strsplit(as.character(mtcars$V1), "\\ "), function(x) x[[1]])), .before = V1) %>%
  dplyr::rename(Make = V1)