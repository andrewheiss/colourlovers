context("Statistics")

with_mock_api({
  test_that("Statistics work", {
    s <- clstats('colors')
    expect_true(inherits(s, "clstats"), 
                label = "clstats class correct")
    expect_equal(attr(s, "clstat_type"), "colors", 
                 label = "clstat_type class correct")
    expect_gt(s, 1, label = "number is greater than 1")
  })
})

with_mock_api({
  test_that("Printing works", {
    s <- clstats('colors')
    s_output <- capture.output(s)
    
    expect_equal(length(s_output), 1,
                 label = "print output is correct length")
    expect_match(s_output, "Total colors:",
                 label = "correct label included")
  })
})
