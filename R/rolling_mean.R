# Write function for finding rolling means

#' Rolling mean function
#'
#' @param focal_date ®
#' Date to focus function on
#' @param dates 
#' Dates column your running the function over
#' @param conc 
#' Concentration or quantities your finding the mean of
#' @param win_size_wks 
#' Size of window to find mean over
#'
#' @returns
#' Result in form of new column with means
#' @export
#'
#' @examples
rolling_mean <- function(focal_date, dates, conc, win_size_wks) {
  # Which dates are in the window?
  is_in_window <- (dates > focal_date - (win_size_wks / 2) * 7) &
    (dates < focal_date + (win_size_wks / 2) * 7)
  # Find the associated concentrations
  window_conc <- conc[is_in_window]
  # Calculate the mean
  result <- mean(window_conc, na.rm = TRUE)
  
  return(result)
}
