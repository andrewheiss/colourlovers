\name{clstats}
\alias{clstats}
\title{Retrieve basic statistics from COLOURlovers.}
\description{Retrieve basic statistics from the COLOURlovers API.}
\usage{
clQuery(type, fmt = 'xml', ...)
}
\arguments{
  \item{type}{An API type. One of \dQuote{colors}, \dQuote{palettes}, \dQuote{patterns}, or \dQuote{lovers}.}
  \item{fmt}{A format for the API response, one of \dQuote{xml} (the default) or \dQuote{json}.}
  \item{...}{Optionally, additional arguments passed to \code{getURL}.}
}
\details{Retrieve total numbers of colors, palettes, patterns, or lovers.}
\value{A list reflecting the API response. This should be the same regardless of the vale of \code{fmt}.}
%\references{}
\author{Thomas J. Leeper}
%\note{}
%\seealso{}
%\examples{}
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }
