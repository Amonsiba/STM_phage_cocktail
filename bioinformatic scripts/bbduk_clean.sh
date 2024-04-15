#!/bin/bash
#--------------------------SBATCH settings------

#SBATCH --job-name=bbduk_clean      ## job name
#SBATCH -A katrine_lab     ## account to charge
#SBATCH -p standard          ## partition/queue name
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=16    ## number of cores the job needs
#SBATCH --error=slurm-%J.err ## error log file
#SBATCH --output=slurm-%J.out ##output info file

module load bbmap/38.87

for f in $(ls *_R1_001.fastq.gz | sed 's/_R1_001.fastq.gz//' | sort -u)
do
bbduk.sh \
in=${f}_R1_001.fastq.gz \
in2=${f}_R2_001.fastq.gz \
ref=adapters,phix \
ktrim=r \
mink=11 \
hdist=1 \
qtrim=rl \
trimq=30 \
minlen=10 \
out=${f}_READ1.clean.fastq.gz \
out2=${f}_READ2.clean.fastq.gz \
stats=${f}_bbduk_stats1.txt \
refstats=${f}_bbduk_ref_stats1.txt \
tpe \
tbo \
threads=$SLURM_CPUS_PER_TASK
done
