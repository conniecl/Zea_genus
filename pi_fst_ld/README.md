##nuclear diversity, change the input to the species you want ot test
angsd -bam ${BAMLIST}  -doMaf 1 -doMajorMinor 1 -uniqueOnly 1 -minMapQ 30 -minQ 20 -minInd ${nInd} -doSaf 1 -anc Zea_mays.AGPv4.dna.toplevel.fa -GL 2 -out ${OUTFILE} -fold 1 -P 20
realSFS ${OUTFILE}.saf.idx -P 20 > ${OUTFILE}.sfs
angsd -bam ${BAMLIST}  -doMaf 1 -doMajorMinor 1 -uniqueOnly 1 -minMapQ 30 -minQ 20 -minInd ${nInd} -doSaf 1 -anc Zea_mays.AGPv4.dna.toplevel.fa -GL 2 -out ${OUTFILE} -fold 1 -doThetas 1 -pest ${OUTFILE}.sfs -P 20
thetaStat do_stat ${OUTFILE}.thetas.idx -nChr ${nInd} -win 5000 -step 5000 -outnames ${OUTFILE}.thetasWindow5kb
##Fst,change the chr and species you want ot test
vcftools --gzvcf merge_${i}_filter.vcf.gz --weir-fst-pop par --weir-fst-pop nic --fst-window-size 5000 --out chr$i.par.nic.5k 
##LD, change the chr and species you want ot test
plink --keep $ARGV[0] --threads 10 --geno 0.5 --vcf _$i.filter.vcf.gz --maf 0.05 --biallelic-only --snps-only --make-bed --out $ARGV[0]_${i}_0.05
plink --threads 10 --bfile $ARGV[0]_${i}_0.05 --ld-window-kb 500 --ld-window 999999 --r2 gz --ld-window-r2 0 --out $ARGV[0]_$i