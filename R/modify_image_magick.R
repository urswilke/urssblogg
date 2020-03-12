library(magick)
bild <- image_read('content/authors/admin/test_bild.jpg')
bild <-
  bild %>%
  image_resize(geometry_size_pixels(300)) %>%
  image_oilpaint(radius = .0001) %>%
  image_fuzzycmeans() #%>%

img_eq <- bild %>% image_equalize()

img_raster <- raster::as.raster(img_eq)
img_colors <- img_raster%>% as.vector() %>%  unique()

palette <- c("#FFFEA9", "#EDA74D", "#E36E39", "#8C6A68", "#619F95", "#FFFEC1", "#EDA79D", "#E36E39")
colors <- palette %>%
  prismatic::clr_lighten(.1) %>% as.character() %>% str_sub(end=-3)

color_map <- img_colors %>% set_names(colors[1:length(img_colors)])
img_replace <-
  raster::match(img_raster,
                color_map) %>%
  {names(color_map[.])} %>%
  matrix(., ncol = 400, nrow = 300) %>%
  t() %>% raster::as.raster()

img_replace %>% plot()

image_write(img_replace %>% image_read(), 'content/authors/admin/avatar.jpg')
