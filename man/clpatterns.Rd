\name{clpatterns}
\alias{clpattern}
\alias{clpatterns}
\alias{print.clpattern}
\alias{print.clpatterns}
\title{Retrieve pattern or patterns}
\description{Retrieve a pattern or set of patterns from the COLOURlovers API.}
\usage{
clpattern(id, fmt = 'xml')

clpatterns(set = NULL, ..., fmt = 'xml')

}
\arguments{
  \item{id}{The COLOURlovers id (an integer) for a specific pattern.}
  \item{set}{Optionally, a subset of COLOURlovers patterns. Allowed values are \dQuote{new}, \dQuote{top}, and \dQuote{random}.}
  \item{...}{A named list of parameters passed to the API request. Allowed parameters are \code{orderCol}, \code{sortBy}, \code{numResults}, and \code{resultOffset}. Specifying \code{orderCol} overrules any argument to \code{set}.}
  \item{fmt}{A format for the API response, one of \dQuote{xml} (the default) or \dQuote{json}. This has essentially no effect on function behavior.}
}
\details{Retrieve details about a pattern or set of patterns.}
\value{A list of class \dQuote{clpattern}. This should be the same regardless of the value of \code{fmt}.}
\references{\url{http://www.colourlovers.com/api/#patterns}}
\author{Thomas J. Leeper}
%\note{}
%\seealso{}
\examples{
# get a random pattern
clpatterns('random')

# plot at a single pattern
p <- clpattern('1451', fmt='json')
plot(p)
}
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }
