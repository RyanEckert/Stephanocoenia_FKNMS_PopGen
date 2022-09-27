#!/usr/bin/env Rscript
##############################################################################################
#Script Name	: topReads.R
#Description	: Return a file with the file names of the top 50% of samples by read count
#Author       : Ryan J Eckert
#Email        : ryan.j.eckert@gmail.com
##############################################################################################
# Usage       : topReads.R [filename] [outname]
# Arguments   :
#  [filename] : Read count file name (csv with V1 listing names and V2 listing read counts)
#  [outname]  : Common name for output files

args = commandArgs(TRUE)

# Check that there are 2 argumnets: if not, return an error
if (length(args)!=2) {
  stop("Need 2 arguments\nUsage : topReads.R [filename] [outname]\nArguments:\n[filename] : Read count file name (csv with V1 listing names and V2 listing read counts)\n[outfile]  : Common name for output files") }

counts = read.csv(args[1], header = FALSE)
ordCounts = counts[order(counts[, "V2"], decreasing = TRUE), , drop = FALSE]
top50 = as.data.frame(head(ordCounts$V1, (nrow(ordCounts)/2)))
write.table(ordCounts, file = paste(args[2], "CountsOrdered", sep = ""), row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(top50, file = paste(args[2], "TopReads", sep = ""), row.names = FALSE, col.names = FALSE, , quote = FALSE)
quit()
