#!/bin/bash
source activate qiime2-2019.4

for item in 00-adapter-fastas/* ; do 

	filestem=`basename $item .fasta`  
	R1=`ls 00-raw/$filestem*_R1_*`
	R2=`ls 00-raw/$filestem*_R2_*`

	#multithreaded support not possible as of yet for demultiplexing, still stupid fast compared to qiime1
	cutadapt -e 0 --no-indels --cores 1 \
	-g file:$item -o demultiplexed/{name}.R1.fastq.gz \
	-p demultiplexed/{name}.R2.fastq.gz $R1 $R2

done 

conda deactivate
