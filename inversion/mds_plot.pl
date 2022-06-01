#!usr/bin/perl -w
open OUT,">$ARGV[0]_mds.plot" or die "$!";
print OUT "chr\tpos\tstart\tend\tmds1\tmds2\ttype\n";
@file=qw/mds1_max mds1_min mds2_max mds2_min/;
foreach $chr(1..10)
{
    open IN,"<$ARGV[0]_$chr.mds" or die "$!";
    %hash=();
    while(<IN>)
    {
        chomp;
        @tmp=split("\t",$_,2);
        $hash{$tmp[0]}=$tmp[1];
    }
    close IN;
    %candidate=();
    foreach $in(@file)
    {
        open LI,"<$ARGV[0].$in.range" or die "$!";
        while(<LI>)
        {
            chomp;
            @tmp=split("\t",$_);
            $candidate{$tmp[0]}{$tmp[1]}.=$in;
        }
        close LI;
    }
    open FI,"<${chr}_104.pos" or die "$!";
    while(<FI>)
    {
        chomp;
        @tmp=split("\t",$_,2);
        print OUT "chr$chr\t$_\t$hash{$tmp[0]}\t";
        if(exists $candidate{$chr}{$tmp[0]})
        {
            print OUT "$candidate{$chr}{$tmp[0]}\n";
        }
        else
        {
            print OUT "background\n";
        }
    }
    close FI;
}
close OUT;
