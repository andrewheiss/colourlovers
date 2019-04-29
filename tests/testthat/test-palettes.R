context("Palettes")

with_mock_api({
  test_that("Palettes work", {
    top <- clpalettes('top')
    expect_true(inherits(top[[1]], "clpalette"), label = "clpalettes class correct")
    expect_true(is.list(swatch(top)), label = "single clpalettes swatch is list")
    expect_true(is.list(swatch(top[[1]])), label = "multiple clpalettes swatch is list")
    
    p1 <- clpalette('113451')
    expect_true(inherits(p1, "clpalette"), label = "clpalette class correct")
    expect_true(is.list(swatch(p1)), label = "clpallette swatch is list")
  })
})
