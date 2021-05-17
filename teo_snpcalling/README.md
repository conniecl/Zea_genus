## scripts for teosinte SNP combining and imputation
```bash
## snp combining
perl 1.snp_merge.pl #merge the raw filtering SNPs to one file
perl 2.gain_pbs.pl #recall the SNPs based on the above site and filtering the heterozygous SNPs with LowQual
perl 3.snp_merge.pl #merge the recall SNPs to one file
perl 4.chr_divide.pl #split the merged recall SNPs file to different chromosome
## obtain the site with missing rate higher than 0.75
perl 5.gain_0.75_maf.pl
cut -f 1,2 merge_recall_0.75.pos >0.75loci.pos
sed -i "/pos/d" 0.75loci.pos
perl 6.0.75pos_divide.pl
## imputation
for i in {1..10};
do
       java -Xss5m -Xmx100g -jar beagle.r1399.jar gt=chr$i.vcf out=chr$i.gt nthreads=19 window=50000 overlap=5000 ibd=true
done
## filter the site with missing rate higher than 0.75
for i in {1..10}
do
       vcftools --gzvcf chr${i}.gt.vcf.gz --positions 0.75loci_chr$i.pos --out ./chr${i} --recode --recode-INFO-all
done
```
