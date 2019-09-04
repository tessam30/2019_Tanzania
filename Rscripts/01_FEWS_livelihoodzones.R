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
