\name{clQuery}
\alias{clQuery}
\title{Execute a Data Sharing API Query}
\description{Primarily an internal function for executing API calls.}
\usage{
clQuery(verb, query = NULL, ...)
}
\arguments{
  \item{verb}{An API verb\dots}
  \item{query}{An optional character string specifying additional query parameters.}
  \item{...}{Optionally, additional arguments passed to \code{getURL}.}
}
\details{Primarily for internal use.}
\value{A character string containing an XML data structure.}
%\references{}
\author{Thomas J. Leeper}
%\note{}
%\seealso{}
%\examples{}
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }
