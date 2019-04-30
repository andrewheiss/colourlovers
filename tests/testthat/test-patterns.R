context("Patterns")

with_mock_api({
  test_that("Patterns work", {
    p <- clpatterns('top')
    expect_true(inherits(p[[1]], "clpattern"), label = "clpatterns class correct")
    expect_true(is.list(swatch(p)), label = "single clpatterns swatch is list")
    expect_true(is.list(swatch(p[[1]])), label = "multiple clpatterns swatch is list")
    
    p1 <- clpattern('1451')
    expect_true(inherits(p1, "clpattern"), label = "clpattern class correct")
    expect_true(is.list(swatch(p1)), label = "clpattern swatch is list")
  })
})

with_mock_api({
  test_that("Extra parameters for random patterns are caught", {
    expect_warning(clpatterns(set = "random", lover = "junk"),
                   label = "no parameters allowed when getting random pattern")
  })
})

with_mock_api({
  test_that("Number of results works", {
    expect_equal(length(clpatterns(set = "new", numResults = 5)), 5,
                 label = "get specified number")
    expect_equal(length(clpatterns(set = "new", numResults = 150)), 20,
                 label = "default to 20 if number is too high")
    expect_equal(length(clpatterns(set = "new", numResults = 0)), 20,
                 label = "default to 20 if number is too low")
    
    expect_equal(length(clpatterns(set = "new", numResults = 5, resultOffset = 10)), 5,
                 label = "results work with offset")
    expect_equal(length(clpatterns(set = "new", numResults = 5, resultOffset = 0)), 5,
                 label = "results work with weird offset")
  })
})

with_mock_api({
  test_that("Sorting and ordering work", {
    expect_warning(clpatterns(set = "new", numResults = 1, orderCol = "junk"))
    expect_warning(clpatterns(set = "new", numResults = 1, sortBy = "junk"))
  })
})

with_mock_api({
  test_that("hueOption works", {
    p_hue_option <- clpatterns(set = "new", hueOption = c("yellow", "orange"), numResults = 2)
    expect_equal(length(p_hue_option), 2, label = "hueOption")
    
    expect_warning(clpatterns(set = "new", hueOption = c("red", "junk color"), numResults = 2))
  })
})

with_mock_api({
  test_that("Hex-related arguments work", {
    expect_warning(clpatterns(set = "new", numResults = 1, 
                              hex = c("#574333", "#F1F79C", "#F7F4BC", 
                                      "#E6BD87", "#7A9157", "#0000FF")),
                   label = "warning when too many colors are provided")
    
    expect_warning(clpatterns(set = "new", hex = "0000FF", 
                              numResults = 5, hex_logic = "junk"))
    
    p_single_hex <- clpatterns(set = "new", hex = "0000FF", numResults = 5)
    expect_equal(length(p_single_hex), 5, 
                 label = "correct number of results")
    expect_true(all(sapply(p_single_hex, function(x) "0000FF" %in% x$colors)),
                label = "single hex value in pattern")
    
    p_multiple_hex <- clpatterns(set = "new", hex = c("0000FF", "FF0000"), numResults = 5)
    expect_equal(length(p_multiple_hex), 5, 
                 label = "correct number of results")
    expect_true(all(sapply(p_multiple_hex, 
                           function(x) c("0000FF", "FF0000") %in% x$colors)),
                label = "multiple hex values in pattern")
  })
})

with_mock_api({
  test_that("Keywords work", {
    p_green <- clpatterns(set = "new", keywords = "green", numResults = 5)
    expect_equal(length(p_green), 5, label = "single keyword works")
    
    p_tree <- clpatterns(set = "new", keywords = "winter tree", numResults = 5)
    expect_equal(length(p_tree), 5, label = "multiple keywords work")
  })
})

with_mock_api({
  test_that("Keyword exactness works", {
    expect_warning(clpatterns(set = "new", keywordExact = 3, numResults = 1),
                   label = "keywordExact must be 0 or 1 or T/F")
    
    p_exact <- clpatterns(set = "new", numResults = 5,
                          keywords = "fun", keywordExact = TRUE)
    expect_equal(length(p_exact), 5, label = "keywordExact TRUE works")
    
    p_not_exact <- clpatterns(set = "new", numResults = 5,
                              keywords = "fun", keywordExact = FALSE)
    expect_equal(length(p_not_exact), 5, label = "keywordExact FALSE works")
  })
})

with_mock_api({
  test_that("Printing works", {
    p_single <- clpattern("5789044")
    p_single_output <- capture.output(p_single)
    
    expect_equal(length(p_single_output), 13,
                 label = "(single) print output is correct length")
    expect_match(p_single_output[1], "Pattern ID:",
                 label = "(single) pattern ID is first")
    expect_match(p_single_output[12], "Colors:",
                 label = "(single) colors are last")
    
    p_multiple <- clpatterns(set = "new", numResults = 2)
    p_multiple_output <- capture.output(p_multiple)
    
    expect_equal(length(p_multiple_output), 26,
                 label = "(multiple) print output is correct length")
    expect_match(p_multiple_output[1], "Pattern ID:",
                 label = "(multiple; first pattern) pattern ID is first")
    expect_match(p_multiple_output[12], "Colors:",
                 label = "(multiple; first pattern) color is last")
    expect_match(p_multiple_output[14], "Pattern ID:",
                 label = "(multiple; second pattern) pattern ID is first")
  })
})
