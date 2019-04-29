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

with_mock_api({
  test_that("Hue range works", {
    expect_success(expect_error(clcolors(set = "new", hueRange = c(5, 3, 2)), 
                                label = "more than three hue bounds breaks"))
    expect_success(expect_error(clcolors(set = "new", hueRange = 3),
                                label = "one hue bound breaks"))
    expect_success(expect_error(clcolors(set = "new", hueRange = c(-5, 50)),
                                label = "negative lower hue bound breaks"))
    expect_success(expect_error(clcolors(set = "new", hueRange = c(20, 500)),
                                label = "high upper hue bound breaks"))
    
    c_hues <- clcolors(set = "new", hueRange = c(20, 50), numResults = 5)
    c_hue_values <- sapply(c_hues, function(x) as.numeric(x$hsv$hue))
    expect_true(all(c_hue_values >= 20) && all(c_hue_values <= 50), 
                label = "hue values are within range")
  })
})

with_mock_api({
  test_that("Brightness range works", {
    expect_success(expect_error(clcolors(set = "new", briRange = c(5, 3, 2)), 
                                label = "more than three brightness bounds breaks"))
    expect_success(expect_error(clcolors(set = "new", briRange = 3),
                                label = "one brightness bound breaks"))
    expect_success(expect_error(clcolors(set = "new", briRange = c(-5, 50)),
                                label = "negative lower brightness bound breaks"))
    expect_success(expect_error(clcolors(set = "new", briRange = c(20, 105)),
                                label = "high upper brightness bound breaks"))
    
    c_bri <- clcolors(set = "new", briRange = c(10, 30), numResults = 5)
    c_bri_values <- sapply(c_bri, function(x) as.numeric(x$hsv$value))
    
    expect_true(all(c_bri_values >= 10) && all(c_bri_values <= 30), 
                label = "brightness values are within range")
  })
})
