swatch <- function(x, ...){
    # extract an imageUrl from a COLOURlovers object and print a swatch
    
    s <- inherits(x, 'clcolor') | inherits(x, 'clpalette') | inherits(x, 'clpattern')
    if(s) {
        u <- x$imageUrl
    } else {
        warning("Object has multiple images. First is used.")
        x <- x[[1]]
        u <- x$imageUrl
    }
    download.file(p$imageUrl, tmp <- tempfile(), mode='wb')
    if(inherits(x, 'clcolors'))
        m <- paste('Color #',x$id,sep='')
    else if(inherits(x, 'clpalette'))
        m <- paste('Palette #',x$id,sep='')
    else if(inherits(x, 'clpattern'))
        m <- paste('Pattern #',x$id,sep='')
    else
        m <- ''
    par(mar=c(1,1,2,1))
    plot(1:2, type='n', bty='n', xlab='', ylab='', xaxt='n', yaxt='n', fg='white', main=m)
    rasterImage(readPNG(tmp),1,1,2,2)
    if(inherits(x, 'clpalette'))
        axis(1, seq(1,2,length.out=5), unlist(x$colors))
    unlink(tmp)
    return(invisible(x))
}

plot.clcolor <- function(x,...) .swatch(x, ...)
plot.clcolors <- function(x,...) .swatch(x, ...)
plot.clpalette <- function(x,...) .swatch(x, ...)
plot.clpalettes <- function(x,...) .swatch(x, ...)
plot.clpattern <- function(x,...) .swatch(x, ...)
plot.clpatterns <- function(x,...) .swatch(x, ...)
