## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dev = "ragg_png"
)

## ----setup--------------------------------------------------------------------
library(ggplot2)
library(geomtextpath)

## ----path_and_text_spiral, fig.show = 'hold'----------------------------------
t <- seq(5, -1, length.out = 1000) * pi
spiral <- data.frame(
  x = sin(t) * 1000:1,
  y = cos(t) * 1000:1
)
rhyme <- paste(
  "Like a circle in a spiral, like a wheel within a wheel,",
  "never ending or beginning on an ever spinning reel"
)

p <- ggplot(spiral, aes(x, y)) +
  coord_equal(xlim = c(-1000, 1000), ylim = c(-1000, 1000))
p + geom_path() + labs(subtitle = "geom_path()")
p + geom_text(
  data  = data.frame(x = 0, y = 0),
  size  = 4, label = rhyme
) + labs(subtitle = "geom_text()")

## ----textpath_spiral----------------------------------------------------------
p + geom_textpath(
  size  = 4, label = rhyme
) + labs(subtitle = "geom_textpath()")

## ----geom_in_stat-------------------------------------------------------------
ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) +
  geom_point(alpha = 0.3) +
  stat_ellipse(
    aes(label = Species),
    geom = "textpath", hjust = 0.25,
  ) +
  theme(legend.position = "none")

## ----stat_in_geom-------------------------------------------------------------
ggplot(data.frame(x = 0)) +
  geom_labelpath(
    stat = "function", 
    fun = ~ 1 / (1 + exp(-.x)),
    label = "Sigmoid function"
  ) +
  xlim(-6, 6)

## ----aspratio,  fig.show = 'hold'---------------------------------------------
p2 <- p + geom_textpath(size = 3, label = rhyme)

p2 + theme(aspect.ratio = 0.5) + labs(subtitle = "aspect.ratio = 0.5")
p2 + theme(aspect.ratio = 2)   + labs(subtitle = "aspect.ratio = 2")

## ----textpathgrob-------------------------------------------------------------
grob <- textpathGrob(label = "My\nlabel", x = c(0.25, 0.75), 
                     y = c(0.25, 0.75), id = c(1, 1))
grob

## ----textmeasurement----------------------------------------------------------
grob$textpath$label[[1]]

## ----grid---------------------------------------------------------------------
grid::grid.newpage()
grid::grid.draw(grob)

