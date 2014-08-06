\name{plot}
\alias{clpng}
\alias{clpie}
\alias{plot.clcolor}
\alias{plot.clcolors}
\alias{plot.clpalette}
\alias{plot.clpalettes}
\alias{plot.clpattern}
\alias{plot.clpatterns}
\title{Plot a COLOURlovers object}
\description{Plot a color, palette, or pattern color pie or PNG image in a plotting device}
\usage{
\method{plot}{clcolor}(x, type='png', \dots)
\method{plot}{clcolors}(x, type='png', \dots)
\method{plot}{clpalette}(x, type='png', \dots)
\method{plot}{clpalettes}(x, type='png', \dots)
\method{plot}{clpattern}(x, type='png', \dots)
\method{plot}{clpatterns}(x, type='png', \dots)

clpng(x, ...)

clpie(x, ...)
}
\arguments{
  \item{x}{A colourlovers color, palette, or pattern object.}
  \item{type}{One of \dQuote{png} (the default) or \dQuote{pie}.}
  \item{\dots}{Ignored.} 
}
\details{Plot a colourlovers PNG image in a new plotting window.}
\value{The \code{x} object is invisibly returned.}
%\references{}
\author{Thomas J. Leeper}
%\note{}
%\seealso{}
\examples{
e <- function(e) NULL # function for tryCatch to fail in examples

# plot a color clpng
co <- tryCatch( clcolor(rgb(0,0,1)), error = e)
if(!is.null(co)) plot(co)

# plot a pattern clpng
p <- tryCatch( clpattern('1451'), error = e)
if(!is.null(p)) plot(p)
if(!is.null(p)) clpng(p)

# plot colors from a palette
p <- tryCatch( clpalette('113451'), error = e)
if(!is.null(p)) plot(p, type='pie')
if(!is.null(p)) clpie(p)


\dontrun{
# plot multiple palettes (interactively)
p <- tryCatch( clpalettes('top'), error = e)
if(!is.null(p)) plot(p) # PNG images
if(!is.null(p)) plot(p, type='pie') # pie chart swatches
}
}
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }
