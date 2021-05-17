## scripts for pi, fst, LD
```bash
##nuclear diversity, change the input to the species you want ot test
angsd -bam ${BAMLIST}  -doMaf 1 -doMajorMinor 1 -uniqueOnly 1 -minMapQ 30 -minQ 20 -minInd ${nInd} -doSaf 1 -anc Zea_mays.AGPv4.dna.toplevel.fa -GL 2 -out ${OUTFILE} -fold 1 -P 20
realSFS ${OUTFILE}.saf.idx -P 20 > ${OUTFILE}.sfs
angsd -bam ${BAMLIST}  -doMaf 1 -doMajorMinor 1 -uniqueOnly 1 -minMapQ 30 -minQ 20 -minInd ${nInd} -doSaf 1 -anc Zea_mays.AGPv4.dna.toplevel.fa -GL 2 -out ${OUTFILE} -fold 1 -doThetas 1 -pest ${OUTFILE}.sfs -P 20
thetaStat do_stat ${OUTFILE}.thetas.idx -nChr ${nInd} -win 5000 -step 5000 -outnames ${OUTFILE}.thetasWindow5kb
##Fst,change the chr and species you want ot test
vcftools --gzvcf merge_${i}_filter.vcf.gz --weir-fst-pop par --weir-fst-pop nic --fst-window-size 5000 --out chr$i.par.nic.5k 
##LD, change the chr and species you want ot test
vcftools --vcf merge_1_filter.vcf --keep ./par --out ./merge_1.par --recode --recode-INFO-all
vcftools --vcf merge_1.par.recode.vcf --plink --out 1.par
perl plink2haploview.pl 1.par
perl map2info.pl 1.par
for i in {1..10};
do
perl 500k_haploview.pl $i par
done
perl ld_decay_region.pl par
```
