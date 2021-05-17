## scripts for D-statistic analysis
```bash
fastqc -t 2 FCHCTVTCCXY_L4_wHAXPI060032-103_1.fq.gz FCHCTVTCCXY_L4_wHAXPI060032-103_2.fq.gz
java -jar trimmomatic-0.36.jar PE -threads 20 -phred33  FCHCTVTCCXY_L4_wHAXPI060032-103_1.fq.gz FCHCTVTCCXY_L4_wHAXPI060032-103_2.fq.gz FCHCTVTCCXY_L4_wHAXPI060032_1.trimed.fq.gz FCHCTVTCCXY_L4_wHAXPI060032_1.un.fq.gz FCHCTVTCCXY_L4_wHAXPI060032_2.trimed.fq.gz FCHCTVTCCXY_L4_wHAXPI060032_2.un.fq.gz ILLUMINACLIP:adapters.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:76
bowtie2 -q --phred33 --very-fast --end-to-end -p 20 -x Zea_mays.AGPv4.dna.toplevel.fa -1 FCHCTVTCCXY_L4_wHAXPI060032_1.trimed.fq.gz -2 FCHCTVTCCXY_L4_wHAXPI060032_2.trimed.fq.gz -S FCHCTVTCCXY_L4_wHAXPI060032.fast.sam
samtools view -bS FCHCTVTCCXY_L4_wHAXPI060032.fast.sam > FCHCTVTCCXY_L4_wHAXPI060032.fast.bam
samtools sort FCHCTVTCCXY_L4_wHAXPI060032.fast.bam -o FCHCTVTCCXY_L4_wHAXPI060032.fast.sort.bam
angsd -doFasta 2 -doCounts 1 -i FCHCTVTCCXY_L4_wHAXPI060032.fast.sort.bam -out Tripsacum
angsd -doAbbababa 1 -blockSize 10000 -anc Tripsacum.fa -doCounts 1 -bam hue_lux -uniqueOnly 1 -minMapQ 30 -minQ 20 -minInd 3 -P 30 -checkBamHeaders 0 -out hue_lux  ##change the input bam list to the species you want to test
Rscript jackKnife.R file=hue_lux.abbababa indNames=hue_lux outfile=hue_lux
```
