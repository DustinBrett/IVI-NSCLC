context("txseq.R unit tests")
rm(list = ls())

test_that("tx_1L", {
  expect_error(tx_1L(), NA)
})

test_that("tx_2L", {
  expect_error(tx_2L(tx_1L()))
  
  # 1st/2nd generation TKIs
  second <- tx_2L("erlotinib")
  expect_equal(second$pos, "osimertinib")
  expect_equal(second$neg, c("PBDC", "PBDC + bevacizumab"))
  
  # Osimertinib
  second <- tx_2L("osimertinib")
  expect_equal(second$pos, second$neg)
  
  # Errors
  expect_error(tx_2L("erlotinib2"))
  
})

test_that("tx_2LP", {
  expect_error(tx_2LP("osimertinib"))
  second_plus <- tx_2LP(c("osimertinib", "PBDC"))
  expect_equal(names(second_plus), c("pos", "neg"))
})

test_that("txseq", {
  # Try a standard sequence
  txseq <- txseq(first = "erlotinib",
                  second = c("osimertinib", "PBDC"),
                  second_plus = c("PBDC + bevacizumab", "PBDC + bevacizumab"))
  expect_true(inherits(txseq, "txseq"))
  expect_error(txseq(first = 1))  
  
  # Using NULL second line treatments
  txseq <- txseq(first = "erlotinib",
                  second = c("osimertinib", NA),
                  second_plus = c("PBDC + bevacizumab", NA)) 
  expect_true(inherits(txseq, "txseq"))
  txseq <- txseq(first = "erlotinib",
                  second = c(NA, "PBDC"),
                  second_plus = c(NA, "PBDC + bevacizumab"))   
  expect_true(inherits(txseq, "txseq"))
  expect_error(txseq(first = "erlotinib",
               second = c(NA, NA),
               second_plus = c(NA, NA)))
  expect_error(txseq(first = "erlotinib",
                     second = c(NA, "PBDC + bevacizumab"),
                     second_plus = c(NA, NA)))
  expect_error(txseq(first = "erlotinib",
                      second = c(NA, "PBDC"),
                      second_plus = c("PBDC + bevacizumab", NA)))
  expect_error(txseq(first = "erlotinib",
                      second = c("osimertinib", NA),
                      second_plus = c(NA, "PBDC + bevacizumab")))  
  expect_error(txseq(first = "erlotinib",
                    second = c("osimertinib", "PBDC"),
                    second_plus = c(NA, "PBDC + bevacizumab")))
  expect_error(txseq(first = "erlotinib",
                    second = c("osimertinib", "PBDC"),
                    second_plus = c("PBDC + bevacizumab", NA)))  
  
  # Shouldn't have errors with other correct sequences
  expect_true(inherits(txseq(first = "erlotinib",
                             second = c("osimertinib", "PBDC + bevacizumab"),
                             second_plus = c("PBDC + bevacizumab", "PBDC + nivolumab")),
                             "txseq"))
  expect_true(inherits(txseq(first = "osimertinib",
                             second = c("PBDC + bevacizumab", "erlotinib"),
                             second_plus = c("PBDC + nivolumab", "PBDC + bevacizumab")),
                             "txseq"))  
  
  # Incorrect selections
  expect_error(txseq(first = "PBDC",
                  second = c("osimertinib", "PBDC"),
                  second_plus = c("osimertinib", "PBDC + bevacizumab")))   
  expect_error(txseq(first = "erlotinib",
                  second = c("osimertinib", "PBDC"),
                  second_plus = c("osimertinib", "PBDC + bevacizumab"))) 
    
  # Incorrect types
  ## First line
  expect_error(txseq(first = c("erlotinib", "gefitinib"),
                  second = c("osimertinib", "PBDC"),
                  second_plus = c("PBDC + bevacizumab", "PBDC + bevacizumab")))
  
  ## Second line
  expect_error(txseq(first = c("erlotinib"),
                  second = c("osimertinib"),
                  second_plus = c("PBDC + bevacizumab", "PBDC + bevacizumab")))  
  expect_error(txseq(first = c("erlotinib"),
                  second = 2,
                  second_plus = c("PBDC + bevacizumab", "PBDC + bevacizumab")))   
  expect_error(txseq(first = "erlotinib",
                  second = c("osimertinib2", "PBDC"),
                  second_plus = c("PBDC + bevacizumab", "PBDC + bevacizumab")))  
  expect_error(txseq(first = "erlotinib",
                  second = c("osimertinib", "PBDC2"),
                  second_plus = c("PBDC + bevacizumab", "PBDC + bevacizumab")))
  
  ## Second line plus
  expect_error(txseq(first = c("erlotinib"),
                    second = c("osimertinib", "PBDC"),
                    second_plus = c("PBDC + bevacizumab")))
  expect_error(txseq(first = "erlotinib",
                    second = c("osimertinib", "PBDC"),
                    second_plus = 3)) 
  expect_error(txseq(first = "erlotinib",
                    second = c("osimertinib", "PBDC + bevacizumab"),
                    second_plus = c("PBDC + bevacizumab", "PBDC + bevacizumab")))
})

test_that("txseq_list", {
  txseq1 <- txseq(first = "erlotinib",
                  second = c("osimertinib", "PBDC"),
                  second_plus = c("PBDC + bevacizumab", "PBDC + bevacizumab"))
  txseq2 <- txseq(first = "gefitinib",
                  second = c("osimertinib", "PBDC"),
                  second_plus = c("PBDC + bevacizumab", "PBDC + bevacizumab")) 
  txseq3 <- txseq(first = "gefitinib",
                  second = c("osimertinib", NA),
                  second_plus = c("PBDC + bevacizumab", NA)) 
  txseq4 <- txseq(first = "gefitinib",
                  second = c(NA, "PBDC"),
                  second_plus = c(NA, "PBDC + bevacizumab"))   

  # Working  
  txseqs <- txseq_list(seq1 = txseq1, seq2 = txseq2)
  expect_true(inherits(txseqs, "txseq_list"))
  expect_equal(names(txseqs), c("seq1", "seq2"))
  
  txseqs <- txseq_list(list(seq1 = txseq1, seq2 = txseq2))
  expect_true(inherits(txseqs, "txseq_list"))
  expect_equal(names(txseqs), c("seq1", "seq2"))  
  
  txseqs <- txseq_list(seq1 = txseq1, seq2 = txseq2, 
                       start_line = "second", mutation = "negative")  
  expect_true(inherits(txseqs, "txseq_list"))
  
  txseqs <- txseq_list(seq1 = txseq1, seq2 = txseq3, 
                       start_line = "second", mutation = "positive")
  expect_true(inherits(txseqs, "txseq_list"))
  
  # Errors
  expect_error(txseq_list(seq1 = txseq1, seq2 = 2))
  expect_error(txseq_list(seq1 = txseq1, seq2 = txseq2, mutation = "positive"))
  expect_error(txseq_list(seq1 = txseq1, seq2 = txseq2, mutation = "negative"))
  expect_error(txseq_list(seq1 = txseq1, seq2 = txseq2, start_line = "second", 
                          mutation = "unknown"))
  expect_error(txseq_list(seq1 = txseq1, seq2 = txseq3, start_line = "first"))
  expect_error(txseq_list(seq1 = txseq1, seq2 = txseq3, start_line = "second",
                          mutation = "negative"))
  expect_error(txseq_list(seq1 = txseq1, seq2 = txseq4, start_line = "second",
                          mutation = "positive"))  
})

