#!usr/bin/perl -w
open IN,"<$ARGV[0].31.count.tsv" or die "$!";
open OUT,">$ARGV[0].fa" or die "$!";
while(<IN>)
{
    chomp;
    @tmp=split/\s+/,$_;
    print OUT ">$tmp[1]\n$tmp[0]\n";
}
close IN;
close OUT;

