#!/bin/bash
#---------------------SBATCH settings------

#SBATCH --job-name=renamecontigsr      ## job name
#SBATCH -A katrine_lab     ## account to charge
#SBATCH -p standard          ## partition/queue name
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=3    ## number of cores the job needs
#SBATCH --array=1-18   ## number of tasks to launch (wc -l prefixes.txt)
#SBATCH --error=slurm-%J.err ## error log file
#SBATCH --output=slurm-%J.out ##output info file

#Path contigs
contigs="/pub/amonsiba/Projects/221209_STMphage.ch1/assemblies_nohuman/contigs"
#Path to output
out="/pub/amonsiba/Projects/221209_STMphage.ch1/assemblies_nohuman/relabeled.contigs"

#Make a temp file
temp=$(basename -s .assembly.fasta  $contigs/*.assembly.fasta  | sort -u)
#Make prefix file
prefix=`echo "$temp" | head -n $SLURM_ARRAY_TASK_ID | tail -n 1`

cat $contigs/${prefix}.assembly.fasta | awk '/^>/{print ">" ++i; next}{print}'| sed -e "s,>,>${prefix}_Contig,g"  > $out/${prefix}.genome.fasta
