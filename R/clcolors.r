clcolor <- function(hex, fmt='xml', ...){
    # request a single color
    out <- clquery('color', hex, fmt=fmt, ...)
    class(out) <- c('clcolor',class(out))
}


clcolors <- function(type=NULL, query = NULL, fmt='xml', ...){
    # request multiple colors
    if(!is.null(type) && !type %in% c('new', 'top', 'random'))
        stop("type must be 'new', 'top', or 'random'")
    if(type=='random') # no query parameters allowed
        out <- clquery('colors', type, fmt=fmt, ...)
    else
        out <- clquery('colors', type, fmt=fmt, ...)
    class(out) <- c('clcolor',class(out))
}
