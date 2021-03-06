% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/elmr-data.R
\docType{data}
\name{FAFB}
\alias{FAFB}
\alias{FAFB13}
\alias{FAFB12}
\alias{FAFB11}
\title{templatebrain for assembled FAFB full adult female brain EM volume}
\description{
\bold{FAFB} \code{\link[nat.templatebrains]{templatebrain}}
  objects encapsulate the physical dimensions of assembled FAFB serial
  section data. There is a different \code{templatebrain} for each assembly
  version.They are used to define the transformations between FAFB and other
  templates like \code{\link[nat.flybrains]{JFRC2013}} (see
  \code{\link{xform_brain}})

\code{FAFB13} Assembly v13 of FAFB full adult female brain EM
  volume (2016-12-07 - ).

\code{FAFB12} Assembly v12 of FAFB full adult female brain EM
  volume (2016-04-01 to 2016-12-06)

\code{FAFB11} Assembly v11 of FAFB full adult female brain EM
  volume (2016-02-09)
}
\details{
\code{FAFB13} is the default FAFB assembly since 2016-12-07.
}
\examples{
FAFB13
dim(FAFB13)
voxdims(FAFB13)
boundingbox(FAFB13)
}
\seealso{
\code{\link[nat.templatebrains]{templatebrain}},
  \code{\link{xform_brain}}
}
