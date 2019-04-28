#' Extract colors from an object
#' 
#' Extract a list of colors from a COLOURlovers object
#' 
#' Extract color(s) from a colourlovers object.
#' 
#' @param x A colourlovers color, palette, or pattern object.
#' @param ... Ignored.
#' 
#' @return A list of character vectors containing hexidecimal representations
#'   of colors.
#' 
#' @export
#'   
#' @author Thomas J. Leeper
#' 
#' @examples \dontrun{
#' # Get top colors
#' swatch(clcolors('top'))
#' 
#' # Get colors from a specific palette
#' swatch(clpalette('113451'))
#' 
#' # Get colors from specific pattern
#' swatch(clpattern('1451'))
#' }
swatch <- function(x, ...) {
    # extract colors from a COLOURlovers object and return them in hex
    s1 <- inherits(x, 'clpalette') | inherits(x, 'clpattern')
    s2 <- inherits(x, 'clpalettes') | inherits(x, 'clpatterns')
    
    if (s1) {
        u <- list(paste('#', unlist(x$colors), sep = ''))
    } else if (s2) {
        u <- lapply(x, function(z)
            paste('#', unlist(z$colors), sep = ''))
    } else if (inherits(x, 'clcolor')) {
        u <- list(paste('#', x$hex, sep = ''))
    } else if (inherits(x, 'clcolors')) {
        u <- lapply(x, function(z)
            paste('#', z$hex, sep = ''))
    }
        
    return(u)
}
