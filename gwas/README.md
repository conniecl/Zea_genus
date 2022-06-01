for i in {1..10};
do
/public/home/lchen/software/plink_linux_x86_64/plink --keep list --threads 4 -vcf ../../05.imp/teo/teo_$i.gt.vcf.gz --biallelic-only --snps-only --make-bed --out mex_$i
/public/home/lchen/software/plink_linux_x86_64/plink --threads 4 --bfile mex_$i --indep-pairwise 50 10 0.1 --out mex_$i
/public/home/lchen/software/plink_linux_x86_64/plink --threads 4 --bfile mex_$i --extract mex_$i.prune.in --maf 0.05 --biallelic-only --make-bed --out mex_$i.prune
done
/public/home/lchen/software/plink_linux_x86_64/plink --noweb --bfile mex_1.prune --merge-list prune.list --make-bed --out mex.prune --threads 4
## population structure
for i in {1..4};
do
/public/home/lyluo/pan/strc/admixture_linux-1.3.0/admixture --cv=10 mex.prune.bed -j4 $i |tee log$i.out
done
## kinship
perl vcf2noldhmp.pl
perl /public/home/maize/lchen/software/tassel3-standalone/run_pipeline.pl -Xmx100g -fork1 -h mex.nold.hmp -filterAlign -filterAlignMinFreq 0.05 -ck -export mex_kinship.txt -runfork1

## GWAS
perl vcf2hmp.pl
perl gain_lsf.pl
for i in {1..29};
do
bsub < $i.lsf
done

