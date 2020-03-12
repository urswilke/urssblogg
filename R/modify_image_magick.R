library(magick)
bild <- image_read('content/authors/admin/test_bild.jpg')
bild <-
  bild %>%
  image_resize(geometry_size_pixels(300)) %>%
  image_oilpaint(radius = .0001) %>%
  image_fuzzycmeans() #%>%
image_write(bild, 'content/authors/admin/avatar.jpg')

#   image_charcoal(sigma = .1)
#   image_quantize(max = 10)
#   image_emboss() %>%
#   image_noise() %>%
# print(tiger)
