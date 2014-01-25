cllover <- function(user, fmt='xml', ...){
    # request a single lover
    clQuery('lover', user, fmt=fmt, ...)
}

cllovers <- function(type=NULL, query = NULL, fmt='xml', ...){
    # request multiple lovers
    if(!is.null(type) && !type %in% c('new', 'top'))
        stop("type must be 'new' or 'top'")
    if(type=='random') # no query parameters allowed
        clQuery('lovers', type, fmt=fmt, ...)
    else
        clQuery('lovers', type, fmt=fmt, ...)
}
