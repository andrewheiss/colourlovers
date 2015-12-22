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
        p <- xmlParse(response, options=XML::NOCDATA)
        out <- xmlToList(p, addAttributes=FALSE)
    } else if(fmt=='json'){
        out <- fromJSON(response, simplifyVector = FALSE)
    } else
        out <- response
    return(out)
}
