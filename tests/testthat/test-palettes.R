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

with_mock_api({
  test_that("Extra parameters for random palettes are caught", {
    expect_warning(clpalettes(set = "random", lover = "junk"),
                   label = "no parameters allowed when getting random palette")
  })
})

with_mock_api({
  test_that("Number of results works", {
    expect_equal(length(clpalettes(set = "new", numResults = 5)), 5,
                 label = "get specified number")
    expect_equal(length(clpalettes(set = "new", numResults = 150)), 20,
                 label = "default to 20 if number is too high")
    expect_equal(length(clpalettes(set = "new", numResults = 0)), 20,
                 label = "default to 20 if number is too low")
    
    expect_equal(length(clpalettes(set = "new", numResults = 5, resultOffset = 10)), 5,
                 label = "results work with offset")
    expect_equal(length(clpalettes(set = "new", numResults = 5, resultOffset = 0)), 5,
                 label = "results work with weird offset")
  })
})

with_mock_api({
  test_that("Sorting and ordering work", {
    expect_warning(clpalettes(set = "new", numResults = 1, orderCol = "junk"))
    expect_warning(clpalettes(set = "new", numResults = 1, sortBy = "junk"))
  })
})

with_mock_api({
  test_that("hueOption works", {
    p_hue_option <- clpalettes(set = "new", hueOption = c("yellow", "orange"), numResults = 2)
    expect_equal(length(p_hue_option), 2, label = "hueOption")
    
    expect_warning(clpalettes(set = "new", hueOption = c("red", "junk color"), numResults = 2))
  })
})

with_mock_api({
  test_that("Hex-related arguments work", {
    expect_warning(clpalettes(set = "new", numResults = 1, 
                              hex = c("#E8B3A2", "#E78BA4", "#5BA0B5", 
                                      "#348246", "#264F18", "#0000FF")),
                   label = "warning when too many colors are provided")
    
    expect_warning(clpalettes(set = "new", hex = "0000FF", 
                              numResults = 5, hex_logic = "junk"))
    
    p_single_hex <- clpalettes(set = "new", hex = "0000FF", numResults = 5)
    expect_equal(length(p_single_hex), 5, 
                 label = "correct number of results")
    expect_true(all(sapply(p_single_hex, function(x) "0000FF" %in% x$colors)),
                label = "single hex value in palette")
    
    p_multiple_hex <- clpalettes(set = "new", hex = c("0000FF", "FF0000"), numResults = 5)
    expect_equal(length(p_multiple_hex), 5, 
                 label = "correct number of results")
    expect_true(all(sapply(p_multiple_hex, 
                           function(x) c("0000FF", "FF0000") %in% x$colors)),
                label = "multiple hex values in palette")
  })
})

with_mock_api({
  test_that("Keywords work", {
    p_green <- clpalettes(set = "new", keywords = "green", numResults = 5)
    expect_equal(length(p_green), 5, label = "single keyword works")
    
    p_tree <- clpalettes(set = "new", keywords = "winter tree", numResults = 5)
    expect_equal(length(p_tree), 5, label = "multiple keywords work")
  })
})

with_mock_api({
  test_that("Keyword exactness works", {
    expect_warning(clpalettes(set = "new", keywordExact = 3, numResults = 1),
                   label = "keywordExact must be 0 or 1 or T/F")
    
    p_exact <- clpalettes(set = "new", numResults = 5,
                          keywords = "fun", keywordExact = TRUE)
    expect_equal(length(p_exact), 5, label = "keywordExact TRUE works")
    
    p_not_exact <- clpalettes(set = "new", numResults = 5,
                              keywords = "fun", keywordExact = FALSE)
    expect_equal(length(p_not_exact), 5, label = "keywordExact FALSE works")
  })
})

with_mock_api({
  test_that("Printing works", {
    p_single <- clpalette("4643751")
    p_single_output <- capture.output(p_single)
    
    expect_equal(length(p_single_output), 13,
                 label = "(single) print output is correct length")
    expect_match(p_single_output[1], "Palette ID:",
                 label = "(single) palette ID is first")
    expect_match(p_single_output[12], "Colors:",
                 label = "(single) colors are last")
    
    p_multiple <- clpalettes(set = "new", numResults = 2)
    p_multiple_output <- capture.output(p_multiple)
    
    expect_equal(length(p_multiple_output), 26,
                 label = "(multiple) print output is correct length")
    expect_match(p_multiple_output[1], "Palette ID:",
                 label = "(multiple; first palette) palette ID is first")
    expect_match(p_multiple_output[12], "Colors:",
                 label = "(multiple; first palette) color is last")
    expect_match(p_multiple_output[14], "Palette ID:",
                 label = "(multiple; second palette) palette ID is first")
  })
})
