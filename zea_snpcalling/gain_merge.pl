#!usr/bin/perl -w
open IN,"<list" or die "$!";
print OUT ">$ARGV[0]/merge_gatk.txt" or die "$!";
print OUT "#BSUB -J merge_$ARGV[0]\n";
print OUT "#BSUB -n 1\n";
print OUT "#BSUB -R span[hosts=1]\n";
print OUT "#BSUB -e merge_$ARGV[0].err\n";
print OUT "#BSUB -o merge_$ARGV[0].out\n";
print OUT "#BSUB -q normal\n";
print OUT "java -Xmx50g -jar /public/home/lyluo/software/GenomeAnalysisTK-3.5/GATK.jar -R /public/home/lyluo/rnaref/Zea_mays.AGPv4.dna.toplevel.fa -T CombineVariants ";
while(<IN>)
{
    chomp;
    print OUT "--variant $_.recall.filter.vcf "
}
print OUT "-o merge_$ARGV[0].vcf -genotypeMergeOptions UNIQUIFY\n";
close IN;
close OUT;