#!/bin/bash
#--------------------------SBATCH settings------

#SBATCH --job-name=checkm_quality    ## Name of the job.
#SBATCH -p free               ## Account to charge
#SBATCH --ntasks=1                   ## Number of processes
#SBATCH --cpus-per-task=1           ## Number of CPU cores per task
#SBATCH --mem=60G
#SBATCH --error=slurm-%J.err         ## Error log file
#SBATCH --output=slurm-%J.out        ## Output info file

# Activate CheckM environment
echo "Activating CheckM environment"
eval "$(conda shell.bash hook)"
conda activate /data/homezvol0/amonsiba/.conda/envs/checkm_environment

# Set paths
FASTA_BIN="/pub/amonsiba/Projects/240701_STM_analysis/data/STM_assemblies/final_assemblies"  ## Directory containing FASTA files
OUT="/pub/amonsiba/Projects/240701_STM_analysis/results/checkM_analysis_all"                        ## Directory to store CheckM results

# Run CheckM with the custom data path
checkm lineage_wf -t $SLURM_CPUS_PER_TASK -x fasta $FASTA_BIN $OUT
