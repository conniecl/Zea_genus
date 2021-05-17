#!usr/bin/perl -w
open IN,"<$ARGV[0].num" or die "$!";
open OUT,">$ARGV[0].format.num" or die "$!";
print OUT "lon\tlat\tvalue\n";
$header=<IN>;
$header=~s/\"//g;
chomp($header);
@array=split("\t",$header);
while(<IN>)
{
    s/\"//g;
    chomp;
    @tmp=split("\t",$_);
    foreach $i(1..$#tmp)
    {
        if($tmp[$i] ne "NA")
        {
            print OUT "$tmp[0]\t$array[$i-1]\t$tmp[$i]\n";
        }
    }
}
close IN;
close OUT;
