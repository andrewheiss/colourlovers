clpalette <- function(id, fmt='xml', ...){
    # request a single palette
    clQuery('palette', id, fmt=fmt, ...)
}

clpalettes <- function(type=NULL, query = NULL, fmt='xml', ...){
    # request multiple palettes
    if(!is.null(type) && !type %in% c('new', 'top', 'random'))
        stop("type must be 'new', 'top', or 'random'")
    if(type=='random') # no query parameters allowed
        clQuery('palettes', type, fmt=fmt, ...)
    else
        clQuery('palettes', type, fmt=fmt, ...)
}
