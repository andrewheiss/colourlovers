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
#' 
#' @return A list reflecting the API response. This should be the same
#' regardless of the vale of \code{fmt}.
#' 
#' @author Thomas J. Leeper
#' @export
clquery <- function(type, set = NULL, query = NULL, fmt = 'xml', ...) {
    # API workhorse query function
    if (!type %in% c('color', 'colors',
                     'palette', 'palettes',
                     'pattern', 'patterns',
                     'lover', 'lovers',
                     'stats'))
        warning("API type not recognized")
    
    # Build URL query
    url <- paste('http://www.colourlovers.com/api/', type, sep = "")
    
    # Add set if present (new, top, random)
    if (!is.null(set)) {
        url <- paste(url, set, sep = "/")
    }
    
    # Add format
    if (is.null(fmt) || !fmt %in% c('xml', 'json')) {
        warning('fmt is missing or incorrect; xml used by default')
        fmt <- 'xml'
    }
    url <- paste(url, '?format=', fmt, sep = '')
    
    # Add parameters (named list documented in various cl*() functions)
    # query <- paste(names(query), query, sep = '=', collapse = '&')
    query <- paste(names(query), sapply(query, paste0, collapse = ","), 
                   sep = '=', collapse = '&')
    url <- paste(url, query, sep = "&")

    # Make actual HTTP call
    response <- GET(url, add_headers(user_agent = "User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:91.0) Gecko/20100101 Firefox/91.0"))

    # Handle json or xml response
    if (fmt == 'xml') {
        p <- xmlParse(response, options = XML::NOCDATA)
        out <- xmlToList(p, addAttributes = FALSE)
    } else if (fmt == 'json') {
        out <- fromJSON(content(response, "text"), simplifyVector = FALSE)
    }
    
    return(out)
}
