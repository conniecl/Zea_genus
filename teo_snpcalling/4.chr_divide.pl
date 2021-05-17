#!/usr/bin/perl -w
open IN,"<04.remerge/merge_recall.vcf" or die "cannot open the file $!";
for(1..10)
{
    open $fh{$_},">chr$_.vcf" or die "cannot open the file $!";
}
while(<IN>)
{
    chomp;
    if($_=~/^#/)
    {
        foreach $i(1..10)
        {
            $fh{$i}->print( "$_\n" );
        }
    }
    if($_=~/^\d/)
    {
        @tmp=split/\s+/,$_,2;
        $fh{$tmp[0]}->print ("$_\n");
    }
}
close IN;
