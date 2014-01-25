clquery <- function(type, set = NULL, query = NULL, fmt = 'xml', ...){
	# API workhorse query function
	if(!type %in% c('color', 'colors',
                    'palette', 'palettes',
                    'pattern', 'patterns',
                    'lover', 'lovers',
                    'stats'))
        warning("API type not recognized")
	url <- paste('http://www.colourlovers.com/api/',type,sep="")
    if(!is.null(set))
    url <- paste(url,set,sep="/")
    
    if(is.null(fmt) || !fmt %in% c('xml','json')){
        warning('fmt is missing or incorrect; xml used by default')
        fmt <- 'xml'
    }
    url <- paste(url,'?format=',fmt,sep='')
    # handle parameters
    query <- paste(names(query),query,sep='=',collapse='&')
    url <- paste(url,query,sep="&")
    
    #response <- getURL(url, followlocation = 1L, ...)
    urlcon <- url(url)
    response <- paste(readLines(urlcon, warn=FALSE), collapse='')
    close(urlcon)
    
    # handle json or xml
    if(fmt == 'xml'){
        out <- xmlToList(x, addAttributes=FALSE)
        fixxml <- function(z){
            p <- xmlParse(x)
            if('title' %in% names(z))
                z$title <- xpathApply(p,'//title', xmlValue)[[1]]
            if('userName' %in% names(z))
                z$userName <- xpathApply(p,'//userName', xmlValue)[[1]]
            if('description' %in% names(z))
                z$description <- xpathApply(p,'//description', xmlValue)[[1]]
            if('url' %in% names(z))
                z$url <- xpathApply(p,'//url', xmlValue)[[1]]
            if('imageUrl' %in% names(z))
                z$imageUrl <- xpathApply(p,'//imageUrl', xmlValue)[[1]]
            if('badgeUrl' %in% names(z))
                z$badgeUrl <- xpathApply(p,'//badgeUrl', xmlValue)[[1]]
            #if('template' %in% names(z))
            #    z$template <- NULL
            return(z)
        }
        out <- lapply(out, fixxml)
    } else if(fmt=='json'){
        out <- fromJSON(response, simplify=FALSE)
    } else
        out <- response
    return(out)
}
