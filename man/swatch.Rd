\name{swatch}
\alias{swatch}
\title{Extract colors from an object}
\description{Extract a list of colors from a COLOURlovers object}
\usage{
swatch(x, ...)
}
\arguments{
  \item{x}{A colourlovers color, palette, or pattern object.}
  \item{...}{Ignored.} 
}
\details{Extract color(s) from a colourlovers object.}
\value{A list of character vectors containing hexidecimal representations of colors.}
%\references{}
\author{Thomas J. Leeper}
%\note{}
%\seealso{}
\examples{
# get a single random color
swatch(clcolors('random'))

# get top colors
swatch(clcolors('top'))

# get colors from a specific palette
swatch(clpalette('113451'))

# get colors from new palettes
swatch(clpalettes('new'))

# get colors from specific pattern
swatch(clpattern('1451'))

}
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }
