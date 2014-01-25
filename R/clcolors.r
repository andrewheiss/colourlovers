clcolor <- function(hex, fmt='xml'){
    # request a single color
    out <- clquery('color', substring(gsub('#','',hex),1,6), fmt=fmt)
    class(out) <- c('clcolor',class(out))
    return(out)
}


clcolors <- function(set = NULL, ..., fmt='xml'){
    # request multiple colors
    if(!is.null(set) && !set %in% c('new', 'top', 'random'))
        stop("set must be 'new', 'top', or 'random', or NULL")
    if(set=='random'){
        out <- clquery('colors', set, query=query, fmt=fmt)
        if(!is.null(query))
            warning("query parameters ignored for 'random' colors")
    } else
        out <- clquery('colors', set, query=query, fmt=fmt)
    class(out) <- c('clcolor',class(out))
    return(out)
}

print.clcolor <- function(x,...) {
    x
}
