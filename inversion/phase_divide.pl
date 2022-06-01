#!usr/bin/perl -w
open IN,"<$ARGV[0].sort.phase1" or die "$!";
while(<IN>)
{
    @tmp=split("\t",$_,6);
    $pos=join("_",$tmp[0],$tmp[3],$tmp[4]);
    if(!exists $fh{$pos})
    {
        open $fh{$pos},">$pos.$ARGV[0]" or die "$!";
    }
    $fh{$pos}->print("$tmp[1]\t$tmp[5]");
}
close IN;
