clpattern <- function(id, fmt='xml', ...){
    # request a single pattern
    clQuery('pattern', id, fmt=fmt, ...)
}

clpatterns <- function(type=NULL, query = NULL, fmt='xml', ...){
    # request multiple patterns
    if(!is.null(type) && !type %in% c('new', 'top', 'random'))
        stop("type must be 'new', 'top', or 'random'")
    if(type=='random') # no query parameters allowed
        clQuery('patterns', type, fmt=fmt, ...)
    else
        clQuery('patterns', type, fmt=fmt, ...)
}
