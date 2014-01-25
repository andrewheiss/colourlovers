clpattern <- function(id, fmt='xml', ...){
    # request a single pattern
    out <- clquery('pattern', id, fmt=fmt, ...)
    class(out) <- c('clpattern',class(out))
    return(out)
}

clpatterns <- function(type=NULL, query = NULL, fmt='xml', ...){
    # request multiple patterns
    if(!is.null(type) && !type %in% c('new', 'top', 'random'))
        stop("type must be 'new', 'top', or 'random'")
    if(type=='random') # no query parameters allowed
        out <- clquery('patterns', type, fmt=fmt, ...)
    else
        out <- clquery('patterns', type, fmt=fmt, ...)
    class(out) <- c('clpattern',class(out))
    return(out)
}
