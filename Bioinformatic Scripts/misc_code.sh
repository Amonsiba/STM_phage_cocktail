#230715 - Reading the files of assembly.fasta 
find . -type f -name "assembly.fasta" -printf "/%P\n" | while read FILE ; do DIR=$(dirname "$FILE") ;\mv ."$FILE" ."$DIR""$DIR".assembly.fasta ; done

#230715 - Reading the files of assembly.gfa 
find . -type f -name "assembly.gfa" -printf "/%P\n" | while read FILE ; do DIR=$(dirname "$FILE") ;\mv ."$FILE" ."$DIR""$DIR".assembly.gfa ; done

#230715 - moving files over to new directory for fasta, have to make directory first
find . -type f -name '*assembly.fasta' -exec cp -t ./assembled.fasta {} +

#230715 - moving files over to new directory for fasta, have to make directory first
find . -type f -name '*assembly.gfa' -exec cp -t ./assembled.gfa {} +

#230715 - running QUAST
/dfs8/pub/amonsiba/Programs/quast-quast_5.1.0rc1/quast.py *.fasta

#230715 - Extracted contig 1 for S28.2 and SBP3.1.2, based on converage, with the following code: 
awk -v seq="TARGET_ID" -v RS='>' '$1 == seq {print RS $0}' input.fasta > ouput.fasta 

#230807 - running CheckV on compiled fasta file of phage contigs
conda activate v_env
checkv end_to_end allSTMphage.fasta ./check_v_230807 -t 16 -d /pub/amonsiba/Programs/check_v/checkv-db-v1.0