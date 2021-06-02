#!/bin/bash
# Andrea Telatin 2017, Bash Training for Bioinformatics, Quadram Institute

# Defaults:
input_dir="./";
ext='fastq.gz'

# Usage:
echo " Merge Illumina lanes
 USAGE:
 $(basename $0) -o OUTPUT_DIR [-i INPUT_DIR]
 Options:
   -i    Input directory (default: $input_dir)
   -o    Output directory (will be created)
   -e    Extension without first dot (default: $ext)
";

while getopts o:i:e: option
do
        case "${option}"
                in
                        i) input_dir=${OPTARG};;
                        o) output_dir=${OPTARG};;
                        e) ext=${OPTARG};;
                        ?) echo " Wrong parameter $OPTARG";;
         esac
done
shift "$(($OPTIND -1))"

if [ -z ${output_dir+x} ];
then
        echo " FATAL ERROR: Please specify output directory:  -o OUTPUT_DIR"
        exit 9
fi

if [ -d "${output_dir}" ]; then
        echo " FATAL ERROR: Directory '$output_dir' was found. Please specify a new name"
        exit 7
fi

if test "$BASH" = "" || "$BASH" -uc "a=();true \"\${a[@]}\"" 2>/dev/null; then
    # Bash 4.4, Zsh
    set -euo pipefail
else
    # Bash 4.3
    set -eo pipefail
fi
shopt -s nullglob globstar
IFS=$'\n\t'


mkdir "$output_dir"

sample_counter=0;
files_counter=0;

# Loop files in {input_dir} with extension {ext}

for sample_file in ${input_dir}/*_*.${ext};
do
  sample_name=$(basename "$sample_file"   | cut -f 1 -d "_")
  sample_index=$(basename "$sample_file"  | cut -f 2 -d "_")
  sample_strand=$(basename "$sample_file" | cut -f 4 -d "_")

  echo " > Adding $sample_file to ${sample_name}.${ext}";
  cat $sample_file >> ${output_dir}/${sample_name}.${ext};
done
