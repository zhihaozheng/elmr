.onLoad <- function (libname, pkgname) {

  # Define and register a compound registration that maps FAFB12 to JFRC2013
  # first landmarks-based thin plate splines
  elmlm=elmr::elm.landmarks.12[elmr::elm.landmarks.12[,"Use"],]
  # JFRC2013 pixel space
  l0=data.matrix(elmlm[,c("X","Y","Z"), drop=F])
  # FAFB nm space
  l1=data.matrix(elmlm[,c("X1","Y1","Z1"), drop=F])

  # then the scale component
  m <- rgl::identityMatrix()
  diag(m) <- c(nat::voxdims(nat.flybrains::JFRC2013),1)

  JFRC2013_FAFB12 <- nat::reglist(tpsreg(l1, l0), m)
  nat.templatebrains::add_reglist(JFRC2013_FAFB12,
                                  reference = nat.flybrains::JFRC2013,
                                  sample = elmr::FAFB12)

  # Define and register a compound registration that maps FAFB13 to JFRC2013
  elmlm=elmr::elm.landmarks[elmr::elm.landmarks[,"Use"],]
  l0=data.matrix(elmlm[,c("X","Y","Z"), drop=F])
  l1=data.matrix(elmlm[, c("X1", "Y1", "Z1"), drop = F])
  JFRC2013_FAFB13 <-
    nat::reglist(tpsreg(l1, l0), m)
  nat.templatebrains::add_reglist(JFRC2013_FAFB13,
                                  reference = nat.flybrains::JFRC2013,
                                  sample = elmr::FAFB13)

  # Define bridging registration between FAFB12 and FAFB13 based on TEM services
  # API
  s12=diag(c(nat::voxdims(elmr::FAFB12),1))
  s13=diag(c(nat::voxdims(elmr::FAFB13),1))
  FAFB13_FAFB12 <- nat::reglist(solve(s12),
                                function(xyz, ...) fafb_world_mapper(xyz, from="v12", to='v13', ...),
                                s13)
  nat.templatebrains::add_reglist(FAFB13_FAFB12,
                                  reference = elmr::FAFB13,
                                  sample = elmr::FAFB12)

  FAFB12_FAFB13 <- nat::reglist(solve(s13),
                                function(xyz, ...) fafb_world_mapper(xyz, from="v13", to='v12', ...),
                                s12)
  nat.templatebrains::add_reglist(FAFB12_FAFB13,
                                  reference = elmr::FAFB12,
                                  sample = elmr::FAFB13)


}