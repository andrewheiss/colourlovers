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
        out <- xmlToList(response, addAttributes=FALSE)
        p <- xmlParse(response)
        fixxml <- function(z, x){
            if('title' %in% names(z))
                z$title <- xmlValue(xmlChildren(x)$title)
            if('userName' %in% names(z))
                z$userName <- xmlValue(xmlChildren(x)$userName)
            if('description' %in% names(z))
                z$description <- xmlValue(xmlChildren(x)$description)
            if('url' %in% names(z))
                z$url <- xmlValue(xmlChildren(x)$url)
            if('imageUrl' %in% names(z))
                z$imageUrl <- xmlValue(xmlChildren(x)$imageUrl)
            if('badgeUrl' %in% names(z))
                z$badgeUrl <- xmlValue(xmlChildren(x)$badgeUrl)
            #if('template' %in% names(z))
            #    z$template <- NULL
            return(z)
        }
        if(type %in% c('color','colors'))
            out <- mapply(fixxml, out, xpathApply(p,'//color'), SIMPLIFY=FALSE)
        if(type %in% c('palette','palettes'))
            out <- mapply(fixxml, out, xpathApply(p,'//palette'), SIMPLIFY=FALSE)
        if(type %in% c('pattern','patterns'))
            out <- mapply(fixxml, out, xpathApply(p,'//pattern'), SIMPLIFY=FALSE)
        if(type %in% c('lover','lovers'))
            out <- mapply(fixxml, out, xpathApply(p,'//lover'), SIMPLIFY=FALSE)
        
    } else if(fmt=='json'){
        out <- fromJSON(response, simplify=FALSE)
    } else
        out <- response
    return(out)
}
