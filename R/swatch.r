#' Extract colors from an object
#' 
#' Extract a list of colors from a COLOURlovers object
#' 
#' Extract color(s) from a colourlovers object.
#' 
#' @param x A colourlovers color, palette, or pattern object.
#' @param ... Ignored.
#' @return A list of character vectors containing hexidecimal representations
#' of colors.
#' @author Thomas J. Leeper
#' @examples
#' 
#' e <- function(e) NULL # function for tryCatch to fail in examples
#' 
#' # get top colors
#' tryCatch( swatch(clcolors('top')), error = e)
#' 
#' # get colors from a specific palette
#' tryCatch( swatch(clpalette('113451')), error = e)
#' 
#' # get colors from specific pattern
#' tryCatch( swatch(clpattern('1451')), error = e)
#' 
#' 
#' @export swatch
swatch <- function(x, ...){
    # extract colors from a COLOURlovers object and return them in hex
    
    s1 <- inherits(x, 'clpalette') | inherits(x, 'clpattern')
    s2 <- inherits(x, 'clpalettes') | inherits(x, 'clpatterns')
    if(s1)
        u <- list(paste('#',unlist(x$colors),sep=''))
    else if(s2)
        u <- lapply(x, function(z) paste('#',unlist(z$colors),sep=''))
    else if(inherits(x, 'clcolor'))
        u <- list(paste('#',x$hex,sep=''))
    else if(inherits(x, 'clcolors'))
        u <- lapply(x, function(z) paste('#',z$hex,sep=''))
    return(u)
}

