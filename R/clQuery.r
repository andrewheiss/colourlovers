clQuery <- function(verb, query = NULL, format = 'xml'){
	# API workhorse query function
	if(!verb %in% c())
		warning("API query verb not recognized")
	url <- paste('http://www.colourlovers.com/api/',verb,sep="")
	if(!is.null(query))
		url <- paste(url,query,sep="/")
    if(format=='xml'){
        xml <- getURL(url, followlocation = 1L, ssl.verifypeer = 0L, ssl.verifyhost = 0L, ...)
        # parse xml
        return(xml)
    } else if(format=='json'){
        json <- getURL(url, followlocation = 1L, ssl.verifypeer = 0L, ssl.verifyhost = 0L, ...)
        # parse json
        return(json)
    } else
        stop("format must be 'xml' or 'json'")
}
