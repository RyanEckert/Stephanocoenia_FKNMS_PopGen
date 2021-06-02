#!/usr/bin/env python3
################################################################################
#Script Name	: readCounts.py
#Description	: Generate a file with Illumina read counts from specified files
#Author       	: Ryan J Eckert
#Email         	: ryan.j.eckert@gmail.com
################################################################################
import os, argparse, sys, glob, math

parser = argparse.ArgumentParser(description='Prints a file with a list of Illumina read counts for files with a specified extension')
parser.add_argument("-f", type=str, help="File extension for files to add, don't need to include [e.g. fastq]", action = "store", default='fq')
parser.add_argument("-o", type=str, help="Base name for Counts file [e.g. read -> readCounts]", action = "store", default='read')

args = parser.parse_args()
f = args.f
o = args.o

outfile = open(o+"Counts", 'w')

for seqFile in glob.iglob(r'*'+f):
    count = sum(1 for line in open(seqFile));
    outfile.write(seqFile+' = '+str(math.trunc(count/4))+' reads'+'\n')

outfile.close()
