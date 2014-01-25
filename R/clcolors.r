clcolor <- function(hex, fmt='xml'){
    # request a single color
    out <- clquery('color', substring(gsub('#','',hex),1,6), fmt=fmt)[[1]]
    class(out) <- c('clcolor',class(out))
    return(out)
}


clcolors <- function(set = NULL, ..., fmt='xml'){
    # request multiple colors
    if(!is.null(set) && !set %in% c('new', 'top', 'random'))
        stop("set must be 'new', 'top', or 'random', or NULL")
    query <- list(...)
    if(length(query)==0)
        query <- NULL
    if(!is.null(set) && set=='random'){
        out <- clquery('colors', set, query=query, fmt=fmt)[[1]]
        if(!is.null(query))
            warning("query parameters ignored for 'random' colors")
        class(out) <- c('clcolor',class(out))
            return(out)
    } else {
        query <- query[!sapply(query, is.null)]
        query <- query[-which(names(query)=='')]
        allowed <- c('lover','hueOption','briRange','keywords',
                     'keywordsExact','orderCol','sortBy','numResults',
                     'resultOffset')
        query[which(!names(query) %in% allowed)] <- NULL
        n <- names(query)
        if('hueRange' %in% n){
            if(length(query$hueRange)!=2)
                stop('hueRange must be a two-element numeric vector')
            if(query$hueRange[1] < 1 | query$hueRange[1] > 358)
                stop('hueRange lower bound must be be 0 < bound < 359')
            if(query$hueRange[2] < 1 | query$hueRange[2] > 358)
                stop('hueRange upper bound must be be 0 < bound < 359')
            query$hueRange <- paste(query$hueRange,sep=',')
        }
        if('briRange' %in% n){
            if(length(query$briRange)!=2)
                stop('briRange must be a two-element numeric vector')
            if(query$briRange[1] < 1 | query$briRange[1] > 88)
                stop('briRange lower bound must be be 0 < bound < 99')
            if(query$briRange[2] < 1 | query$briRange[2] > 98)
                stop('briRange upper bound must be be 0 < bound < 99')
            query$briRange <- paste(query$briRange,sep=',')
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
        
        out <- clquery('colors', set, query=query, fmt=fmt)
    }
    class(out) <- c('clcolors',class(out))
    for(i in 1:length(out))
        class(out[[i]]) <- c('clcolor',class(out))
    return(out)
}

print.clcolor <- function(x,...) {
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

print.clcolors <- function(x,...) sapply(x, print)