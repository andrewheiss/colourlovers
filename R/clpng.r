#' Plot a COLOURlovers object
#' 
#' Plot a color, palette, or pattern color pie or PNG image in a plotting
#' device
#' 
#' Plot a colourlovers PNG image in a new plotting window.
#' 
#' @param x A colourlovers color, palette, or pattern object.
#' @param \dots Ignored.
#' 
#' @return The \code{x} object is invisibly returned.
#' 
#' @export
#' 
#' @aliases clpng clpie plot.clcolor plot.clcolors plot.clpalette
#'   plot.clpalettes plot.clpattern plot.clpatterns
#' 
#' @author Thomas J. Leeper
#' 
#' @examples
#' e <- function(e) NULL # function for tryCatch to fail in examples
#' 
#' # plot a color clpng
#' co <- tryCatch( clcolor(rgb(0,0,1)), error = e)
#' if(!is.null(co)) plot(co)
#' 
#' # plot a pattern clpng
#' p <- tryCatch( clpattern('1451'), error = e)
#' if(!is.null(p)) plot(p)
#' if(!is.null(p)) clpng(p)
#' 
#' # plot colors from a palette
#' p <- tryCatch( clpalette('113451'), error = e)
#' if(!is.null(p)) plot(p, type='pie')
#' if(!is.null(p)) clpie(p)
#' 
#' 
#' \dontrun{
#' # plot multiple palettes (interactively)
#' p <- tryCatch( clpalettes('top'), error = e)
#' if(!is.null(p)) plot(p) # PNG images
#' if(!is.null(p)) plot(p, type='pie') # pie chart swatches
#' }
#' 
clpng <- function(x, ...){
    # extract an imageUrl from a COLOURlovers object and print a clpng
    
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
        sapply(x, clpng)
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

#' @rdname clpng
#' @export
clpie <- function(x, ...){
    # extract colors a COLOURlovers object and print a pie of them
    
    s1 <- inherits(x, 'clcolor') | inherits(x, 'clpalette') | inherits(x, 'clpattern')
    s2 <- inherits(x, 'clcolors') | inherits(x, 'clpalettes') | inherits(x, 'clpatterns')
    if(s1) {
        u <- swatch(x)[[1]]
        par(mar=c(1,1,2,1))    
        if(inherits(x, 'clcolor'))
            m <- paste('Color #',x$hex,sep='')
        else if(inherits(x, 'clpalette'))
            m <- paste('Palette #',x$id,sep='')
        else if(inherits(x, 'clpattern'))
            m <- paste('Pattern #',x$id,sep='')
        else
            m <- ''
        pie(rep(1,length(u)), labels=u, border=NA, col=u, main=m)
        return(invisible(x))
    } else if(s2){
        par(mar=c(1,1,2,1), ask=TRUE)
        sapply(x, clpie)
        return(invisible(x))
    }
}

#' @rdname clpng
#' @param type One of \dQuote{png} (the default) or \dQuote{pie}.
#' @export
plot.clcolor <- function(x,type='png',...) {
    if(type=='png')
        clpng(x, ...)
    else if(type=='pie')
        clpie(x, ...)
}

#' @export
plot.clcolors <- plot.clcolor

#' @export
plot.clpalette <- plot.clcolor

#' @export
plot.clpalettes <- plot.clcolor

#' @export
plot.clpattern <- plot.clcolor

#' @export
plot.clpatterns <- plot.clcolor
