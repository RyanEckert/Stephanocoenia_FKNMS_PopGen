#!/usr/bin/env python3
################################################################################
#Script Name    : ngsAdmixLauncher.py
#Description    : Print list of ngsAdmix commands for specified K value range
#Author         : Ryan J Eckert
#Email          : ryan.j.eckert@gmail.com
################################################################################
import os, argparse, sys, math

parser = argparse.ArgumentParser(description="Prints a list ngsAdmix commands for specified range of K which can be used with launcher_creator.py \n"
"usage example: ngsAdmixLauncher.py -f myfile.beagle.gz --maxK 10 -r 10 -n ngsAdmix --launcher \n")

parser.add_argument("-f", type = str, help = "Input beagle file name", action = "store")
parser.add_argument("--minK", type = int, help = "Minium value of K", action = "store", default='1')
parser.add_argument("--maxK", type = int, help = "Maximum value of K", action = "store")
parser.add_argument("-n", type = str, help = "Common name of outputs", action = "store", default='ngsAdmix')
parser.add_argument("--launcher", help = "If used, create .slurm file with launcher_creator.py", action = "store_true")
parser.add_argument("-e", help = "If used, email to send SLURM info to", action = "store")
parser.add_argument("-r", type = int, help = "Number of replicate simulations to run per K", action = "store", default='10')

args = parser.parse_args()
minK = args.minK
maxK = args.maxK
f = args.f
e = args.e
n = args.n
r = args.r
launcher = args.launcher
filename = n+'NgsAdmix'

outfile = open(filename, 'w')

for Run in range(1, (r+1)):
    for K in range(minK, (maxK+1)):
        outfile.write('NGSadmix -likes '+f+' -K '+str(K)+' -P 10 -o '+n+'_k'+str(K)+'_run'+str(Run)+'\n')

outfile.close()

if launcher:
    os.system("module load launcher/3.5");
    if e:
        os.system('launcher_creator.py -j '+filename+' -n '+filename+' -q shortq7 -t 6:00:00 -e '+e)
    else:
        os.system('launcher_creator.py -j '+filename+' -n '+filename+' -q shortq7 -t 6:00:00')
