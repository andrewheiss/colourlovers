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
