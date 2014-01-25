\name{clpalettes}
\alias{clpalette}
\alias{clpalettes}
\alias{print.clpalette}
\title{Retrieve color palette or palettes}
\description{Retrieve a color palette or set of palletes from the COLOURlovers API.}
\usage{
clpalette(id, widths = FALSE, fmt = 'xml')

clpalettes(set = NULL, ..., fmt = 'xml')

}
\arguments{
  \item{id}{The COLOURlovers id (an integer) for a specific palette.}
  \item{widths}{A boolean indicating whether to include the color widths for the palette. Default is \code{FALSE}.}
  \item{set}{Optionally, a subset of COLOURlovers palettes. Allowed values are \dQuote{new}, \dQuote{top}, and \dQuote{random}.}
  \item{...}{A named list of parameters passed to the API request. Allowed parameters are \dots, \code{orderCol}, \code{sortBy}, \code{numResults}, and \code{resultOffset}. Specifying \code{orderCol} overrules any argument to \code{set}.}
  \item{fmt}{A format for the API response, one of \dQuote{xml} (the default) or \dQuote{json}. This has essentially no effect on function behavior.}
}
\details{Retrieve details about a palette or set of palettes.}
\value{A list of class \dQuote{clpalette}. This should be the same regardless of the value of \code{fmt}.}
\references{\url{http://www.colourlovers.com/api/#palettes}}
\author{Thomas J. Leeper}
%\note{}
%\seealso{}
\examples{
}
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }
