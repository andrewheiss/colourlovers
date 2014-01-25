\name{cllovers}
\alias{cllover}
\alias{cllovers}
\alias{print.cllover}
\alias{print.cllovers}
\title{Retrieve a user (lover)}
\description{Retrieve a lover (user) or set of lovers from the COLOURlovers API.}
\usage{
cllover(user, comments = FALSE, fmt = 'xml')

cllovers(set = NULL, ..., fmt = 'xml')

}
\arguments{
  \item{user}{The COLOURlovers username for a specific user.}
  \item{comments}{A boolean indicating whether to include the last ten comments for the user. Default is \code{FALSE}.}
  \item{set}{Optionally, a subset of COLOURlovers palettes. Allowed values are \dQuote{new} and \dQuote{top}.}
  \item{...}{A named list of parameters passed to the API request. Allowed parameters are \code{orderCol}, \code{sortBy}, \code{numResults}, and \code{resultOffset}. Specifying \code{orderCol} overrules any argument to \code{set}.}
  \item{fmt}{A format for the API response, one of \dQuote{xml} (the default) or \dQuote{json}. This has essentially no effect on function behavior.}
}
\details{Retrieve details about a COLOURlovers user or users.}
\value{A list of class \dQuote{cllover}, including details about one or more users. This should be the same regardless of the value of \code{fmt}.}
\references{\url{http://www.colourlovers.com/api/#lovers}}
\author{Thomas J. Leeper}
%\note{}
%\seealso{}
\examples{
# retrieve top users
cllovers(set='top', fmt='json')

# retrieve a single user
cllover('COLOURlovers', fmt='json')
}
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }
