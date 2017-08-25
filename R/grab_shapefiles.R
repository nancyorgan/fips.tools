#' Download TIGER Shapefiles
#'
#' Downlaod shapefiles for a state based on the state abbreviation.
#' @param state_abbrv The standard two-letter state abbreviation
#' @export
#' @examples
#' MN = grab_shapefiles("MN")
#' Mayo_shapefiles = grab_shapefiles(c("MN", "WI"))
#' plot(Mayo_shapefiles) # Be careful, this is slow!


grab_shapefiles = function(state_abbrv){
  if(state_abbrv == "everything"){
    state_abbrv = as.vector(fipsdf$abbrv)
  }
  state_data = list()
  state_number = NULL
  for(i in 1:length(unique(state_abbrv))){
    state_number[i] = fipsdf$code[fipsdf$abbrv == state_abbrv[i]]
    temp.dir = tempdir()
    temp.file = tempfile()
    download.file(url = paste0("https://www2.census.gov/geo/tiger/TIGER2010/BG/2010/tl_2010_",
                               state_number[i],"_bg10.zip"), destfile = temp.file)
    data = unzip(zipfile = temp.file, exdir = temp.dir)
    state_data[[i]] = readOGR(grep(".shp$", data, value = TRUE))
    unlink(temp.dir)
    unlink(temp.file)
  }
  final = do.call(rbind,c(state_data,list(makeUniqueIDs=TRUE)))
  return(final)
}

this = grab_shapefiles("everything")
