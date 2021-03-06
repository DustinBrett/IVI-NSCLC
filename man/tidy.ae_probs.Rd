% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adverse-events.R
\name{tidy.ae_probs}
\alias{tidy.ae_probs}
\title{Tidy adverse event data}
\usage{
\method{tidy}{ae_probs}(object, ae_lookup = iviNSCLC::adverse_events, ...)
}
\arguments{
\item{object}{An "ae_probs" object as returned by \code{\link{ae_probs}}.}

\item{ae_lookup}{A \code{data.rame} or \code{data.table} in the same format
as \code{\link{adverse_events}} used to lookup long-form adverse event names
(i.e., \code{ae_name}) given values of \code{ae_abb} contained in \code{object}.}

\item{...}{Further arguments passed to or from other methods. Currently unused.}
}
\description{
Create tidy data of adverse event probabilities.
}
\seealso{
\code{\link{ae_probs}}
}
