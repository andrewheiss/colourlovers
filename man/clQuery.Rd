\name{clquery}
\alias{clquery}
\title{Execute an API Query}
\description{Primarily an internal function for executing API calls.}
\usage{
clquery(type, set = NULL, query = NULL, fmt = 'xml', ...)
}
\arguments{
  \item{type}{An API type. One of \dQuote{colors}, \dQuote{palettes}, \dQuote{patterns}, \dQuote{lovers}, or \dQuote{stats}.}
  \item{set}{A further subtype of the API \code{type}.}
  \item{query}{An optional character string specifying additional query parameters.}
  \item{fmt}{A format for the API response, one of \dQuote{xml} (the default) or \dQuote{json}.}
  \item{...}{Ignored.}
}
\details{Primarily for internal use.}
\value{A list reflecting the API response. This should be the same regardless of the vale of \code{fmt}.}
%\references{}
\author{Thomas J. Leeper}
%\note{}
%\seealso{}
%\examples{}
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }
