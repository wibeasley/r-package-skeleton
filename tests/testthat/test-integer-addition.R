library(testthat)
context("Integer addition")

test_that("smoke-test", {
  returned <- integer_addition(3,5)
  expect_true(!is.null(returned))
})

test_that("vector-test", {
  a <- 5:10
  b <- -16:-11
  expected <- -1L
  returned <- integer_addition(3:6)
  expect_equal(returned, expected)
})
