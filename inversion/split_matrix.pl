#!usr/bin/perl -w
open IN,"<$ARGV[0].matrix" or die "$!";
$flag=1;
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    if(!exists $fh{$tmp[0]})
    {
        open $fh{$tmp[0]},">$tmp[0].$ARGV[0].matrix1" or die "$!";
    }
    $end=$tmp[1]+500000;
    $fh{$tmp[0]}->print("$tmp[0]\t$tmp[1]\t$end\tinv$flag\t$tmp[1]\t$tmp[2]\n");
    $flag++;
    $size=int(($tmp[2]-$tmp[1])/500000)-1;
    foreach $i(1..$size)
    {
        $start=$i*500000+$tmp[1]+1;
        $end=($i+1)*500000+$tmp[1];
        $fh{$tmp[0]}->print("$tmp[0]\t$start\t$end\tinv$flag\t$tmp[1]\t$tmp[2]\n");
        $flag++;
    }
    $end=$end+1;
    $fh{$tmp[0]}->print("$tmp[0]\t$end\t$tmp[2]\tinv$flag\t$tmp[1]\t$tmp[2]\n");
    $flag++;
    
}
close IN;
