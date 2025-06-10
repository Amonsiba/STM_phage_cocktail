#!/bin/bash
#--------------Anvio Script--------------


#pre-processing of files for ANVIO 

#this for loop converts each genbank file into a contigs database with the anvi-gen-conitgs-database program 
#website: https://anvio.org/help/main/programs/anvi-script-process-genbank/#usage

for f in $(ls *.gbk | sed 's/.gbk//' | sort -u)
do
anvi-script-process-genbank -i ${f}.gbk -O ${f}
done 

#This for loop is for generating a new anvi'o contigs databases with external gene calls 
#website: https://anvio.org/help/main/programs/anvi-gen-contigs-database/
for f in $(ls *.fa | sed 's/-contigs.fa//' | sort -u)
do
anvi-gen-contigs-database -f ${f}-contigs.fa -o ${f}.db --external-gene-calls ${f}-external-gene-calls.txt
done

#Parse and store functional annotation for genes. The program takes functions-txt to annotate the contigs-db
#website: https://anvio.org/help/main/programs/anvi-import-functions/

for f in $(ls *.db | sed 's/.db//' | sort -u)
do
anvi-import-functions -c ${f}.db -i ${f}-external-functions.txt
done

