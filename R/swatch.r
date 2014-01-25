swatch <- function(x, ...){
    # extract an imageUrl from a COLOURlovers object and print a swatch
    
    s1 <- inherits(x, 'clcolor') | inherits(x, 'clpalette') | inherits(x, 'clpattern')
    s2 <- inherits(x, 'clcolors') | inherits(x, 'clpalettes') | inherits(x, 'clpatterns')
    if(s1) {
        u <- x$imageUrl
        if(inherits(x,'clpalette'))
            par(mar=c(2,1,2,1))
        else
            par(mar=c(1,1,2,1))    
    } else if(s2){
        if(inherits(x,'clpalette'))
            par(mar=c(2,1,2,1), ask=TRUE)
        else
            par(mar=c(1,1,2,1), ask=TRUE)
        sapply(x, plot)
        return(invisible(x))
    }
    tmp <- tempfile()
    download.file(u, tmp, quiet=TRUE, mode='wb')
    if(inherits(x, 'clcolor'))
        m <- paste('Color #',x$hex,sep='')
    else if(inherits(x, 'clpalette'))
        m <- paste('Palette #',x$id,sep='')
    else if(inherits(x, 'clpattern'))
        m <- paste('Pattern #',x$id,sep='')
    else
        m <- ''
    plot(1:2, type='n', bty='n', xlab='', ylab='', xaxt='n', yaxt='n', fg='white', main=m)
    rasterImage(readPNG(tmp),1,1,2,2)
    if(inherits(x, 'clpalette'))
        axis(1, seq(1,2,length.out=5), unlist(x$colors))
    file.remove(tmp)
    return(invisible(x))
}

plot.clcolor <- function(x,...) swatch(x, ...)
plot.clcolors <- function(x,...) swatch(x, ...)
plot.clpalette <- function(x,...) swatch(x, ...)
plot.clpalettes <- function(x,...) swatch(x, ...)
plot.clpattern <- function(x,...) swatch(x, ...)
plot.clpatterns <- function(x,...) swatch(x, ...)
