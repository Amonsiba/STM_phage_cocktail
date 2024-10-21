#!/bin/bash
#---------------------SBATCH settings------

#SBATCH --job-name=prokka      ## job name
#SBATCH -A katrine_lab     ## account to charge
#SBATCH -p free          ## partition/queue name
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --array=1-49
#SBATCH --cpus-per-task=8    ## number of cores the job needs
#SBATCH --error=slurm-%J.err ## error log file
#SBATCH --output=slurm-%J.out ##output info file

#Module load Prokka
#updated Prokka 10/4/24
echo "Activating Prokka environment"
eval "$(conda shell.bash hook)"
conda activate /data/homezvol0/amonsiba/.conda/envs/Prokka

# Set your working directory
FASTA="/pub/amonsiba/Projects/240701_STM_analysis/data/STM_assemblies/final_assemblies"
OUTPUT="/pub/amonsiba/Projects/240701_STM_analysis/results/STM_genomes"

#Make a temp file
temp=$(basename -s .fasta $FASTA/*.fasta | sort -u)
#Make prefix file
prefix=`echo "$temp" | head -n $SLURM_ARRAY_TASK_ID | tail -n 1`


prokka --outdir $OUTPUT/${prefix} \
 --prefix ${prefix}.prokka \
 --genus Stenotrophomonas \
 --species maltophilia \
 --kingdom Bacteria \
 --gcode 11 $FASTA/${prefix}.fasta


