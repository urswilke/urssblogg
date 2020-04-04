library(prismatic)
library(tidyverse)
# from https://www.colourlovers.com/palette/4704008/(-(%EF%BD%B4)-%EF%BC%BC):
palette <- c("#FFFEC1", "#EDA79D", "#E36E39", "#8C6A68", "#015F95", "#FFFEC1", "#EDA79D", "#E36E39")
palette <- c("#FFFEA9", "#EDA74D", "#E36E39", "#8C6A68", "#619F95", "#FFFEC1", "#EDA79D", "#E36E39")
color(palette) %>% plot
palette %>%
  clr_lighten(.5) %>%
  # clr_negate() %>%
  color() %>% as.character() %>% str_sub(end=-3) %>% str_to_lower()
  # plot()

# determine color brightness:
get_brightness <- function(palette) {
  palette %>%
    prismatic::clr_greyscale() %>%
    farver::decode_colour() %>%
    .[,1]
}
sort_colors <- function(palette) {
  tibble(palette) %>%
    mutate(brightness = map_dbl(palette, get_brightness)) %>%
    arrange(-brightness, palette) %>%
    mutate(bright_diff = lead(brightness) - brightness)
    # pull(palette) %>%
    # color()
}
palette %>% unique() %>% sort_colors()

palette %>%
  # unique() %>%
  sort_colors() %>%
  mutate(rank(bright_diff, ties.method = "first"))
# mutate(c(T,
#          ifelse(bright_diff[-c(1, length(bright_diff))] %in% sort(bright_diff[-c(1, length(bright_diff))], decreasing = T)[1:3],
#                 T,
#                 F),
#          T)
#        )
