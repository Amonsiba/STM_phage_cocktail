#!/bin/bash
#--------------Anvio Code for inline text--------------

#note: external-genomes.txt should be made and formatted per ANVIO website and should be in working directory

#name should be adjusted to project
#project name
p = Project_Steno

#genome name
g = STM_phages

#directory name
d = analysis_221209

#ANVIO pipeline

#Storage: Creates a genome storage from external genomes for a pangenome analysis with the gene$
anvi-gen-genomes-storage -e external-genomes.txt \
                         -o STM_phages-GENOMES.db \
                         --gene-caller NCBI_PGAP


#Pangenomic Analysis
anvi-pan-genome -g STM_phages-GENOMES.db \
                --project-name Project_ALL_Steno \
                --output-dir analysis_all_230803 


#computing ANI%

anvi-compute-genome-similarity --external-genomes external-genomes.txt \
                               --program pyANI \
                               --output-dir ANI \
                               --num-threads 6 \
                               --pan-db analysis_all_230803/Project_ALL_Steno-PAN.db

#Display the Pangenomic Analysis
anvi-display-pan -p analysis_all_230715/Project_Steno-PAN.db -g STM_phages-GENOMES.db



Podo ------------------------------------------------------------------------------------------------
#Pangenomic Analysis
anvi-pan-genome -g STM_phages-GENOMES.db \
                --project-name Project_Podo_Steno \
                --output-dir analysis_all_230807

anvi-compute-genome-similarity --external-genomes external-genomes.txt \
                               --program pyANI \
                               --output-dir ANI \
                               --num-threads 6 \
					  --mcl-inflation 10 \ #sensitive for gene clusters 1 is low relatedness, 10 is very similar
                               --pan-db analysis_all_230807/Project_Podo_Steno-PAN.db

anvi-display-pan -p analysis_all_230807/Project_Podo_Steno-PAN.db -g STM_phages-GENOMES.db


Sipho -------------------------------------------------------------------------------------------------

#Pangenomic Analysis
anvi-pan-genome -g STM_phages-GENOMES.db \
                --project-name Project_Sipho_Steno \
                --output-dir analysis_all_230814

anvi-compute-genome-similarity --external-genomes external-genomes.txt \
                               --program pyANI \
                               --output-dir ANI \
                               --num-threads 6 \
                               --pan-db analysis_all_230814/Project_Sipho_Steno-PAN.db

anvi-display-pan -p analysis_all_230814/Project_Sipho_Steno-PAN.db -g STM_phages-GENOMES.db