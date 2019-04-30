context("Lovers (users)")

with_mock_api({
  test_that("Lovers work", {
    l <- cllovers(set = "new")
    expect_true(inherits(l[[1]], "cllover"), label = "cllover class correct")
    
    l1 <- cllover("COLOURlovers")
    expect_true(inherits(l1, "cllover"), label = "cllover class correct")
  })
})

with_mock_api({
  test_that("Sorting and ordering work", {
    expect_warning(cllovers(set = "new", numResults = 1, orderCol = "junk"))
    expect_warning(cllovers(set = "new", numResults = 1, sortBy = "junk"))
  })
})

with_mock_api({
  test_that("Number of results works", {
    expect_equal(length(cllovers(set = "new", numResults = 5)), 5,
                 label = "get specified number")
    expect_equal(length(cllovers(set = "new", numResults = 150)), 20,
                 label = "default to 20 if number is too high")
    expect_equal(length(cllovers(set = "new", numResults = 0)), 20,
                 label = "default to 20 if number is too low")
    
    expect_equal(length(cllovers(set = "new", numResults = 5, resultOffset = 10)), 5,
                 label = "results work with offset")
    expect_equal(length(cllovers(set = "new", numResults = 5, resultOffset = 0)), 5,
                 label = "results work with weird offset")
  })
})

with_mock_api({
  test_that("Printing works", {
    l_single <- cllover("COLOURlovers")
    l_single_output <- capture.output(l_single)
    
    expect_equal(length(l_single_output), 14,
                 label = "(single) print output is correct length")
    expect_match(l_single_output[1], "Lover username:",
                 label = "(single) lover username is first")
    expect_match(l_single_output[13], "API URL:",
                 label = "(single) API URL is last")
    
    l_multiple <- cllovers(set = "new", numResults = 2)
    l_multiple_output <- capture.output(l_multiple)
    
    expect_equal(length(l_multiple_output), 28,
                 label = "(multiple) print output is correct length")
    expect_match(l_multiple_output[1], "Lover username:",
                 label = "(multiple; first lover) lover username is first")
    expect_match(l_multiple_output[13], "API URL:",
                 label = "(multiple; first lover) API URL is last")
    expect_match(l_multiple_output[15], "Lover username:",
                 label = "(multiple; second lover) lover username is first")
  })
})
