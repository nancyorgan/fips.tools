# Offline FIPS Conversion Tools

### Installation

To install the demogromatics package using R:

```r
install.packages("devtools")
library("devtools")
devtools::install_github("nancyorgan/fips.tools")
library("fips.tools")
```

### About

This package provides tools for:
- Batch-downloading blockgroup-level TIGER shapefiles by state
- Converting coordinates of geocoded addresses to FIPS code 

### Credit

The USPS state abbreviation to FIPS state numeric code comes from the Census Bureau's "FIPS Codes for the States and the District of Columbia" table at www.census.gov/geo/reference/ansi_statetables.html. 

The shapefiles also come www.census.gov/geo/maps-data/data/tiger-line.html. 

### Functions Overview

```r
FIPS_converter(id, lat, long, state_data)
grab_shapefiles(state_abbrv)

```

### Details, details!
The current version of demogromatics supports US Census 2010 FIPS codes. 

Dependencies are R (>= 3.0.2), rgdal, rgeos, sp.
