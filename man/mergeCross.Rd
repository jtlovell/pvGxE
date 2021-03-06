% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mergeCross.R
\name{mergeCross}
\alias{mergeCross}
\title{Merge phenotype data with cross}
\usage{
mergeCross(dat, phenos = NULL, verbose = TRUE)
}
\arguments{
\item{dat}{The dataframe containing plant phenotype information. Must be
generated by pvGxE.dataLoad}

\item{phenos}{Character vector indicating the phenotype column names of interest}

\item{verbose}{Logical, should updates be reported?}
}
\description{
\code{mergeCross} Stack cross object (if more than one observation is
supplied per 4-way ID) and add phenotypes.
}

