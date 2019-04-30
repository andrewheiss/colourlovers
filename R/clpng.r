#' Plot a COLOURlovers object
#' 
#' Plot a color, palette, or pattern color pie or PNG image in a plotting
#' device
#' 
#' Plot a colourlovers PNG image in a new plotting window.
#' 
#' @param x A colourlovers color, palette, or pattern object.
#' @param ask A boolean indicating if plots should be presented interactively 
#'   or all at once (default is \code{FALSE}).
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
#' @examples \dontrun{
#' # Plot a color clpng
#' co <- clcolor(rgb(0, 0, 1))
#' plot(co)
#' 
#' # Plot a pattern clpng
#' p <- clpattern('1451')
#' plot(p)
#' clpng(p)
#' 
#' # Plot colors from a palette
#' p <- clpalette('113451')
#' plot(p, type = 'pie')
#' clpie(p)
#' 
#' # Plot multiple palettes (interactively)
#' p <- clpalettes('top')
#' plot(p) #  PNG images
#' plot(p, type = 'pie')  # pie chart swatches
#' }
#' 
clpng <- function(x, ask = TRUE, ...) {
    # extract an imageUrl from a COLOURlovers object and print a clpng
    s1 <- inherits(x, 'clcolor') | inherits(x, 'clpalette') | inherits(x, 'clpattern')
    s2 <- inherits(x, 'clcolors') | inherits(x, 'clpalettes') | inherits(x, 'clpatterns')
    
    if (s1) {
        u <- x$imageUrl
        if (inherits(x, 'clpalette'))
            par(mar = c(2, 1, 2, 1))
        else
            par(mar = c(1, 1, 2, 1))
    } else if (s2) {
        if (inherits(x, 'clpalette'))
            par(mar = c(2, 1, 2, 1), ask = ask)
        else
            par(mar = c(1, 1, 2, 1), ask = ask)
        sapply(x, clpng)
        return(invisible(x))
    }
    
    tmp <- tempfile()
    download.file(u, tmp, quiet = TRUE, mode = 'wb')
    if (inherits(x, 'clcolor')) {
        m <- paste('Color #', x$hex, sep = '')
    } else if (inherits(x, 'clpalette')) {
        m <- paste('Palette #', x$id, sep = '')
    } else if (inherits(x, 'clpattern')) {
        m <- paste('Pattern #', x$id, sep = '')
    } else {
        m <- ''
    }
    
    plot(1:2, type = 'n', bty = 'n', xlab = '', ylab = '',
        xaxt = 'n', yaxt = 'n', fg = 'white', main = m)
    rasterImage(readPNG(tmp), 1, 1, 2, 2)
    
    if (inherits(x, 'clpalette')) {
        axis(1, seq(1, 2, length.out = 5), unlist(x$colors))
    }
    file.remove(tmp)
    
    return(invisible(x))
}

#' @rdname clpng
#' @export
clpie <- function(x, ask = TRUE, ...) {
    # extract colors a COLOURlovers object and print a pie of them
    s1 <- inherits(x, 'clcolor') | inherits(x, 'clpalette') | inherits(x, 'clpattern')
    s2 <- inherits(x, 'clcolors') | inherits(x, 'clpalettes') | inherits(x, 'clpatterns')
    
    if (s1) {
        u <- swatch(x)[[1]]
        par(mar = c(1, 1, 2, 1))
        
        if (inherits(x, 'clcolor')) {
            m <- paste('Color #', x$hex, sep = '')
        } else if (inherits(x, 'clpalette')) {
            m <- paste('Palette #', x$id, sep = '')
        } else if (inherits(x, 'clpattern')) {
            m <- paste('Pattern #', x$id, sep = '')
        } else{
            m <- ''
        }
        
        pie(rep(1, length(u)), labels = u, border = NA, col = u, main = m)
        
        return(invisible(x))
    } else if (s2) {
        par(mar = c(1, 1, 2, 1), ask = ask)
        sapply(x, clpie)
        return(invisible(x))
    }
}

#' @rdname clpng
#' @param type One of \dQuote{png} (the default) or \dQuote{pie}.
#' @export
plot.clcolor <- function(x, type = 'png', ...) {
    if (type == 'png') {
        clpng(x, ...)
    } else if (type == 'pie') {
        clpie(x, ...)
    }
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
