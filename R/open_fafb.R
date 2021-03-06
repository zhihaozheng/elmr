#' Open FAFB CATMAID in browser at a given XYZ location
#'
#' @details Note that if object \code{x} contains exactly one point then CATMAID
#'   will be opened immediately at that location, whereas if there is more than
#'   1 point, the function will stop and wait for the user to make an
#'   interactive selection in a \code{rgl} window.
#' @param x A numeric vector or any object compatible with
#'   \code{\link[nat]{xyzmatrix}} (see details)
#' @param s A selection function of the type returned by
#'   \code{\link[rgl]{select3d}}
#' @param mirror Whether to mirror the point to the opposite side of the brain
#' @param sample The template brain space associated with the coordinates in
#'   \code{x}
#' @param open Whether to open the url in the browser or simply return it.
#'   Defaults to \code{TRUE} when R is running in interactive mode.
#' @param zoom The CATMAID zoom factor (defaults to 1)
#' @param active_skeleton_id,active_node_id Set highlighted skeleton and node in
#'   CATMAID.
#' @param ... Additional arguments to be added to URL.
#' @export
#' @importFrom utils browseURL
#' @seealso xform_brain
#' @examples
#' open_fafb(c(316, 143, 26), sample=JFRC2013, open=FALSE)
#' library(nat)
#' \dontrun{
#' open3d()
#' plot3d(kcs20)
#' # waits for used to draw a selection rectangle
#' open_fafb(kcs20, sample=FCWB)
#' # same but mirrors selected points to opposite hemisphere
#' open_fafb(kcs20, sample=FCWB, mirror=TRUE)
#' }
open_fafb<-function(x, s=rgl::select3d(), mirror=FALSE, sample=elmr::FAFB13,
                    zoom=1, open=interactive(),
                    active_skeleton_id=NULL, active_node_id=NULL, ...) {
  if(is.vector(x, mode='numeric') && length(x)==3 ){
    xyz=matrix(x, ncol=3)
  } else {
    xyz=xyzmatrix(x)
    if(nrow(xyz)>1){
      # calculate centroid of points inside selection
      xyz=colMeans(xyz[s(xyz),, drop=F])
      xyz=matrix(xyz, ncol=3)
    }
  }
  if(mirror)
    xyz=mirror_brain(xyz, sample)

  csample=as.character(sample)
  if(substr(csample, 1, 4)=="FAFB"){
    fafb.version=substr(csample,5,nchar(csample))
  } else {
    xyz=xform_brain(xyz, sample = sample, reference = elmr::FAFB13)
    fafb.version="13"
  }


  xyzi=as.integer(xyz)
  url=sprintf("https://neuropil.janelia.org/tracing/fafb/v%s/?pid=1&zp=%d&yp=%d&xp=%d&tool=tracingtool&sid0=5&s0=%f",
              fafb.version,xyzi[3], xyzi[2], xyzi[1], zoom)
  apl=pairlist(...)
  apl$active_skeleton_id=active_skeleton_id
  apl$active_node_id=active_node_id
  if(length(apl)){
    # interpret as extra params
    url=paste0(url, "&", paste(names(apl), sep="=", apl, collapse = "&"))
  }

  if(open){
    browseURL(url)
    invisible(url)
  } else {
    url
  }
}
