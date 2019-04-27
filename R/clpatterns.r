#' Retrieve pattern or patterns
#' 
#' Retrieve a pattern or set of patterns from the COLOURlovers API.
#' 
#' Retrieve details about a pattern or set of patterns.
#' 
#' Specifying named arguments to \code{...} allows the user to request a
#' specific response, as follows:
#' 
#' \itemize{
#'   \item \code{lover}: A character string containing a COLOURlovers username.
#'   \item \code{hueOption}: A character vector containing one or more named hues to
#'         search by. Allowed values are: \dQuote{red}, \dQuote{orange},
#'         \dQuote{yellow}, \dQuote{green}, \dQuote{aqua}, \dQuote{blue},
#'         \dQuote{violet}, \dQuote{fuchsia}. Any other values other than these named
#'         colors will be ignored.
#'   \item \code{hex}: A character vector containing up to five colors specified as
#'         hexidecimal representation (with or without a leading hash symbol). Excess
#'         colors will be ignored.
#'   \item \code{hex_logic}: A character value containing either \dQuote{AND} (the
#'         default) or \dQuote{OR}, for whether the values in \code{hex} should be
#'         searched for with a boolean AND versus OR logic. Specifying \dQuote{AND}
#'         will only return palettes with all requested colors.
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
#' @param set Optionally, a subset of COLOURlovers patterns. Allowed values are
#'   \dQuote{new}, \dQuote{top}, and \dQuote{random}.
#' @param ... A named list of parameters passed to the API request. Allowed
#'   parameters are \code{lover}, \code{hueOption}, \code{hex}, \code{hex_logic},
#'   \code{keywords}, \code{keywordsExact}, \code{orderCol}, \code{sortBy},
#'   \code{numResults}, and \code{resultOffset}. Specifying \code{orderCol}
#'   overrules any argument to \code{set}. See details.
#' @param fmt A format for the API response, one of \dQuote{xml} (the default)
#'   or \dQuote{json}. This has essentially no effect on function behavior.
#' 
#' @return A list of class \dQuote{clpattern}. This should be the same
#' regardless of the value of \code{fmt}.
#' 
#' @export
#' 
#' @aliases clpattern clpatterns print.clpattern print.clpatterns
#' 
#' @author Thomas J. Leeper
#' @references \url{http://www.colourlovers.com/api/#patterns}
#' 
#' @examples
#' e <- function(e) NULL # function for tryCatch to fail in examples
#' 
#' # get a random pattern
#' tryCatch( clpatterns('random'), error = e)
#' 
#' # plot at a single pattern
#' p <- tryCatch( clpattern('1451', fmt='json'), error = e)
#' if(!is.null(p)) plot(p)
clpatterns <- function(set = NULL, ..., fmt='xml'){
    # request multiple patterns
    if(!is.null(set))
        set <- match.arg(set, c('new', 'top', 'random'))
    query <- list(...)
    if(length(query)==0)
        query <- NULL
    if(!is.null(set) && set=='random') {
        out <- clquery('patterns', set, query=NULL, fmt=fmt)[[1]]
        if(!is.null(query))
            warning("query parameters ignored for 'random' patterns")
        class(out) <- c('clpattern',class(out))
            return(out)
    } else {
        query <- query[!sapply(query, is.null)]
        allowed <- c('lover','hueOption','hex','hex_logic','keywords',
                     'keywordsExact','orderCol','sortBy','numResults',
                     'resultOffset')
        query[which(!names(query) %in% allowed)] <- NULL
        n <- names(query)
        if('hueOption' %in% n){
            cols <- c('red','orange','yellow','green',
                      'aqua','blue','violet','fuchsia')
            query$hueOption <- query$hueOption[query$hueOption %in% cols]
            query$hueOption <- paste(query$hueOption,sep=',')
        }
        if('hex' %in% n){
            if(length(query$hex)>5){
                warning(paste(length(query$hex),
                        'hex values supplied, only first five used.'))
                query$hex <- query$hex[1:5]
            }
            query$hex <- paste(substring(gsub('#','',query$hex),1,6),sep=',')
        }
        if('hex_logic' %in% n){
            query$hex_logic <- toupper(query$hex_logic)
            if(!query$hex_logic %in% c('AND','OR')){
                warning('hex_logic must be AND | OR; AND used by default')
                query$hex_logic <- 'AND'
            }
        }
        if('keywords' %in% n){
            query$keywords <- gsub(' ', '+', query$keywords)
        }
        if('keywordExact' %in% n){
            if(query$keywordExact==TRUE)
                query$keywordExact <- 1
            if(query$keywordExact==FALSE)
                query$keywordExact <- 0
            if(!query$keywordExact %in% 0:1){
                warning('keywordExact must be 0 (FALSE) | 1 (TRUE); 0 used by default')
                query$keywordExact <- 0
            }
        }
        if('orderCol' %in% n){
            ord <- c('dateCreated','score','name','numVotes','numViews')
            if(!query$orderCol %in% ord){
                query$orderCol <- NULL
                warning("orderCol not recognized")
            }
        }
        if('sortBy' %in% n){
            if(!query$sortBy %in% c('ASC','DSC')){
                query$sortBy <- NULL
                warning("sortBy not recognized")
            }
        }
        if('numResults' %in% n){
            if(query$numResults > 100 | query$numResults < 1)
                query$numResults <- 20
        }
        if('resultOffset' %in% n){
            if(query$resultOffset < 1)
                query$resultOffset <- 1
        }
        out <- clquery('patterns', set, query=query, fmt=fmt)
    }
    class(out) <- c('clpatterns',class(out))
    for(i in 1:length(out))
        class(out[[i]]) <- c('clpattern',class(out))
    return(out)
}

#' @rdname clpatterns
#' @param id The COLOURlovers id (an integer) for a specific pattern.
#' @export
clpattern <- function(id, fmt='xml'){
    # request a single pattern
    out <- clquery('pattern', id, fmt=fmt)[[1]]
    class(out) <- c('clpattern',class(out))
    return(out)
}

#' @export
print.clpattern <- function(x,...) {
    cat('Pattern ID:     ', x$id,'\n')
    cat('Title:          ', x$title,'\n')
    #cat('Description:    ', x$description,'\n')
    cat('Created by user:', x$userName,'\n')
    cat('Date created:   ', x$dateCreated,'\n')
    cat('Views:          ', x$numViews,'\n')
    cat('Votes:          ', x$numVotes,'\n')
    cat('Comments:       ', x$numComments,'\n')
    cat('Hearts:         ', x$numHearts,'\n')
    cat('Rank:           ', x$rank,'\n')
    cat('URL:            ', x$url,'\n')
    cat('Image URL:      ', x$imageURL,'\n')
    cols <- paste(paste('#',unlist(x$colors),sep=''),collapse=', ')
    cat('Colors:         ', cols,'\n')
    cat('\n')
    invisible(x)
}

#' @export
print.clpatterns <- function(x,...) sapply(x, print)
