cllover <- function(user, comments = FALSE, fmt = 'xml'){
    # request a single lover/user
    out <- list(lover=clquery('lover', user, query=list(comments=as.numeric(comments)), fmt=fmt)[[1]])
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
    class(out) <- c('cllover',class(out))
    return(out)
}

print.cllover <- function(x,...) {
    onelover <- function(z){
        cat('Lover username:     ', z$userName[[1]],'\n')
        cat('Registered:         ', z$dateRegistered,'\n')
        cat('Last active:        ', z$dateLastActive,'\n')
        cat('Rating:             ', z$rating,'\n')
        cat('Location:           ', z$location[[1]],'\n')
        cat('Colors:             ', z$numColors,'\n')
        cat('Palettes:           ', z$numPalettes,'\n')
        cat('Patterns:           ', z$numPatterns,'\n')
        cat('Comments made:      ', z$numCommentsMade,'\n')
        cat('Lovers:             ', z$numLovers,'\n')
        cat('Comments on profile:', z$numCommentsOnProfile,'\n')
        cat('URL:                ', z$url[[1]],'\n')
        cat('API URL:            ', z$apiUrl[[1]],'\n')
        cat('\n')
    }
    for(i in which(names(x)=='lover'))
        onelover(x[[i]])
    invisible(x)
}
