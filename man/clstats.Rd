\name{clstats}
\alias{clstats}
\alias{print.clstats}
\title{Retrieve basic statistics from COLOURlovers.}
\description{Retrieve basic statistics from the COLOURlovers API.}
\usage{
clstats(type, fmt = 'xml')
}
\arguments{
  \item{type}{An API type. One of \dQuote{colors}, \dQuote{palettes}, \dQuote{patterns}, or \dQuote{lovers}.}
  \item{fmt}{A format for the API response, one of \dQuote{xml} (the default) or \dQuote{json}. This has essentially no effect on function behavior.}
}
\details{Retrieve total numbers of colors, palettes, patterns, or lovers.}
\value{A list of class \dQuote{clstats} containing at least one named element (\dQuote{total}). This should be the same regardless of the value of \code{fmt}.}
\references{\url{http://www.colourlovers.com/api/#stats}}
\author{Thomas J. Leeper}
%\note{}
%\seealso{}
\examples{
e <- function(e) NULL # function for tryCatch to fail in examples

tryCatch( clstats('colors'), error = e)
tryCatch( clstats('palettes'), error = e)
tryCatch( clstats('patterns'), error = e)
tryCatch( clstats('lovers'), error = e)
}
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }
