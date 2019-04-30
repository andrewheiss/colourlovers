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
    expect_warning(clcolors(set = "random", lover = "junk"),
                   label = "no parameters allowed when getting random color")
  })
})

with_mock_api({
  test_that("Number of results works", {
    expect_equal(length(clcolors(set = "new", numResults = 5)), 5,
                 label = "get specified number")
    expect_equal(length(clcolors(set = "new", numResults = 150)), 20,
                 label = "default to 20 if number is too high")
    expect_equal(length(clcolors(set = "new", numResults = 0)), 20,
                 label = "default to 20 if number is too low")
    
    expect_equal(length(clcolors(set = "new", numResults = 5, resultOffset = 10)), 5,
                 label = "results work with offset")
    expect_equal(length(clcolors(set = "new", numResults = 5, resultOffset = 0)), 5,
                 label = "results work with weird offset")
  })
})

with_mock_api({
  test_that("Sorting and ordering work", {
    expect_warning(clcolors(set = "new", numResults = 1, orderCol = "junk"))
    expect_warning(clcolors(set = "new", numResults = 1, sortBy = "junk"))
  })
})

with_mock_api({
  test_that("Hue range works", {
    expect_error(clcolors(set = "new", hueRange = c(5, 3, 2)), 
                 label = "more than three hue bounds breaks")
    expect_error(clcolors(set = "new", hueRange = 3),
                 label = "one hue bound breaks")
    expect_error(clcolors(set = "new", hueRange = c(-5, 50)),
                 label = "negative lower hue bound breaks")
    expect_error(clcolors(set = "new", hueRange = c(20, 500)),
                 label = "high upper hue bound breaks")
    
    c_hues <- clcolors(set = "new", hueRange = c(20, 50), numResults = 5)
    c_hue_values <- sapply(c_hues, function(x) as.numeric(x$hsv$hue))
    expect_true(all(c_hue_values >= 20) && all(c_hue_values <= 50), 
                label = "hue values are within range")
  })
})

with_mock_api({
  test_that("Brightness range works", {
    expect_error(clcolors(set = "new", briRange = c(5, 3, 2)), 
                 label = "more than three brightness bounds breaks")
    expect_error(clcolors(set = "new", briRange = 3),
                 label = "one brightness bound breaks")
    expect_error(clcolors(set = "new", briRange = c(-5, 50)),
                 label = "negative lower brightness bound breaks")
    expect_error(clcolors(set = "new", briRange = c(20, 105)),
                 label = "high upper brightness bound breaks")
    
    c_bri <- clcolors(set = "new", briRange = c(10, 30), numResults = 5)
    c_bri_values <- sapply(c_bri, function(x) as.numeric(x$hsv$value))
    
    expect_true(all(c_bri_values >= 10) && all(c_bri_values <= 30), 
                label = "brightness values are within range")
  })
})

with_mock_api({
  test_that("Keywords work", {
    c_orange <- clcolors(set = "new", keywords = "orange", numResults = 5)
    expect_equal(length(c_orange), 5, label = "single keyword works")
    
    c_spring <- clcolors(set = "new", keywords = "spring flower", numResults = 5)
    expect_equal(length(c_spring), 5, label = "multiple keywords work")
  })
})

with_mock_api({
  test_that("Keyword exactness works", {
    expect_warning(clcolors(set = "new", keywordExact = 3, numResults = 1),
                   label = "keywordsExact must be 0 or 1 or T/F")
    
    c_exact <- clcolors(set = "new", numResults = 5,
                        keywords = "fun", keywordExact = TRUE)
    expect_equal(length(c_exact), 5, label = "keywordsExact TRUE works")
    
    c_not_exact <- clcolors(set = "new", numResults = 5,
                            keywords = "fun", keywordExact = FALSE)
    expect_equal(length(c_not_exact), 5, label = "keywordsExact FALSE works")
  })
})

with_mock_api({
  test_that("Printing works", {
    c_single <- clcolor("f06134")
    c_single_output <- capture.output(c_single)
    
    expect_equal(length(c_single_output), 13,
                 label = "(single) print output is correct length")
    expect_match(c_single_output[1], "Pattern ID:",
                 label = "(single) pattern ID is first")
    expect_match(c_single_output[12], "Colors:",
                 label = "(single) color is last")
    
    c_multiple <- clcolors(set = "new", numResults = 2)
    c_multiple_output <- capture.output(c_multiple)
    
    expect_equal(length(c_multiple_output), 26,
                 label = "(multiple) print output is correct length")
    expect_match(c_multiple_output[1], "Pattern ID:",
                 label = "(multiple; first color) pattern ID is first")
    expect_match(c_multiple_output[12], "Colors:",
                 label = "(multiple; first color) color is last")
    expect_match(c_multiple_output[14], "Pattern ID:",
                 label = "(multiple; second color) pattern ID is first")
  })
})

with_mock_api({
  test_that("Swatch functions work", {
    c_single <- clcolor("f06134")
    c_multiple <- clcolors(set = "new", numResults = 2)
    
    expect_equal(length(swatch(c_single)), 1,
                 label = "one item is returned")
    expect_equal(substr(swatch(c_single)[[1]], 1, 1), "#",
                 label = "hex codes start with #")
    
    expect_equal(length(swatch(c_multiple)), 2,
                 label = "two items are returned")
    expect_equal(substr(swatch(c_multiple)[[1]], 1, 1), "#",
                 label = "first hex code starts with #")
    expect_equal(substr(swatch(c_multiple)[[2]], 1, 1), "#",
                 label = "second hex code starts with #")
  })
})
