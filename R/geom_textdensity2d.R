##---------------------------------------------------------------------------##
##                                                                           ##
##  geom_textdensity2d                                                       ##
##                                                                           ##
##  Copyright (C) 2021 - 2022 by Allan Cameron & Teun van den Brand          ##
##                                                                           ##
##  Licensed under the MIT license - see https://mit-license.org             ##
##  or the LICENSE file in the project root directory                        ##
##                                                                           ##
##---------------------------------------------------------------------------##

#' Produce labelled contour lines of 2D density in  \pkg{ggplot2}
#'
#' @description Contour lines representing 2D density are available already in
#'   \pkg{ggplot2}, but the native [`geom_density_2d`][ggplot2::geom_density_2d]
#'   does not allow the lines to be labelled with the level of each contour.
#'   `geom_textdensity2d` adds this ability.
#'
#' @eval rd_dots(geom_textdensity2d)
#' @inheritParams geom_textpath
#' @inheritParams ggplot2::stat_density_2d
#'
#' @eval rd_aesthetics("geom", "textdensity2d")
#' @return A `Layer` ggproto object that can be added to a plot.
#' @include geom_textpath.R
#' @include utils.R
#' @export
#' @md
#' @seealso Other [geom layers][sibling_layers] that place text on paths.
#'
#' @examples
#' set.seed(1)
#'
#' df  <- data.frame(x = rnorm(100), y = rnorm(100))
#'
#' ggplot(df, aes(x, y)) +
#'   geom_textdensity2d() +
#'   theme_classic()

geom_textdensity2d <- function(
  mapping     = NULL,
  data        = NULL,
  stat        = "density_2d",
  position    = "identity",
  ...,
  contour_var = "density",
  n           = 100,
  h           = NULL,
  adjust      = c(1, 1),
  lineend     = "butt",
  linejoin    = "round",
  linemitre   = 10,
  na.rm       = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {

  layer(
    data        = data,
    mapping     = mapping,
    stat        = stat,
    geom        = GeomTextdensity2d,
    position    = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params      = set_params(
                    lineend     = lineend,
                    linejoin    = linejoin,
                    linemitre   = linemitre,
                    contour     = TRUE,
                    contour_var = contour_var,
                    na.rm       = na.rm,
                    n           = n,
                    h           = h,
                    adjust      = adjust,
                    ...
                  )
  )
}


#' @rdname geom_textdensity2d
#' @inheritParams geom_textdensity2d
#' @inheritParams geom_labelpath
#' @export

geom_labeldensity2d <- function(
  mapping       = NULL,
  data          = NULL,
  stat          = "density_2d",
  position      = "identity",
  na.rm         = FALSE,
  show.legend   = NA,
  inherit.aes   = TRUE,
  ...,
  contour_var   = "density",
  n             = 100,
  h             = NULL,
  adjust        = c(1, 1),
  lineend       = "butt",
  linejoin      = "round",
  linemitre     = 10,
  label.padding = unit(0.25, "lines"),
  label.r       = unit(0.15, "lines"),
  arrow         = NULL
) {

  layer(
    geom        = GeomLabeldensity2d,
    mapping     = mapping,
    data        = data,
    stat        = stat,
    position    = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params      = set_params(
                    na.rm         = na.rm,
                    lineend       = lineend,
                    linejoin      = linejoin,
                    linemitre     = linemitre,
                    contour       = TRUE,
                    contour_var   = contour_var,
                    na.rm         = na.rm,
                    n             = n,
                    h             = h,
                    adjust        = adjust,
                    label.padding = label.padding,
                    label.r       = label.r,
                    arrow         = arrow,
                    ...
                  )
  )
}


#' @rdname GeomTextpath
#' @format NULL
#' @usage NULL
#' @export
#' @include geom_textpath.R

GeomTextdensity2d <- ggproto("GeomTextdensity2d", GeomTextpath,

  required_aes = c("x", "y"),

  setup_data   = function(data, params) {
    data$label <- as.character(data$level)
    data
  }
)


#' @rdname GeomTextpath
#' @format NULL
#' @usage NULL
#' @export
#' @include geom_textpath.R

GeomLabeldensity2d <- ggproto("GeomLabeldensity2d", GeomLabelpath,

  required_aes = c("x", "y"),

  setup_data   = function(data, params) {
    data$label <- as.character(data$level)
    data
  }
)
