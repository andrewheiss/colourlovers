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
pid <- '1451'
p <- clpattern(pid, fmt='json')
plot(p)
swatch(p)
}
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }
