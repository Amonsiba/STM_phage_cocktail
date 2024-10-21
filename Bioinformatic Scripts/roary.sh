#!/bin/bash
#-------------------SBATCH settings-----------------------
#SBATCH --job-name=roary_analysis       ## Name of the job
#SBATCH -p free               		## Account to charge
#SBATCH --ntasks=1                      ## Number of processes
#SBATCH --mem=20G
#SBATCH --cpus-per-task=8               ## Number of CPU cores per task
#SBATCH --error=roary-%J.err            ## Error log file
#SBATCH --output=roary-%J.out           ## Output info file

# Load Conda environment with Roary installed
echo "Activating Roary environment"
eval "$(conda shell.bash hook)"
conda activate /data/homezvol0/amonsiba/.conda/envs/Roary_env  # Replace with your environment name if different

# Set variables
GFF_DIR="/pub/amonsiba/Projects/240701_STM_analysis/results/STM_genomes/gff_files"    # Directory containing GFF3 files
OUTPUT_DIR="/dfs6/pub/amonsiba/Projects/240701_STM_analysis/results/roary_analysis_1729092258"    # Directory to store Roary results
FASTTREE_OUTPUT="/dfs6/pub/amonsiba/Projects/240701_STM_analysis/results/roary_analysis_1729092258/core_tree_80percent_241015.nwk" ## Output file for the tree
PERCENT=80                      # Percentage of isolates for core genes

# Run Roary
#echo "Running Roary on GFF3 files in $GFF_DIR"
#roary -p $SLURM_CPUS_PER_TASK -i $PERCENT -e -n -v $GFF_DIR/*.gff -f $OUTPUT_DIR

#module load
module load fasttree/2.1.11

# Run FastTree to build a phylogenetic tree from the core gene alignment
echo "Running FastTree"
FastTree -nt -gtr < $OUTPUT_DIR/core_gene_alignment.aln > $FASTTREE_OUTPUT

echo "Roary and FastTree analysis completed."
