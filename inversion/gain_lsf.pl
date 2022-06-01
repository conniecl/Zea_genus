#!usr/bin/perl -w
foreach $i(1..10)
{
open OUT,">$i.$ARGV[0].lsf" or die "$!";
print OUT "#BSUB -J $i.$ARGV[0]\n";
print OUT "#BSUB -n 1\n";
print OUT "#BSUB -R span[hosts=1]\n";
print OUT "#BSUB -o $i.$ARGV[0].out\n";
print OUT "#BSUB -e $i.$ARGV[0].err\n";
print OUT "#BSUB -q short\n";
#print OUT "perl vcf2num.pl $ARGV[0] $i\n";
#print OUT "Rscript pca_win104.r $ARGV[0]_$i\n";
print OUT "perl physical_pos.pl $i\n";
#print OUT "Rscript chr_dis.r $ARGV[0]_$i\n";
#print OUT "Rscript mds_plot.r $ARGV[0]_$i $i\n";
close OUT;
}
