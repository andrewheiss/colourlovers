\name{clcolors}
\alias{clcolor}
\alias{clcolors}
\alias{print.clcolor}
\title{Retrieve color or colors}
\description{Retrieve a color or set of colors from the COLOURlovers API.}
\usage{
clcolor(hex, fmt = 'xml')

clcolors(set = NULL, ..., fmt = 'xml')

}
\arguments{
  \item{hex}{The six-characte hexidemical representation of a single color.}
  \item{set}{Optionally, a subset of COLOURlovers colors. Allowed values are \dQuote{new}, \dQuote{top}, and \dQuote{random}.}
  \item{...}{A named list of parameters passed to the API request. Allowed parameters are \dots, \code{orderCol}, \code{sortBy}, \code{numResults}, and \code{resultOffset}. Specifying \code{orderCol} overrules any argument to \code{set}.}
  \item{fmt}{A format for the API response, one of \dQuote{xml} (the default) or \dQuote{json}. This has essentially no effect on function behavior.}
}
\details{Retrieve details about a color our set of colors.}
\value{A list of class \dQuote{clcolor}. This should be the same regardless of the value of \code{fmt}.}
\references{\url{http://www.colourlovers.com/api/#colors}}
\author{Thomas J. Leeper}
%\note{}
%\seealso{}
\examples{
# get a random color
clcolors('random')

# get a single color
clcolor('6B4106')

# plot a single color swatch
c <- clcolor(rgb(0,0,1), fmt='json')
plot(c)
}
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }
