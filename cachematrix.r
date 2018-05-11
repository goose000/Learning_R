## These functions take a matrix and cache it, allowing the inverse to be 
## calculated once, and recalled thereafter.

## MakeCacheMatrix associates call functions with the passed matrix
## These call functions will can be used separately, or by cacheSolve,
## but are unique to the matrix passed when calling makeCacheMatrix


makeCacheMatrix <- function(x = matrix()) {
        
        i <- NULL
        set <- function(y) {
                x <<- y
                i <<- NULL
        }
        get <- function() x
        setinv <- function(inv) i <<- inv
        getinv <- function() i
        list(set = set, get = get,
             setinv = setinv,
             getinv = getinv)
        
}


## cacheSolve uses the functions defined by makeCacheMatrix to call the inverse
## if it has already been calculated, or calculate and cache it if it has not.

cacheSolve <- function(x, ...) {
        i <- x$getinv()
        if(!is.null(i)) {
                message("getting cached data")
                return(i)
        }
        data <- x$get()
        i <- solve(data, ...)
        x$setinv(i)
        i
        ## Return a matrix that is the inverse of 'x'
}


