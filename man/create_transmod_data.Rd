% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/transmod.R
\name{create_transmod_data}
\alias{create_transmod_data}
\title{Data for transition model}
\usage{
create_transmod_data(struct, trans_mat, patients)
}
\arguments{
\item{struct}{A \code{\link{model_structure}} object.}

\item{trans_mat}{A transition matrix as returned by \code{\link{create_trans_mat}}.}

\item{patients}{A data table returned from \code{\link{create_patients}}.}
}
\value{
An object of class "expanded_hesim_data" from the 
\href{https://innovationvalueinitiative.github.io/hesim/}{hesim} package, which
is a data table with one observation for each treatment strategy 
(i.e., treatment sequence), patient, and transition combination. The survival
distribution is stored as a "dist" attribute.
}
\description{
Create data used to simulate health state transitions with a 
continuous time state transition model (CTSTM) given the parameters from the
multi-state NMA (i.e., \code{\link{params_mstate_nma}}). The included variables are 
a function of the selected treatment sequences and the modeled patients.
}
\examples{
## Treatment sequences
txseq1 <- txseq(first = "erlotinib",
                second = c("osimertinib", "PBDC"),
                second_plus = c("PBDC + bevacizumab", "PBDC + bevacizumab"))
txseq2 <- txseq(first = "gefitinib",
                second = c("osimertinib", "PBDC"),
                second_plus = c("PBDC + bevacizumab", "PBDC + bevacizumab"))
txseqs <- txseq_list(seq1 = txseq1, seq2 = txseq2)

# Patient population
pats <- create_patients(n = 2)

## Model structure
struct <- model_structure(txseqs, dist = "weibull")
tmat <- create_trans_mat(struct)

## Data
transmod_data <- create_transmod_data(struct, tmat, pats)
head(transmod_data)
}
\seealso{
\code{\link{create_transmod_params}}
}
