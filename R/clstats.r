clstats <- function(type, fmt='xml'){
    type <- match.arg(type, c('colors', 'palettes', 'patterns', 'lovers'))
    out <- clquery('stats', type, fmt=fmt)
    class(out) <- c('clstats',class(out))
    attr(out,'clstat_type') <- type
    return(out)
}

print.clstats <- function(x,...) {
    cat('Total ',attr(x,'clstat_type'),': ',attr(x, 'total'),'\n',sep='')
}
