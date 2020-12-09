library(httptest)
httptest::.mockPaths("../")

# Custom expect_doppelganger() because vidffr struggles to install on M1 Macs
# Code via Lionel Henry
# https://github.com/lionel-/ggstance/commit/eac216f6
expect_doppelganger <- function(title, fig, path = NULL, ...) { 
  testthat::skip_if_not_installed("vdiffr") 
  vdiffr::expect_doppelganger(title, fig, path = path, ...) 
}
