#!usr/bin/perl -w
open FI,"</public/home/lyluo/pan/01.recall/$ARGV[0].recall.filter.vcf" or die "$!";
foreach $i(1..10)
{
    open $fh{$i},">$i/$ARGV[0].recall.filter.vcf" or die "$!";
}
while(<FI>)
{
    if($_=~/^\d/)
    {
        @tmp=split("\t",$_,2);
        $fh{$tmp[0]}->print("$_");
    }
    else
    {
        foreach $j(1..10)
        {
            $fh{$j}->print("$_");
        }
    }
}
close FI;
