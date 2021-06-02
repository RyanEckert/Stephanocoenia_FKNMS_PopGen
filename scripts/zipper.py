#!/usr/bin/env python3
################################################################################
#Script Name	: zipper.py
#Description	: Print list of files to gzip or gunzip with launcher_creator.py
#Author       	: Ryan J Eckert
#Email         	: ryan.j.eckert@gmail.com
################################################################################
import os, argparse, sys, glob

parser = argparse.ArgumentParser(description="Prints a list of gzip/gunzip commands to be used with launcher_creator.py \n"
"usage examples: zipper.py -f gz --gunzip >gunzip \n")

parser.add_argument("-f", type=str, help="File type to add, don't include '.' [e.g. fastq]", action = "store")
parser.add_argument("--gunzip", help="If used, gunzip files", action = "store_true")
parser.add_argument("-a", type=str, help="Optional arguments to pass to g/unzip", action = "store", default='')
parser.add_argument("-n", type=str, help="Name of output file to write launcher commands to", action = "store", default='zip')
parser.add_argument("--launcher", help="If used, create .slurm file with launcher_creator.py", action = "store_true")
parser.add_argument("-e", help="If used, email to send SLURM info to", action = "store")


args = parser.parse_args()
gunzip = args.gunzip
f = args.f
a = args.a
e = args.e
n = args.n
launcher = args.launcher

outfile = open(n, 'w')

for file in glob.iglob(r'*'+f):
    if gunzip:
        outfile.write('gunzip '+file+'\n')
    else:
        outfile.write('gzip '+a+' '+file+'\n')

outfile.close()

if launcher:
    os.system("module load launcher/3.5");
    if e:
        os.system('launcher_creator.py -j '+n+' -n '+n+' -q shortq7 -t 6:00:00 -e '+e)
    else:
        os.system('launcher_creator.py -j '+n+' -n '+n+' -q shortq7 -t 6:00:00')
