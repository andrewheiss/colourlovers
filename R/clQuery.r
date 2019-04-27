#' Execute an API Query
#' 
#' Primarily an internal function for executing API calls.
#' 
#' Primarily for internal use.
#' 
#' @param type An API type. One of \dQuote{colors}, \dQuote{palettes},
#' \dQuote{patterns}, \dQuote{lovers}, or \dQuote{stats}.
#' @param set A further subtype of the API \code{type}.
#' @param query An optional character string specifying additional query
#' parameters.
#' @param fmt A format for the API response, one of \dQuote{xml} (the default)
#' or \dQuote{json}.
#' @param ... Ignored.
#' @return A list reflecting the API response. This should be the same
#' regardless of the vale of \code{fmt}.
#' @author Thomas J. Leeper
#' @export clquery
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
