#!/bin/bash
#--------------------------SBATCH settings------

#SBATCH --job-name=unicycler      ## job name
#SBATCH -A katrine_lab     ## account to charge
#SBATCH -p standard          ## partition/queue name
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --array=1-18   ## number of tasks to launch (wc -l prefixes.txt)
#SBATCH --cpus-per-task=16    ## number of cores the job needs
#SBATCH --error=slurm-%J.err ## error log file
#SBATCH --output=slurm-%J.out ##output info file

#module load
module load unicycler/0.4.8

#Path contigs
reads="/pub/amonsiba/Projects/221209_STMphage.ch1/dehuman.reads_3"
#Path to output
out="/dfs8/pub/amonsiba/Projects/221209_STMphage.ch1/assemblies_nohuman"

#Make a temp file
temp=$(basename -s _L001.R1.nohuman.fastq.gz $reads/*_L001.R1.nohuman.fastq.gz | sort -u)
#Make prefix file
prefix=`echo "$temp" | head -n $SLURM_ARRAY_TASK_ID | tail -n 1`

unicycler \
-1 $reads/${prefix}_L001.R1.nohuman.fastq.gz \
-2 $reads/${prefix}_L001.R2.nohuman.fastq.gz \
-t $SLURM_CPUS_PER_TASK \
-o $out/unicycler/${prefix}
