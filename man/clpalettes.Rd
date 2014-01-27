\name{clpalettes}
\alias{clpalette}
\alias{clpalettes}
\alias{print.clpalette}
\alias{print.clpalettes}
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
  \item{...}{A named list of parameters passed to the API request. Allowed parameters are \code{lover}, \code{hueOption}, \code{hex}, \code{hex_logic}, \code{keywords}, \code{keywordsExact}, \code{orderCol}, \code{sortBy}, \code{numResults}, and \code{resultOffset}. Specifying \code{orderCol} overrules any argument to \code{set}. See details.}
  \item{fmt}{A format for the API response, one of \dQuote{xml} (the default) or \dQuote{json}. This has essentially no effect on function behavior.}
}
\details{
Retrieve details about a palette or set of palettes.

Specifying named arguments to \code{...} allows the user to request a specific response, as follows:

\code{lover}: A character string containing a COLOURlovers username.

\code{hueOption}: A character vector containing one or more named hues to search by. Allowed values are: \dQuote{red}, \dQuote{orange}, \dQuote{yellow}, \dQuote{green}, \dQuote{aqua}, \dQuote{blue}, \dQuote{violet}, \dQuote{fuchsia}. Any other values other than these named colors will be ignored.

\code{hex}: A character vector containing up to five colors specified as hexidecimal representation (with or without a leading hash symbol). Excess colors will be ignored.

\code{hex_logic}: A character value containing either \dQuote{AND} (the default) or \dQuote{OR}, for whether the values in \code{hex} should be searched for with a boolean AND versus OR logic. Specifying \dQuote{AND} will only return palettes with all requested colors.

\code{keywords}: A character string containing one or more keywords to search by.

\code{keywordsExact}: A boolean indicating search on keywords should be exact (\code{TRUE}) or not (\code{FALSE}, the API default).

\code{orderCol}: A character string containing a sort criterion. One of \dQuote{dateCreated}, \dQuote{score}, \dQuote{name}, \dQuote{numVotes}, \dQuote{numViews}.

\code{sortBy}: A character string containing either \dQuote{ASC} (for ascending by the \code{orderCol} criterion, the default) or \dQuote{DSC} (for descending).

\code{numResults}: A numeric value indicating the number of results to return, with a maximum of 100. Default is 20.

\code{resultOffset}: A numeric value indicating the page of results to return, with page size specified in the \code{numResults} argument.
}
\value{A list of class \dQuote{clpalette}. This should be the same regardless of the value of \code{fmt}.}
\references{\url{http://www.colourlovers.com/api/#palettes}}
\author{Thomas J. Leeper}
%\note{}
%\seealso{}
\examples{
# get a random palette
clpalettes('random')

# download top palettes
clpalettes('top', fmt='json')

# plot at a single palette
pid <- '113451'
p <- clpalette(pid, fmt='json')
plot(p)
}
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }
