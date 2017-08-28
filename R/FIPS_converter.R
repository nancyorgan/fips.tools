#' Convert coordinates to FIPS
#'
#' Convert geocoded coordinates to a FIPS code. Can be used for a data set or a single data point.
#' @param id Id to be preserved in the output
#' @param lat Latiutude
#' @param long Longitude
#' @param state_data Shapefiles for the state
#' @export
#' @examples
#' Mayo = grab_shapefiles(c("MN", "WI"))
#' FIPS_converter(id = c("House 1", "House 2", "House 3"),
#'                lat = c(44.079216, 45.8283963, 46.1252037),
#'                long = c(-92.66854, -95.4019813, -95.4569129),
#'                state_data = Mayo)
#'
#'             id         FIPS
#' 1 Some house 1 271090019002
#' 2 Some house 2 270419509001
#' 3 Some house 3 271119615001

FIPS_converter = function(id, lat, long, state_data, dataset = NULL){
  dat = data.frame(id, lat, long)
  rownames(dat) = dat$id
  coordinates(dat) <- ~ long + lat
  proj4string(dat) <- proj4string(state_data)
  final = over(dat, state_data)
  final$id = row.names(final)
  row.names(final) = c(1:length(id))
  final = subset(final, select = c("id", "GEOID10"))
  names(final) = c("id", "FIPS")
  if(is.null(dataset)){
    return(final)
  }
  else{
    return(left_join(dataset, final))
  }
}

