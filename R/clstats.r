clstats <- function(type, fmt='xml', ...){
    if(!type %in% c('colors', 'palettes', 'patterns', 'lovers'))
        stop("type must be 'colors', 'palettes', 'patterns', or 'lovers'")
    out <- clquery('stats', type, fmt=fmt)
    class(out) <- c('clstats',class(out))
    attr(out,'clstat_type') <- type
    return(out)
}

print.clstats <- function(x,...)
    cat('Total ',attr(x,'clstat_type'),': ',x$total,'\n',sep='')
