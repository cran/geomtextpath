## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dev = "png"
)

## ----setup--------------------------------------------------------------------
library(ggplot2)
library(geomtextpath)

## -----------------------------------------------------------------------------
t <- seq(5, -1, length.out = 1000) * pi
spiral <- data.frame(
  x = sin(t) * 1000:1,
  y = cos(t) * 1000:1
)
rhyme <- paste(
  "Like a circle in a spiral, like a wheel within a wheel,",
  "never ending or beginning on an ever spinning reel"
)

p <- ggplot(spiral, aes(x, y, label = rhyme)) +
  coord_equal(xlim = c(-1000, 1000), ylim = c(-1000, 1000))
p + geom_textpath(size  = 4)

## -----------------------------------------------------------------------------
p + geom_textpath(size  = 4, textcolour = "#E41A1C", linecolour = "#377eb8")

## -----------------------------------------------------------------------------
p + geom_labelpath(size  = 4, textcolour = "#E41A1C", boxcolour = "#377eb8",
                   fill = "#ffff99", boxlinetype = "dotted", linewidth = 1,
                   boxlinewidth = 0.5)

## ----hjust_explain, fig.show = 'hold'-----------------------------------------
p + geom_textpath(size  = 4, hjust = 0) +
  labs(subtitle = "hjust = 0")
p + geom_textpath(size  = 4, hjust = 1) +
  labs(subtitle = "hjust = 1")

## ----hjust_explain2, fig.width=6, fig.height=4--------------------------------
i <- ggplot(iris, aes(x = Sepal.Length, colour = Species, label = Species)) +
  ylim(c(0, 1.3))

i + geom_textdensity(size = 5, vjust = -0.2, hjust = "ymax") +
   labs(subtitle = "hjust = \"ymax\"")

## ----hjust_explain3, fig.width=6, fig.height=4--------------------------------
i + geom_textdensity(size = 5, vjust = -0.2, hjust = "auto") +
  labs(subtitle = "hjust = 'auto'")

## ----halign_explain, fig.show = 'hold'----------------------------------------
# Separate text with newline
rhyme_lines <- paste(
  "Like a circle in a spiral, like a wheel within a wheel,",
  "never ending or beginning on an ever spinning reel", sep = "\n"
)
p + geom_textpath(size  = 4, label = rhyme_lines, halign = "left") +
  labs(subtitle = "halign = 'left'")
p + geom_textpath(size  = 4, label = rhyme_lines, halign = "right") +
  labs(subtitle = "halign = 'right'")

## ----vjust_explain, fig.show = 'hold'-----------------------------------------
p + geom_textpath(size  = 4, vjust = 0) +
  labs(subtitle = "vjust = 0")
p + geom_textpath(size  = 4, vjust = 1) +
  labs(subtitle = "vjust = 1")

## ----path_cutting_1, fig.show = 'hold'----------------------------------------
p + geom_textpath(size  = 4, vjust = 1.5) +
  labs(subtitle = "vjust = 1.5, default gap")
p + geom_textpath(size  = 4, vjust = 1.5, gap = TRUE) +
  labs(subtitle = "vjust = 1.5, gap = TRUE")

## ----path_cutting_2, fig.show = 'hold'----------------------------------------
p + geom_textpath(size  = 4, vjust = 0.5) +
  labs(subtitle = "default gap")
p + geom_textpath(size  = 4, vjust = 0.5, gap = FALSE) +
  labs(subtitle = "gap = FALSE")

## ----padding, fig.show = 'hold'-----------------------------------------------
p + geom_textpath(size  = 4, padding = unit(-0.5, "cm")) +
  labs(subtitle = "padding = -0.5 cm")
p + geom_textpath(size  = 4, padding = unit(12, "pt")) +
  labs(subtitle = "padding = 12 pt")

## ----offset1------------------------------------------------------------------
p + geom_textpath(size  = 4, offset = unit(1, "mm"), gap = FALSE) +
  labs(subtitle = "offset = 1 mm")

## ----offset2------------------------------------------------------------------
size <- 4
underline <- systemfonts::font_info(family = "fallback", 
                                    size = size * .pt)$underline_pos
underline <- unit(-underline, "pt")

# We need to prevent the automatic flipping of the text in this case
p + geom_textpath(size = size, offset = underline, gap = FALSE, upright = FALSE) +
  labs(subtitle = "offset as underline")

## ----spacing, fig.show = 'hold'-----------------------------------------------
p + geom_textpath(size = 4, spacing = 100) +
  labs(subtitle = "spacing = 100")
p + geom_textpath(size = 4, spacing = -100) +
  labs(subtitle = "spacing = -100")

## ----upright, fig.show = 'hold'-----------------------------------------------
df <- data.frame(
  x   = cos(seq(0, 2 * pi, length.out = 11)[1:10]),
  y   = sin(seq(0, 2 * pi, length.out = 11)[1:10]),
  lab = rep(c("Denial", "Anger", "Bargaining", "Depression", "Acceptance"),
            each = 2)
)

plot <- ggplot(df, aes(x, y, label = lab)) +
  coord_equal()

plot + geom_textpath(upright = FALSE) + 
  labs(subtitle = "upright = FALSE")

plot + geom_textpath(upright = TRUE) + 
  labs(subtitle = "upright = TRUE (default)")

## ----smoothing, warning=FALSE, fig.show = 'hold'------------------------------
eco <- ggplot(economics, aes(date, unemploy))
  
eco + 
  geom_textpath(label = "Unemployment", 
                text_smoothing = 0, vjust = -0.5, hjust = 0.25) +
  labs(subtitle = "text_smoothing = 0 (default)")

eco + 
  geom_textpath(label = "Unemployment", 
                text_smoothing = 30, vjust = -0.5, hjust = 0.25) +
  labs(subtitle = "text_smoothing = 30")

## ----remove_long, warning=FALSE, fig.show = 'hold'----------------------------
df <- data.frame(
  x = c(-0.5, 0.5, -1, 2),
  y = c(0.5,  1.5, -1, 2),
  lab = rep(c("This label is too long", "This label fits"), each = 2)
)

plot <- ggplot(df, aes(x, y, label = lab)) +
  coord_equal()

plot + geom_textpath(size = 6, remove_long = FALSE) +
  labs(subtitle = "remove_long = FALSE (default)")

plot + geom_textpath(size = 6, remove_long = TRUE) +
  labs(subtitle = "remove_long = TRUE")

## ----richtext, fig.show = 'hold'----------------------------------------------
x <- seq(-3, 3, length.out = 100)
df <- data.frame(x = x, y = -x^2)

labels <- "With <b style='font-family:mono;color:red'>rich = "
labels <- paste0(labels, c("FALSE</b>", "TRUE</b>"))

plot <- ggplot(df, aes(x, y)) 

plot + geom_textpath(label = labels[1], rich = FALSE)
plot + geom_textpath(label = labels[2], rich = TRUE)

## ----scales_discrete, fig.width=6, fig.height=4-------------------------------

i <- ggplot(iris, aes(x = Sepal.Length, colour = Species, label = Species)) +
       geom_textdensity(aes(vjust = Species, hjust = Species), size = 5) +
       ylim(c(0, 1.3))

i + scale_vjust_discrete(range = c(-0.5, 0.5)) + 
    scale_hjust_discrete()

## ----scales_manual, fig.width=6, fig.height=4---------------------------------

i + scale_vjust_manual(values = c(0.5, 0, -0.5)) + 
    scale_hjust_manual(values = c(0.1, 0.45, 0.8))

