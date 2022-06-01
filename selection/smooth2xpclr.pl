#!usr/bin/perl -w
use List::Util qw/sum/;
open IN,"<chr$ARGV[0].spline" or die "$!";
readline IN;
@list=();@wstatic=();
while(<IN>)
{
    chomp;
    @tmp=split/\s+/,$_;
    if($tmp[2]>0)
    {
        push @list,$tmp[2];
        push @wstatic,$tmp[-1];
    }
}
close IN;
print "$list[-1]\n";
open LI,"<chr$ARGV[0].1k.mask.xpclr.txt" or die "$!";
$i=0;
@pos=();@score=();
open OUT,">chr$ARGV[0].xpclr.spline" or die "$!";
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    if($tmp[-1]!~/inf|nan/)
    {
        $count++;
        push @pos,$tmp[1];
        push @score,$tmp[-1];
    }
    if($count==$list[$i])
    {
        $avg=sum(@score)/scalar(@score);
        print OUT "$tmp[0]\t$pos[0]\t$pos[-1]\t$count\t$avg\t$wstatic[$i]\n";
        $count=0;
        $i+=1;
        @pos=();@score=();
    }
}
close LI;
close OUT;
