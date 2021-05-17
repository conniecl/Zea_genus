#!usr/bin/perl -w
for(1..10)
{
    open $fh{$_},">0.75loci_chr$_.pos" or die "cannot open the file $!";
}
open IN,"<0.75loci.pos" or die "cannot open the file $!";
while(<IN>)
{
    chomp;
    if($_=~/^\d/)
    {
        @tmp=split("\t",$_);
        $fh{$tmp[0]}->print ("$_\n");
    }
}
close IN;
