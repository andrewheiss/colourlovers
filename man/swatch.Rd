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
e <- function(e) NULL # function for tryCatch to fail in examples

# get a single random color
tryCatch( swatch(clcolors('random')), error = e)

# get top colors
tryCatch( swatch(clcolors('top')), error = e)

# get colors from a specific palette
tryCatch( swatch(clpalette('113451')), error = e)

# get colors from new palettes
tryCatch( swatch(clpalettes('new')), error = e)

# get colors from specific pattern
tryCatch( swatch(clpattern('1451')), error = e)

}
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }
