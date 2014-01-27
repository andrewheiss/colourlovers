\name{clcolors}
\alias{clcolor}
\alias{clcolors}
\alias{print.clcolor}
\alias{print.clcolors}
\title{Retrieve color or colors}
\description{Retrieve a color or set of colors from the COLOURlovers API.}
\usage{
clcolor(hex, fmt = 'xml')

clcolors(set = NULL, ..., fmt = 'xml')

}
\arguments{
  \item{hex}{The six-characte hexidemical representation of a single color.}
  \item{set}{Optionally, a subset of COLOURlovers colors. Allowed values are \dQuote{new}, \dQuote{top}, and \dQuote{random}.}
  \item{...}{A named list of parameters passed to the API request. Allowed parameters are \code{lover}, \code{hueRange}, \code{briRange}, \code{keywords}, \code{keywordsExact}, \code{orderCol}, \code{sortBy}, \code{numResults}, and \code{resultOffset}. Specifying \code{orderCol} overrules any argument to \code{set}. See details.}
  \item{fmt}{A format for the API response, one of \dQuote{xml} (the default) or \dQuote{json}. This has essentially no effect on function behavior.}
}
\details{
Retrieve details about a color our set of colors.

Specifying named arguments to \code{...} allows the user to request a specific response, as follows:

\code{lover}: A character string containing a COLOURlovers username.

\code{hueRange}: A two-element numeric vector containing the upper and lower bounds of a hue range. Allowed values are between 0 and 359, exclusive.

\code{briRange}: A two-element numeric vector containing the upper and lower bounds of a brightness range. Allowed values are between 0 and 99, exclusive.

\code{keywords}: A character string containing one or more keywords to search by.

\code{keywordsExact}: A boolean indicating search on keywords should be exact (\code{TRUE}) or not (\code{FALSE}, the API default).

\code{orderCol}: A character string containing a sort criterion. One of \dQuote{dateCreated}, \dQuote{score}, \dQuote{name}, \dQuote{numVotes}, \dQuote{numViews}.

\code{sortBy}: A character string containing either \dQuote{ASC} (for ascending by the \code{orderCol} criterion, the default) or \dQuote{DSC} (for descending).

\code{numResults}: A numeric value indicating the number of results to return, with a maximum of 100. Default is 20.

\code{resultOffset}: A numeric value indicating the page of results to return, with page size specified in the \code{numResults} argument.
}
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

# plot a single color clpng
c <- clcolor(rgb(0,0,1), fmt='json')
plot(c)
}
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }
