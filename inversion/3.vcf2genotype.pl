#!usr/bin/perl -w
open MAP,"<$ARGV[0].map" or die "$!";
@list=();
while(<MAP>)
{
    chomp;
    @tmp=split("\t",$_);
    push @list,$tmp[-1];
}
close MAP;
open LI,"<$ARGV[0].maf.vcf" or die "$!";
%b73=();
while(<LI>)
{
    if($_=~/^\d/)
    {
        chomp;
        @tmp=split("\t",$_,5);
        $b73{$tmp[1]}=$tmp[3];
    }
}
close LI;
open OUT1,">plink/$ARGV[0].ped" or die "$!";
print OUT1 "b73\tb73\t0\t0\t0\t0\t";
foreach $j(0..$#list-1)
{
    print OUT1 "$b73{$list[$j]}\t$b73{$list[$j]}\t";
}
print OUT1 "$b73{$list[-1]}\t$b73{$list[-1]}\n";
open OUT,">$ARGV[0].genotype" or die "$!";
print OUT "@list\n";
open IN,"<$ARGV[0].ped" or die "$!";
while(<IN>)
{
    print OUT1 "$_";
    chomp;
    @tmp=split("\t",$_);
    @first=();@second=();
    foreach $i(6..$#tmp)
    {
        if($i%2==0)
        {
            push @first,$tmp[$i];
        }
        else
        {
            push @second,$tmp[$i];
        }
    }
    foreach $m(0..$#first-1)
    {
        if($first[$m] eq $b73{$list[$m]})
        {
            print OUT "0 ";
        }
        else
        {
            print OUT "1 ";
        }
    }
    if($first[-1] eq $b73{$list[$.-1]})
    {
        print OUT "0\n";
    }
    else
    {
        print OUT "1\n";
    }
    foreach $m(0..$#second-1)
    {
        if($second[$m] eq $b73{$list[$m]})
        {
            print OUT "0 ";
        }
        else
        {
            print OUT "1 ";
        }
    }
    if($second[-1] eq $b73{$list[$.-1]})
    {
        print OUT "0\n";
    }
    else
    {
        print OUT "1\n";
    }
}
close OUT;
