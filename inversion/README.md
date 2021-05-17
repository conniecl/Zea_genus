## scripts for inversion finding and genotyping
```bash
vcftools --gzvcf ../chr$tmp[0].recode.vcf.gz --keep $ARGV[0] --out $tmp[0].$ARGV[0] --recode --recode-INFO-all\n";
perl 1.maf.pl $tmp[0].$ARGV[0] >$tmp[0].$ARGV[0].out
perl 2.rand_vcf.pl $tmp[0].$ARGV[0] $density
vcftools --vcf $tmp[0].$ARGV[0].rand.vcf --plink --out $tmp[0].$ARGV[0]
perl 3.vcf2genotype.pl $tmp[0].$ARGV[0]
ln -s $tmp[0].$ARGV[0].map plink/$tmp[0].$ARGV[0].map
plink --file ./plink/$tmp[0].$ARGV[0] --out plink/$tmp[0].$ARGV[0]
Rscript ../inveRsion.r $tmp[0].$ARGV[0]
Rscript ../invcluster.r $tmp[0].$ARGV[0]
```
