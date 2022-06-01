#!usr/bin/perl -w
open IN,"<$ARGV[0].$ARGV[1].sort.nei" or die "$!";
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    $start{$tmp[0]}{$tmp[1]}=$tmp[3];
}
close IN;
open LI,"<teo_candidate.bed" or die "$!";
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    if($tmp[4] eq $ARGV[0] && $tmp[5] eq $ARGV[1])
    {
        foreach $key1(keys %{$start{$tmp[0]}})
        {
            if($key1>=$tmp[1] && $key1<=$tmp[2])
            {
                $region{$tmp[0]}{$start{$tmp[0]}{$key1}}=1;
            }
        }
    }
}
close LI;
open OUT,">$ARGV[0].$ARGV[1].range" or die "$!";
foreach $key1(sort{$a<=>$b} keys %region)
{
    foreach $key2(sort{$a<=>$b} keys %{$region{$key1}})
    {
        print OUT "$key1\t$key2\n";
    }
}
close OUT;
