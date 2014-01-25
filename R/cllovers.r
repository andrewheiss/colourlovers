cllover <- function(user, comments = FALSE, fmt = 'xml'){
    # request a single lover/user
    out <- list(lover=clquery('lover', user, query=list(comments=as.numeric(comments)), fmt=fmt)[[1]])[[1]]
    class(out) <- c('cllover',class(out))
    return(out)
}

cllovers <- function(set = NULL, ..., fmt = 'xml'){
    # request multiple lovers
    if(!is.null(set) && !set %in% c('new', 'top'))
        stop("type must be 'new' or 'top'")
    query <- list(...)
    query <- query[!sapply(query, is.null)]
    query <- query[-which(names(query)=='')]
    allowed <- c('orderCol','sortBy','numResults','resultOffset')
    query[which(!names(query) %in% allowed)] <- NULL
    n <- names(query)
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
    
    out <- clquery('lovers', set, query=NULL, fmt=fmt)
    names(out) <- rep('lover',length(out))
    class(out) <- c('cllovers',class(out))
    for(i in 1:length(out))
        class(out[[i]]) <- c('cllover',class(out))
    return(out)
}

print.cllover <- function(x,...) {
    cat('Lover username:     ', x$userName[[1]],'\n')
    cat('Registered:         ', x$dateRegistered,'\n')
    cat('Last active:        ', x$dateLastActive,'\n')
    cat('Rating:             ', x$rating,'\n')
    cat('Location:           ', x$location[[1]],'\n')
    cat('Colors:             ', x$numColors,'\n')
    cat('Palettes:           ', x$numPalettes,'\n')
    cat('Patterns:           ', x$numPatterns,'\n')
    cat('Comments made:      ', x$numCommentsMade,'\n')
    cat('Lovers:             ', x$numLovers,'\n')
    cat('Comments on profile:', x$numCommentsOnProfile,'\n')
    cat('URL:                ', x$url[[1]],'\n')
    cat('API URL:            ', x$apiUrl[[1]],'\n')
    cat('\n')
    invisible(x)
}

print.cllovers <- function(x,...) sapply(x, print)
