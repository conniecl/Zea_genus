## hiseq
java -jar trimmomatic-0.36.jar PE -phred33 -threads 4 1S_S25_L002_R1_001.fastq.gz 1S_S25_L002_R2_001.fastq.gz 1S_S25_L002.1.trim.fastq 1S_S25_L002.1.unpair.fastq 1S_S25_L002.2.trim.fastq 1S_S25_L002.2.unpair.fastq ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
## nova-seq
fastp -g -w 2 -l 36 -i S078_hzau-A_10S_BHC75YDSXX_S61_L001_R1_001.fastq.gz -I S078_hzau-A_10S_BHC75YDSXX_S61_L001_R2_001.fastq.gz -o 10S_1.fq -O 10S_2.fq -j 10S.json -h 10S.html
## x10
fastp -w 10 -l 36 -i ./1S/1S_R1.fq.gz -I ./1S/1S_R2.fq.gz -o 1S_1.fq -O 1S_2.fq -j 1S.json -h 1S.html
tophat2 -G Zea_mays.AGPv4.36.chr.gtf -p 10 --library-type fr-firststrand -o 1S.tophat Zea_mays.AGPv4.dna.toplevel.fa 1S_1.fq 1S_2.fq
samtools view -H 1S.tophat/accepted_hits.bam >1S.tophat/header.sam
samtools view 1S.tophat/accepted_hits.bam|grep -w "NH:i:1"|cat 1S.tophat/header.sam - |samtools view -bS - >1S.tophat/accepted_hits.unique.bam
## merge the bam file from different platform
samtools merge -@ 4 1S.merge.bam ../43.rna_seq_new/1S_S25_L002.tophat/accepted_hits.unique.bam ../43.rna_x10/1S.tophat/accepted_hits.unique.bam
htseq-count -f bam -r pos -s reverse ./1S.merge.sort.bam Zea_mays.AGPv4.36.chr.gtf >1S.count/1S.merge.reverse.count
Rscript deseq_mp_stem.r