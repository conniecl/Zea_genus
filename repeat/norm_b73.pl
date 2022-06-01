#!usr/bin/perl -w
open IN,"<zea_te.norm.matrix" or die "$!";
readline IN;
while(<IN>)
{
    if($_=~/^B73/)
    {
        chomp;
        @b73=split("\t",$_);
    }
}
close IN;
open FI,"<divi_b73" or die "$!";
readline FI;
%hash=();
while(<FI>)
{
    chomp;
    $sample=(split("\t",$_))[0];
    $hash{$sample}=1;
}
close FI;
open LI,"<zea_te.norm.matrix" or die "$!";
open OUT,">zea_te.b73.norm.matrix" or die "$!";
$header=<LI>;
print OUT "$header";
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    if(exists $hash{$tmp[0]})
    {
        print OUT "$tmp[0]\t";
        foreach $i(1..$#tmp)
        {
            $norm=$tmp[$i]/$b73[$i];
            print OUT "$norm\t";
        }
        print OUT "\n";
    }
}
close LI;
close OUT;
