clcolor <- function(hex, fmt='xml', ...){
    # request a single color
    clQuery('color', hex, fmt=fmt, ...)
}


clcolors <- function(type=NULL, query = NULL, fmt='xml', ...){
    # request multiple colors
    if(!is.null(type) && !type %in% c('new', 'top', 'random'))
        stop("type must be 'new', 'top', or 'random'")
    if(type=='random') # no query parameters allowed
        clQuery('colors', type, fmt=fmt, ...)
    else
        clQuery('colors', type, fmt=fmt, ...)
}
