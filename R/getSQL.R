getSQL <- function(filepath){
  conect = file(filepath, "r")
  sql.string <- ""
  
  while (TRUE){
    line <- readLines(conect, n = 1)
    
    if ( length(line) == 0 ){
      break
    }
    
    line <- gsub("\\t", " ", line)
    
    # if(grepl("--",line) == TRUE){
    #   line <- paste(sub("--","/*",line),"*/")
    # }
    
    sql.string <- paste(sql.string, line)
  }
  
  close(conect)
  return(sql.string)
}

##SS




