#!usr/bin/perl -w
$genome=2106338117;
$index=$genome*0.05;
open IN,"<$ARGV[0].spline.$ARGV[1]" or die "$!";
open OUT,">$ARGV[0].top5.gspline.$ARGV[1]" or die "cannot open the file $!";
$length=0;
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    $tmp[2]+=999;
    $length+=($tmp[2]-$tmp[1]+1);
    if($length<=$index)
    {
        print OUT "$tmp[0]\t$tmp[1]\t$tmp[2]\t$tmp[3]\t$tmp[4]\t$tmp[5]\n";
    }
    else
    {
        exit 0;
    }
}
close IN;
close OUT;
