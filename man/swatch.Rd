\name{swatch}
\alias{swatch}
\alias{plot.clcolor}
\alias{plot.clcolors}
\alias{plot.clpalette}
\alias{plot.clpalettes}
\alias{plot.clpattern}
\alias{plot.clpatterns}
\title{Plot a COLOURlovers object}
\description{Plot a color, palette, or pattern PNG image in a plotting device}
\usage{
swatch(x, ...)
}
\arguments{
  \item{x}{A colourlovers color, palette, or pattern object.}
  \item{...}{Ignored.} 
}
\details{Plot a colourlovers PNG image in a new plotting window.}
\value{The \code{x} object is invisibly returned.}
%\references{}
\author{Thomas J. Leeper}
%\note{}
%\seealso{}
\examples{
# plot a color swatch
c <- clcolor(rgb(0,0,1), fmt='json')
plot(c)

# plot a pattern swatch
p <- clpattern('1451', fmt='json')
plot(p)
swatch(p)

\dontrun{
# plot multiple palettes (interactively)
p <- clpalettes('top', fmt='json')
plot(p)
}
}
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }
