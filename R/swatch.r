swatch <- function(x, ...){
    # extract colors from a COLOURlovers object and return them in hex
    
    s1 <- inherits(x, 'clpalette') | inherits(x, 'clpattern')
    s2 <- inherits(x, 'clpalettes') | inherits(x, 'clpatterns')
    if(s1)
        u <- list(paste('#',unlist(x$colors),sep=''))
    else if(s2)
        u <- lapply(x, function(z) paste('#',unlist(z$colors),sep=''))
    else if(inherits(x, 'clcolor'))
        u <- list(paste('#',x$hex,sep=''))
    else if(inherits(x, 'clcolors'))
        u <- lapply(x, function(z) paste('#',z$hex,sep=''))
    return(u)
}

