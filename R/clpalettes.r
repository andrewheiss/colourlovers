clpalette <- function(id, widths = FALSE, fmt='xml'){
    # request a single palette
    out <- clquery('palette', id, query=list(widths=as.numeric(widths)), fmt=fmt)[[1]]
    class(out) <- c('clpalette',class(out))
    return(out)
}

clpalettes <- function(set=NULL, ..., fmt='xml'){
    # request multiple palettes
    if(!is.null(set) && !set %in% c('new', 'top', 'random'))
        stop("set must be 'new', 'top', or 'random'")
    query <- list(...)
    if(length(query)==0)
        query <- NULL
    if(!is.null(set) && set=='random') {
        # no query parameters allowed
        out <- clquery('palettes', set, fmt=fmt)[[1]]
        if(!is.null(query))
            warning("query parameters ignored for 'random' palettes")
        class(out) <- c('clpalette',class(out))
        return(out)
    } else {
        query <- query[!sapply(query, is.null)]
        allowed <- c('lover','hueOption','hex','hex_logic','keywords',
                     'keywordsExact','orderCol','sortBy','numResults',
                     'resultOffset', 'showPaletteWidths')
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
        
        out <- clquery('palettes', set, query=query, fmt=fmt)
    }
    class(out) <- c('clpalettes',class(out))
    for(i in 1:length(out))
        class(out[[i]]) <- c('clpalette',class(out))
    return(out)
}

print.clpalette <- function(x,...) {
    cat('Palette ID:     ', x$id,'\n')
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

print.clpalettes <- function(x,...) sapply(x, print)
