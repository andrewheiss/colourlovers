#' Retrieve basic statistics from COLOURlovers.
#' 
#' Retrieve basic statistics from the COLOURlovers API.
#' 
#' Retrieve total numbers of colors, palettes, patterns, or lovers.
#' 
#' @aliases clstats print.clstats
#' @param type An API type. One of \dQuote{colors}, \dQuote{palettes},
#' \dQuote{patterns}, or \dQuote{lovers}.
#' @param fmt A format for the API response, one of \dQuote{xml} (the default)
#' or \dQuote{json}. This has essentially no effect on function behavior.
#' @return A list of class \dQuote{clstats} containing at least one named
#' element (\dQuote{total}). This should be the same regardless of the value of
#' \code{fmt}.
#' @author Thomas J. Leeper
#' @references \url{http://www.colourlovers.com/api/#stats}
#' @examples
#' 
#' e <- function(e) NULL # function for tryCatch to fail in examples
#' 
#' tryCatch( clstats('colors'), error = e)
#' tryCatch( clstats('palettes'), error = e)
#' tryCatch( clstats('patterns'), error = e)
#' tryCatch( clstats('lovers'), error = e)
#' 
#' @export clstats
clstats <- function(type, fmt='xml'){
    type <- match.arg(type, c('colors', 'palettes', 'patterns', 'lovers'))
    out <- clquery('stats', type, fmt=fmt)
    class(out) <- c('clstats',class(out))
    attr(out,'clstat_type') <- type
    return(out)
}

#' @export
print.clstats <- function(x,...) {
    cat('Total ',attr(x,'clstat_type'),': ',attr(x, 'total'),'\n',sep='')
}
