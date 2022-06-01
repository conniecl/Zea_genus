#!usr/bin/perl -w
open IN,"gzip -dc /public/home/lchen/zeamap/31.data_add/05.imp/teo/teo_$ARGV[0].gt.vcf.gz|" or die "$!";
open OUT,">teo_$ARGV[0].ref.vcf" or die "$!";
while(<IN>)
{
    if($_=~/^#CHROM/)
    {
        chomp;
        print OUT "$_\tB73\n";
    }
    elsif($_=~/^\d/)
    {
        chomp;
        print OUT "$_\t0|0\n";
    }
    else
    {
        print OUT "$_";
    }
}
close IN;
close OUT;
