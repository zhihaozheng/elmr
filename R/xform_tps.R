#' Thin plate spline registrations via nat::xform and friends
#'
#' @description \code{tpsreg} creates an object encapsulating a thin plate spine
#'   transform mapping a paired landmark set.
#' @param refmat,tarmat The reference and target matrices
#' @param ... additional arguments passed to xformpoints.tpsreg
#' @export
#' @seealso \code{\link{reglist}}, \code{\link[nat]{read.landmarks}}
tpsreg<-function(refmat, tarmat, ...){
  structure(list(refmat=refmat, tarmat=tarmat, ...), class='tpsreg')
}

#' @description \code{xformpoints.tpsreg} provides
#' @rdname tpsreg
#' @param reg The \code{tpsreg} registration object
#' @param points The 3D points to transform
#' @param swap Whether to change the direction of registration
#' @export
#' @importFrom nat xformpoints
xformpoints.tpsreg <- function(reg, points, swap=FALSE, ...){
  # FIXME handle swap
  if(swap){
    tmp=reg$refmat
    reg$refmat=reg$tarmat
    reg$tarmat=tmp
  }
  do.call(Morpho::tps3d, c(list(x=points), reg,  list(...)))
}