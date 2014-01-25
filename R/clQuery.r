clquery <- function(type, subtype = NULL, query = NULL, fmt = 'xml', ...){
	# API workhorse query function
	if(!type %in% c('colors', 'palettes', 'patterns', 'lovers', 'stats'))
        warning("API type not recognized")
	url <- paste('http://www.colourlovers.com/api/',type,sep="")
    if(!is.null(subtype))
        url <- paste(url,subtype,sep="/")
	if(!is.null(query))
		url <- paste(url,query,sep="/")
    
    if(is.null(fmt) || !fmt %in% c('xml','json'))
        warning('fmt is missing or incorrect; xml used by default')

    # handle parameters
    url <- paste(url,'?format=',fmt,sep='')
    
    #response <- getURL(url, followlocation = 1L, ...)
    urlcon <- url(url)
    response <- paste(readLines(urlcon, warn=FALSE), collapse='')
    close(urlcon)
    
    # handle json or xml
    if(fmt == 'xml'){
        out <- xmlToList(response)
    } else if(fmt=='json'){
        out <- fromJSON(response, simplify=FALSE)
    } else
        out <- response
    
    return(out)
}
