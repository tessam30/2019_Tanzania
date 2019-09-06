# Purpose: Check out what's in the FEWS Net data
# By: Tim Essam, GeoCenter
# Date: 2019_09_04
# Notes


# Load data from shapefiles -----------------------------------------------
lz_shp <- st_read(file.path(datapath, "TZ_LHZ_2009.shp"))

lz_shp %>% 
  ggplot() +
  geom_sf(aes(fill = LZNAMEEN), colour = "white", size = 0.9, alpha = 0.75) +
  theme(legend.position = "none")

fews_shp <- st_read(file.path(datapath, "TZ_Admin2C_2009.3.shp"))

fews_shp %>% 
  ggplot() +
  geom_sf(aes(fill = ADMIN2), colour = "white", size = 0.9, alpha = 0.75) +
  theme(legend.position = "none")

# Scan contents of each shapefile
map(list(fews_shp, lz_shp), str)

# Shapefile path
shape_path <- file.path(datapath, "gadm36_TZA_shp")
(shape_list <- list.files(shape_path, pattern = "\\.shp$"))


shape_list %>% 
  map(function(x) st_read(file.path(shape_path, x)))



# One approach
tz_shps <- tibble(filename = shape_list) %>% # create a data frame holding the file names
  mutate(file_contents = map(filename,          # read files into
                             ~ st_read(file.path(shape_path, .))) # a new data column
  ) 


#Another approach using base R and dividing each dataset into a list
temp = list.files(pattern="*.csv")

list2env(
  lapply(setNames(shape_list, make.names(gsub("*.shp$", "", shape_list))), 
         st_read, envir = .GlobalEnv)
  )


shape_list %>% 
  map(function(sheet) {
    assign(x = sheet,
           value = st_read(path = shape_path, dsn = sheet),
           envir = .GlobalEnv)
  })
