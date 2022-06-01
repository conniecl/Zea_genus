#!usr/bin/perl -w
open IN,"gzip -dc $ARGV[0].fa.gz|" or die "$!";
%hash=();
while(<IN>)
{
    if($_=~/^>/)
    {
        chomp;
        s/>//g;
        $id=$_;
    }
    else
    {
        $hash{$id}.=$_;
    }
}
close IN;
foreach $chr(1..10)
{
    open OUT,">$ARGV[0]_$chr.fa" or die "$!";
    print OUT ">$ARGV[1]\n$hash{$chr}";
    close OUT;
}
