clpalette <- function(id, widths = FALSE, fmt='xml'){
    # request a single palette
    out <- clquery('palette', id, query=list(widths=as.numeric(widths)), fmt=fmt)
    class(out) <- c('clpalette',class(out))
    return(out)
}

clpalettes <- function(type=NULL, ..., fmt='xml'){
    # request multiple palettes
    if(!is.null(type) && !type %in% c('new', 'top', 'random'))
        stop("type must be 'new', 'top', or 'random'")
    if(type=='random') {
        # no query parameters allowed
        out <- clQuery('palettes', type, fmt=fmt)
        if(!is.null(query))
            warning("query parameters ignored for 'random' palettes")
    } else
        out <- clQuery('palettes', type, query=query, fmt=fmt)
    class(out) <- c('clpalette',class(out))
    return(out)
}

print.clpalette <- function(x,...) {
    x
}
