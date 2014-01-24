clstats <- function(type, fmt='xml', ...){
    if(!type %in% c('colors', 'palettes', 'patterns', 'lovers'))
        stop("type must be 'colors', 'palettes', 'patterns', or 'lovers'")
    clQuery('stats', type, fmt=fmt, ...)
}
