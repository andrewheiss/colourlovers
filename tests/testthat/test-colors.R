context("Colours")

with_mock_api({
  test_that("Colors work", {
    r <- clcolors('random')
    expect_true(inherits(r, "clcolor"), label = "clcolors class correct")
    expect_true(is.list(swatch(r)), label = "clcolors swatch is list")
    expect_true(length(swatch(r)[[1]]) == 1, label = "clcolors swatch has one color")
    
    c1 <- clcolor('6B4106')
    expect_true(inherits(c1, "clcolor"), label = "clcolor class correct")
    expect_true(is.list(swatch(c1)), label = "clcolors swatch is list")
    
    c2 <- clcolor(hsv(.5,.5,.5))
    expect_true(inherits(c2, "clcolor"), label = "clcolor parsing works")
  })
})

with_mock_api({
  test_that("Colors work with JSON", {
    r <- clcolors('random', fmt = "json")
    expect_true(inherits(r, "clcolor"), label = "clcolors class correct")
    expect_true(is.list(swatch(r)), label = "clcolors swatch is list")
    expect_true(length(swatch(r)[[1]]) == 1, label = "clcolors swatch has one color")
    
    c1 <- clcolor('6B4106', fmt = "json")
    expect_true(inherits(c1, "clcolor"), label = "clcolor class correct")
    expect_true(is.list(swatch(c1)), label = "clcolors swatch is list")
    
    c2 <- clcolor(hsv(.5,.5,.5), fmt = "json")
    expect_true(inherits(c2, "clcolor"), label = "clcolor parsing works")
  })
})

with_mock_api({
  test_that("Extra parameters for random colors are caught", {
    expect_success(expect_warning(clcolors(set = "random", lover = "junk"),
                                  label = "no parameters allowed when getting random color"))
  })
})

