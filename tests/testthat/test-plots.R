context("Plotting")

# Run validate_cases() to generate reference figures
with_mock_api({
  test_that("Color plots work", {
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

# Plot single palette
# Plot multiple palettes

# Plot single pattern
# Plot multiple patterns
