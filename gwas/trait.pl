#!usr/bin/perl -w
open LI,"<teo_format.loc" or die "$!";
readline LI;
%hash=();
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    if(exists $hash{$tmp[2]}{$tmp[1]})
    {
        $hash{$tmp[2]}{$tmp[1]}=join("\t",$tmp[0],$hash{$tmp[2]}{$tmp[1]}); #lon lat
    }
    else
    {
        $hash{$tmp[2]}{$tmp[1]}=$tmp[0];
    }
}
close LI;
open IN,"<$ARGV[0].format.num" or die "$!";
open OUT,">$ARGV[0].txt" or die "$!";
print OUT "<Trait>\tvalue\n";
readline IN;
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    if(exists $hash{$tmp[0]}{$tmp[1]})
    {
        @array=split("\t",$hash{$tmp[0]}{$tmp[1]});
        foreach $i(0..$#array)
        {
            print OUT "$array[$i]\t$tmp[2]\n";
        }
    }
}
close IN;
close OUT;
