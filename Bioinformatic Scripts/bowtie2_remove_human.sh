#!/bin/bash
#--------------------------SBATCH settings------

#SBATCH --job-name=bowtie2_human      ## job name
#SBATCH -A katrine_lab     ## account to charge
#SBATCH -p standard          ## partition/queue name
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=16    ## number of cores the job needs
#SBATCH --error=slurm-%J.err ## error log file
#SBATCH --output=slurm-%J.out ##output info file

module load bowtie2/2.4.4

for f in $(ls *.dedupe.fastq.gz | sed 's/.dedupe.fastq.gz//' | sort -u)
do
bowtie2 -x /dfs6/pub/amonsiba/Bowtie2_db/Bowtie2_human_index/grch38_1kgmaj \
-p $SLURM_CPUS_PER_TASK \
-S ${f}_human_reads.sam \
--interleaved ${f}.dedupe.fastq.gz \
--un-conc-gz ${f}.R%.nohuman.fastq.gz

done
