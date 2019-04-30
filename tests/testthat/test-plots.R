context("Plotting")

# Run validate_cases() to generate reference figures

with_mock_api({
  test_that("Color plots work", {
    testthat::skip_on_cran()

    disp_single_color <- function() plot(clcolor(rgb(0, 0, 1)))
    vdiffr::expect_doppelganger("single color plot", disp_single_color)
    
    disp_multiple_colors <- function() plot(clcolors(set = "top", 
                                                     lover = "Skyblue2u", 
                                                     numResults = 1), 
                                            ask = FALSE)
    vdiffr::expect_doppelganger("multiple color plots", disp_multiple_colors)
    
    disp_pie_color <- function()  plot(clcolor(rgb(0, 0, 1)), type = "pie")
    vdiffr::expect_doppelganger("single color pie chart", disp_pie_color)
    
    disp_multiple_pie_colors <- function() plot(clcolors(set = "top", 
                                                         lover = "Skyblue2u", 
                                                         numResults = 1), 
                                                ask = FALSE, type = "pie")
    vdiffr::expect_doppelganger("multiple color pie charts", disp_multiple_pie_colors)
  })
})

with_mock_api({
  test_that("Palette plots work", {
    testthat::skip_on_cran()
    
    disp_single_palette <- function() plot(clpalette("4643792"))
    vdiffr::expect_doppelganger("single palette plot", disp_single_palette)
    
    disp_multiple_palettes <- function() plot(clpalettes(set = "top", 
                                                         lover = "Skyblue2u", 
                                                         numResults = 1), 
                                              ask = FALSE)
    vdiffr::expect_doppelganger("multiple palette plots", disp_multiple_palettes)
    
    disp_pie_palette <- function()  plot(clpalette("4643792"), type = "pie")
    vdiffr::expect_doppelganger("single palette pie chart", disp_pie_palette)
    
    disp_multiple_pie_palettes <- function() plot(clpalettes(set = "top", 
                                                             lover = "Skyblue2u", 
                                                             numResults = 1), 
                                                  ask = FALSE, pie = TRUE)
    vdiffr::expect_doppelganger("multiple palette pie charts", disp_multiple_pie_palettes)
    
    disp_small_palette <- function() plot(clpalette("4643793"))
    vdiffr::expect_doppelganger("single small palette plot", disp_small_palette)
  })
})

with_mock_api({
  test_that("Pattern plots work", {
    testthat::skip_on_cran()
    
    disp_single_pattern <- function() plot(clpattern("5794648"))
    vdiffr::expect_doppelganger("single pattern plot", disp_single_pattern)
    
    disp_multiple_patterns <- function() plot(clpatterns(set = "top", 
                                                         lover = "Skyblue2u", 
                                                         numResults = 1), 
                                              ask = FALSE)
    vdiffr::expect_doppelganger("multiple pattern plots", disp_multiple_patterns)
    
    disp_pie_pattern <- function()  plot(clpattern("5794648"), type = "pie")
    vdiffr::expect_doppelganger("single pattern pie chart", disp_pie_pattern)
    
    disp_multiple_pie_patterns <- function() plot(clpatterns(set = "top", 
                                                             lover = "Skyblue2u", 
                                                             numResults = 1), 
                                                  ask = FALSE, pie = TRUE)
    vdiffr::expect_doppelganger("multiple pattern pie charts", disp_multiple_pie_patterns)
  })
})
