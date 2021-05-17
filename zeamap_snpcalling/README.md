### scripts used to trim reads, align to reference genome, snp calling, variants combining and filtering
```bash
sh snp_calling.sh $file ##change $file to the sample name
perl filter_snp.pl
perl gain_merge.pl #input the *.snp.filter.vcf
java -Xmx10g -jar GATK.jar -R Zea_mays.AGPv4.dna.toplevel.fa -T UnifiedGenotyper -I $file.fast.recal.sort.bam --genotyping_mode GENOTYPE_GIVEN_ALLELES -alleles merge.all.vcf -o $file.mo.vcf --read_filter BadCigar -glm BOTH -stand_call_conf 30.0 -stand_emit_conf 0 -out_mode EMIT_ALL_SITES ##change $file to the sample name
perl recall_filter.pl $file ##change $file to the sample name
perl gain_sample.pl
perl gain_merge.pl $i #$i=1,2,3...10
perl filter_0.75.pl $i #$i=1,2,3...10
```
