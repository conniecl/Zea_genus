#!usr/bin/perl -w
open IN,"<list" or die "$!";
while(<IN>)
{
chomp;
$i=$_;
open OUT,">$i.lsf" or die "$!";
print OUT "#BSUB -J $i\n";
print OUT "#BSUB -n 1\n";
print OUT "#BSUB -R span[hosts=1]\n";
print OUT "#BSUB -o $i.out\n";
print OUT "#BSUB -e $i.err\n";
print OUT "#BSUB -q normal\n";
print OUT "perl split_sample.pl $i\n";
close OUT;
}
close IN;
