clpalette <- function(id, fmt='xml', ...){
    # request a single palette
    out <- clquery('palette', id, fmt=fmt, ...)
    class(out) <- c('clpalette',class(out))
    return(out)
}

clpalettes <- function(type=NULL, query = NULL, fmt='xml', ...){
    # request multiple palettes
    if(!is.null(type) && !type %in% c('new', 'top', 'random'))
        stop("type must be 'new', 'top', or 'random'")
    if(type=='random') # no query parameters allowed
        out <- clQuery('palettes', type, fmt=fmt, ...)
    else
        out <- clQuery('palettes', type, fmt=fmt, ...)
    class(out) <- c('clpalette',class(out))
    return(out)
}
