#' Altair plot concatenation
#'
#' Altair plots can be concatenated using the following operators:
#' `+`, `|`, and `&`
#' @md
#'
#' @param e1 Altair chart object
#' @param e2 Altair chart object
#'
#' @return Compound Altair chart object
#'
#' @rdname altair_concatenation
#' @name altair_concatenation
#' @examples
#'
#' # Examples using the beaver1 and beaver2 body temperature data sets
#' # Layering Charts
#' base <- alt$Chart(beaver1)$encode(
#'   x = alt$X('time'),
#'   y = alt$Y('temp', scale = alt$Scale(zero = FALSE))
#' )
#'
#' scatter_plot <- base$mark_point()
#' line_plot <- base$mark_line()
#'
#' combined_plot <- scatter_plot + line_plot
#'
#' # Horizontal Concatenation
#' base2 <- alt$Chart(beaver2)$encode(
#'   x = alt$X('time'),
#'   y = alt$Y('temp', scale = alt$Scale(zero = FALSE))
#' )
#'
#' scatter_plot2 <- base2$mark_point()
#' line_plot2 <- base2$mark_line()
#'
#' combined_plot <- (scatter_plot + line_plot)$properties(title = "Beaver 1", width = 200)
#' combined_plot2 <- (scatter_plot2 + line_plot2)$properties(title = "Beaver 2", width = 200)
#'
#' hconcat_plot <- combined_plot | combined_plot2
#'
#' # Vertical Concatenation
#'
#' vconcat_plot <- combined_plot & combined_plot2
#'
NULL

is_altair_chart <- function(x) {
  inherits(x, "altair.vegalite.v3.api.TopLevelMixin")
}

#' @rdname altair_concatenation
#' @export
#'
"|.altair.vegalite.v3.api.TopLevelMixin" <- function(e1, e2) {
  if (!is_altair_chart(e2)) {
    stop("Second argument to | is not an Altair Chart")
  }
  alt$hconcat(e1, e2)
}

#' @rdname altair_concatenation
#' @export
#'
"+.altair.vegalite.v3.api.TopLevelMixin" <- function(e1, e2) {
  if (!is_altair_chart(e2)) {
    stop("Second argument to + is not an Altair Chart")
  }
  alt$layer(e1, e2)
}

#' @rdname altair_concatenation
#' @export
#'
"&.altair.vegalite.v3.api.TopLevelMixin" <- function(e1, e2) {
  if (!is_altair_chart(e2)) {
    stop("Second argument to & is not an Altair Chart")
  }
  alt$vconcat(e1, e2)
}


