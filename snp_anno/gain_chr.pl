#!usr/bin/perl -w
foreach $i(1..10)
{
open OUT,">$i.a.lsf" or die "$!";
print OUT "#BSUB -J $i.a\n";
print OUT "#BSUB -n 1\n";
print OUT "#BSUB -R span[hosts=1]\n";
print OUT "#BSUB -o $i.a.out\n";
print OUT "#BSUB -e $i.a.err\n";
print OUT "#BSUB -q q2680v2\n";
#print OUT "java -Xmx30g -jar /public/home/maize/software/software/snpEff/snpEff.jar -c /public/home/maize/software/software/snpEff/snpEff.config -v B73V4_T01 /public/home/lchen/zeamap/31.data_add/04.merge/snp/merge_new/merge_$i.filter.vcf.gz >zea.$i.snpeff\n";
#print OUT "bedtools intersect -b chr$i.scatac.sort.bed -a /public/home/lchen/zeamap/31.data_add/04.merge/snp/merge_new/merge_$i.filter.vcf.gz -header >merge_$i.atac.vcf\n";
#print OUT "perl anno.pl $i\n";
#print OUT "perl anno_count.pl $i\n";
print OUT "gzip zea_specficsnp.$i.anno.num\n";
close OUT;
}
