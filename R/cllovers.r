cllover <- function(user, fmt='xml', ...){
    # request a single lover
    out <- clquery('lover', user, fmt=fmt, ...)
    class(out) <- c('cllover',class(out))
}

cllovers <- function(type=NULL, query = NULL, fmt='xml', ...){
    # request multiple lovers
    if(!is.null(type) && !type %in% c('new', 'top'))
        stop("type must be 'new' or 'top'")
    if(type=='random') # no query parameters allowed
        out <- clquery('lovers', type, fmt=fmt, ...)
    else
        out <- clquery('lovers', type, fmt=fmt, ...)
    class(out) <- c('cllover',class(out))
}
