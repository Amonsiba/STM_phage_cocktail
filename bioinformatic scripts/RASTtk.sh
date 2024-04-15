#!/bin/bash
#---------------------SBATCH settings------

#SBATCH --job-name=RASTtk      ## job name
#SBATCH -A katrine_lab     ## account to charge
#SBATCH -p standard          ## partition/queue name
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=3    ## number of cores the job needs
#SBATCH --error=slurm-%J.err ## error log file
#SBATCH --output=slurm-%J.out ##output info file

#Define for loop
for f in $(ls *.genome.fasta | sed 's/.genome.fasta//' | sort -u)
do
rast-create-genome \
 --scientific-name "Bacteriophage" \
 --genetic-code 11 \
 --domain Virus \
 --contigs ${f}.genome.fasta > ${f}.gto 
rast-process-genome < ${f}.gto > ${f}.gto2 
rast-export-genome genbank < ${f}.gto2 > ${f}.gbk
done
