#!usr/bin/perl -w
open IN,"<list" or die "$!";
print OUT ">pipi.lsf" or die "$!";
print OUT "#BSUB -J merge\n";
print OUT "#BSUB -n 1\n";
print OUT "#BSUB -R span[hosts=1]\n";
print OUT "#BSUB -e merge.err\n";
print OUT "#BSUB -o merge.out\n";
print OUT "#BSUB -q normal\n";
print OUT "java -Xmx50g -jar GATK.jar -R Zea_mays.AGPv4.dna.toplevel.fa -T CombineVariants ";
while(<IN>)
{
    chomp;
    print OUT "--variant ../01.filter/$_.snp.filter.vcf "
}
print OUT "-o merge.all.vcf\n";
close IN;
close OUT;
