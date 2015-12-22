context("Colours")

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

context("Palettes")

test_that("Palettes work", {
    top <- clpalettes('top')
    expect_true(inherits(top[[1]], "clpalette"), label = "clpalettes class correct")
    expect_true(is.list(swatch(top)), label = "single clpalettes swatch is list")
    expect_true(is.list(swatch(top[[1]])), label = "multiple clpalettes swatch is list")
    
    p1 <- clpalette('113451')
    expect_true(inherits(p1, "clpalette"), label = "clpalette class correct")
    expect_true(is.list(swatch(p1)), label = "clpallette swatch is list")
})


context("Patterns")

test_that("Patterns work", {
    p <- clpatterns('top')
    expect_true(inherits(p[[1]], "clpattern"), label = "clpatterns class correct")
    expect_true(is.list(swatch(p)), label = "single clpatterns swatch is list")
    expect_true(is.list(swatch(p[[1]])), label = "multiple clpatterns swatch is list")
    
    p1 <- clpattern('1451')
    expect_true(inherits(p1, "clpattern"), label = "clpattern class correct")
    expect_true(is.list(swatch(p1)), label = "clpattern swatch is list")
})

