### scripts for eGWAS
```bash
## combine the teosinte SNPs file
for i in {2..10};
do
       grep -v "^#" ../06.imputation/chr${i}.recode.vcf >chr${i}.noheader.vcf;
done
cat ../06.imputation/chr1.recode.vcf chr2.noheader.vcf chr3.noheader.vcf chr4.noheader.vcf chr5.noheader.vcf chr6.noheader.vcf chr7.noheader.vcf chr8.noheader.vcf chr9.noheader.vcf chr10.noheader.vcf >teo_imputation.vcf
## extract genotype from mexicana, parviglumis and teosinte mix
vcftools --vcf teo_imputation.vcf --keep Z.par_mex.list --out ./teo_par_mex --recode --recode-INFO-all
perl vcf2hmp_biallele.pl par_mex
perl filter_genotype.pl par_mex
vcftools --vcf teo_par_mex.recode.vcf --plink --out teo_par_mex
## filter the LD and structure calculation
plink --file teo_par_mex --indep-pairwise 50 10 0.1 --out teo_par_mex
plink --threads 19 --file ../teo_par_mex --extract ../teo_par_mex.prune.in --maf 0.05 --biallelic-only --make-bed --out teo_par_mex.prune
admixture teo_par_mex.prune.bed -s $i -j20 2|tee log$i.out #i=1,2,3...20
perl combine.pl
./CLUMPP paramfile ##edit the input, output, k
## kinship calculation
perl /public/home/maize/lchen/software/tassel3-standalone/run_pipeline.pl -Xmx100g -fork1 -h teo_par_mex.nold.hmp -filterAlign -filterAlignMinFreq 0.05 -ck -export mex_par_kinship.txt -runfork1
## soil traits obtaination
ncatt_get(nc=nc,varid='lat') ##obtain the latitude attribution
ncatt_get(nc=nc,varid='lon') ##obtain the longitude attribution
perl loc_detail.pl
perl gain_pbs.pl
perl gain_fpbs.pl
## perform GWAS (MLM)
perl /public/home/maize/lchen/software/tassel3-standalone/run_pipeline.pl -Xmx100g -fork1 -h ../01.filter/teo_par_mex.genotype.hmp -filterAlign -filterAlignMinFreq 0.05 -fork2 -r ../trait.txt -fork3 -q ./teo_par_strc.txt -fork4 -k ../mex_par_kinship.txt -combine5 -input1 -input2 -input3 -intersect -combine6 -input5 -input4 -mlm -mlmVarCompEst P3D -mlmCompressionLevel None -mlmOutputFile mex_par -export mex_par -runfork1 -runfork2 -runfork3 -runfork4
```
