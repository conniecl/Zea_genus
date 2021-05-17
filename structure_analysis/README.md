## scripts for zeamap snp structure, pca and phylogenetic analysis
```bash
## structure
perl merge.pl
plink --threads 12  --vcf pan.merge.vcf --maf 0.05 --biallelic-only --make-bed --out pan.maf_0.05
plink  --threads 12 --bfile pan.maf_0.05 --indep-pairwise 50 10 0.1 --out pan
plink --threads 12  --bfile pan.maf_0.05 --extract pan.prune.in --make-bed --out pan.strc
admixture --cv=10 pan.strc.bed -j20 $i |tee mexlog$i.out ## $i=2..10
## pca
./gcta/gcta64 --bfile pan.strc --autosome --make-grm --out pan.strc --thread-num 20
./gcta/gcta64 --grm pan.strc --pca 10 --out pan.strc --thread-num 20
## phylogenetic tree
perl 2.nomiss.pl
java -Xmx30g -jar snpEff.jar -c snpEff.config -v B73V4_T01 merge_all.nomiss.vcf >merge_all.nomiss.snpeff
perl 3.filter.pl
snphylo.sh -v merge_all.nomiss.snpeff.filter -P merge_all.nomiss.tree
```
