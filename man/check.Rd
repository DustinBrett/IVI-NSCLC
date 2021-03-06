% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{check}
\alias{check}
\title{Input validation for class objects}
\usage{
check(object, ...)
}
\arguments{
\item{object}{object to check.}

\item{...}{Further arguments passed to or from other methods. Currently unused.}
}
\value{
If validation is successful, returns the object in question; otherwise,
informs the user that an error has occurred.
}
\description{
\code{check} is a generic function for validating the inputs of class objects.
}
\keyword{internal}
