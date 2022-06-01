#!usr/bin/perl -w
open OUT,">pan.merge.vcf" or die "cannot open the file $!";
open IN,"<merge_1_filter.vcf" or die "canot open the file $!";
while(<IN>)
{
    print OUT "$_";
}
close IN;
foreach $i(2..10)
{
    open IN,"<merge_${i}_filter.vcf" or die "canot open the file $!";
    while(<IN>)
    {
        if($_=~/^\d/)
        {
            print OUT "$_";
        }
    }
    close IN;
}
close OUT;
