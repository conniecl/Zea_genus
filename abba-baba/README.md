angsd -doAbbababa 1 -blockSize 10000 -anc Tripsacum.fa -doCounts 1 -bam hue_lux -uniqueOnly 1 -minMapQ 30 -minQ 20 -minInd 3 -P 30 -checkBamHeaders 0 -out hue_lux
Rscript jackKnife.R file=hue_lux.abbababa indNames=hue_lux outfile=hue_lux

#DIP test
angsd -doFasta 2 -doCounts 1 -i CIMBL116.fast.sort.bam -out CIMBL116
gzip -dc Tripsacum.fa.gz >Tripsacum.fa
perl split_chr.pl
cat ../5D3_1.fa ../5D5_1.fa ../5D6_1.fa ../5D8_1.fa ../6C3_1.fa ../6H7_1.fa ../CIMBL116_1.fa ../Tripsacum_1.fa >1/1.fa
module load R/3.5.1
Rscript --vanilla DIP/Make_locus_alignments.R "dip/chr/1/" "dip/windows/" "fa" "8" "5000"
Rscript --vanilla DIP.R "fa" "fasta" "dip/windows/" "fa" "4" "parviglumis" "maize" "mexicana" "Tripsacum"

