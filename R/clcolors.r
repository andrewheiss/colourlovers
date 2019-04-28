#' Retrieve color or colors
#' 
#' Retrieve a color or set of colors from the COLOURlovers API.
#' 
#' Retrieve details about a color our set of colors.
#' 
#' Specifying named arguments to \code{...} allows the user to request a
#' specific response, as follows:
#' 
#' \itemize{
#'   \item \code{lover}: A character string containing a COLOURlovers username.
#'   \item \code{hueRange}: A two-element numeric vector containing the upper and lower
#'         bounds of a hue range. Allowed values are between 0 and 359, exclusive.
#'   \item \code{briRange}: A two-element numeric vector containing the upper and lower
#'         bounds of a brightness range. Allowed values are between 0 and 99,
#'         exclusive.
#'   \item \code{keywords}: A character string containing one or more keywords to
#'         search by.
#'   \item \code{keywordsExact}: A boolean indicating search on keywords should be
#'         exact (\code{TRUE}) or not (\code{FALSE}, the API default).
#'   \item \code{orderCol}: A character string containing a sort criterion. One of
#'         \dQuote{dateCreated}, \dQuote{score}, \dQuote{name}, \dQuote{numVotes},
#'         \dQuote{numViews}.
#'   \item \code{sortBy}: A character string containing either \dQuote{ASC} (for
#'         ascending by the \code{orderCol} criterion, the default) or \dQuote{DSC}
#'         (for descending).
#'   \item \code{numResults}: A numeric value indicating the number of results to
#'         return, with a maximum of 100. Default is 20.
#'   \item \code{resultOffset}: A numeric value indicating the page of results to
#'         return, with page size specified in the \code{numResults} argument.
#' }
#' 
#' @param set Optionally, a subset of COLOURlovers colors. Allowed values are
#'   \dQuote{new}, \dQuote{top}, and \dQuote{random}.
#' @param ... A named list of parameters passed to the API request. Allowed
#'   parameters are \code{lover}, \code{hueRange}, \code{briRange},
#'   \code{keywords}, \code{keywordsExact}, \code{orderCol}, \code{sortBy},
#'   \code{numResults}, and \code{resultOffset}. Specifying \code{orderCol}
#'   overrules any argument to \code{set}. See details.
#' @param fmt A format for the API response, one of \dQuote{xml} (the default)
#'   or \dQuote{json}. This has essentially no effect on function behavior.
#'   @return A list of class \dQuote{clcolor}. This should be the same regardless
#'   of the value of \code{fmt}.
#'
#' @export
#'
#' @aliases clcolor clcolors print.clcolor print.clcolors
#'
#' @author Thomas J. Leeper
#' @references \url{http://www.colourlovers.com/api/#colors}
#' 
#' @examples \dontrun{
#' # Get a random color
#' clcolors('random')
#' 
#' # Get a single color
#' clcolor('6B4106')
#' 
#' # Plot a single color
#' clcolor(rgb(0,0,1), fmt = 'json')
#' }
clcolors <- function(set = NULL, ..., fmt = 'xml') {
    # request multiple colors
    if (!is.null(set)) {
        set <- match.arg(set, c('new', 'top', 'random'))
    }
    
    query <- list(...)
    if (length(query) == 0) {
        query <- NULL
    }
    
    if (!is.null(set) && set == 'random') {
        out <- clquery('colors', set, query = query, fmt = fmt)[[1]]
        if (!is.null(query)) {
            warning("query parameters ignored for 'random' colors")
        }
        class(out) <- c('clcolor', class(out))
        return(out)
    } else {
        query <- query[!sapply(query, is.null)]
        allowed <- c('lover','hueOption','briRange','keywords',
                     'keywordsExact','orderCol','sortBy','numResults',
                     'resultOffset')
        query[which(!names(query) %in% allowed)] <- NULL
        n <- names(query)
        
        if ('hueRange' %in% n) {
            if (length(query$hueRange) != 2)
                stop('hueRange must be a two-element numeric vector')
            if (query$hueRange[1] < 1 | query$hueRange[1] > 358)
                stop('hueRange lower bound must be be 0 < bound < 359')
            if (query$hueRange[2] < 1 | query$hueRange[2] > 358)
                stop('hueRange upper bound must be be 0 < bound < 359')
            query$hueRange <- paste(query$hueRange, sep = ',')
        }
        if ('briRange' %in% n) {
            if (length(query$briRange) != 2)
                stop('briRange must be a two-element numeric vector')
            if (query$briRange[1] < 1 | query$briRange[1] > 88)
                stop('briRange lower bound must be be 0 < bound < 99')
            if (query$briRange[2] < 1 | query$briRange[2] > 98)
                stop('briRange upper bound must be be 0 < bound < 99')
            query$briRange <- paste(query$briRange, sep = ',')
        }
        if ('keywords' %in% n) {
            query$keywords <- gsub(' ', '+', query$keywords)
        }
        if ('keywordExact' %in% n) {
            if (query$keywordExact == TRUE)
                query$keywordExact <- 1
            if (query$keywordExact == FALSE)
                query$keywordExact <- 0
            if (!query$keywordExact %in% 0:1) {
                warning('keywordExact must be 0 (FALSE) | 1 (TRUE); 0 used by default')
                query$keywordExact <- 0
            }
        }
        if ('orderCol' %in% n) {
            ord <- c('dateCreated', 'score', 'name', 'numVotes', 'numViews')
            if (!query$orderCol %in% ord) {
                query$orderCol <- NULL
                warning("orderCol not recognized")
            }
        }
        if ('sortBy' %in% n) {
            if (!query$sortBy %in% c('ASC', 'DSC')) {
                query$sortBy <- NULL
                warning("sortBy not recognized")
            }
        }
        if ('numResults' %in% n) {
            if (query$numResults > 100 | query$numResults < 1)
                query$numResults <- 20
        }
        if ('resultOffset' %in% n) {
            if (query$resultOffset < 1)
                query$resultOffset <- 1
        }
        
        out <- clquery('colors', set, query = query, fmt = fmt)
    }
    
    class(out) <- c('clcolors', class(out))
    
    for (i in 1:length(out)) {
        class(out[[i]]) <- c('clcolor', class(out))
    }
    
    return(out)
}

#' @rdname clcolors
#' @param hex The six-character hexidemical representation of a single color.
#' @export
clcolor <- function(hex, fmt = 'xml') {
    # request a single color
    out <- clquery('color', substring(gsub('#', '', hex), 1, 6), fmt = fmt)[[1]]
    class(out) <- c('clcolor', class(out))
    return(out)
}

#' @export
print.clcolor <- function(x, ...) {
    cat('Pattern ID:     ', x$id, '\n')
    cat('Title:          ', x$title, '\n')
    #cat('Description:    ', x$description,'\n')
    cat('Created by user:', x$userName, '\n')
    cat('Date created:   ', x$dateCreated, '\n')
    cat('Views:          ', x$numViews, '\n')
    cat('Votes:          ', x$numVotes, '\n')
    cat('Comments:       ', x$numComments, '\n')
    cat('Hearts:         ', x$numHearts, '\n')
    cat('Rank:           ', x$rank, '\n')
    cat('URL:            ', x$url, '\n')
    cat('Image URL:      ', x$imageURL, '\n')
    cat('Colors:         ', paste('#', x$hex, sep = ''), '\n')
    cat('\n')
    invisible(x)
}

#' @export
print.clcolors <- function(x,...) sapply(x, print)
