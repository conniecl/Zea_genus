#!usr/bin/perl -w
=pod
open LI,"<$ARGV[0]" or die "$!";
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    if($tmp[0] eq $tmp[1])
    {
        $hash{$tmp[0]}=1;
    }
    else
    {
        $file=join("_",$tmp[0],$tmp[1]);
        $hash{$file}=1;
    }
}
close LI;
=cut
open LI,"<$ARGV[0]" or die "$!";
while(<LI>)
{
    chomp;
    $hash{$_}=1;
}
close LI;
#open IN,"gzip -dc teo_$ARGV[1].gt.vcf.gz|" or die "$!";
open IN,"gzip -dc maize_$ARGV[1].gt.vcf.gz|" or die "$!";
open OUT,">$ARGV[0]_$ARGV[1].geno" or die "$!";
@list=();
while(<IN>)
{
    chomp;
    if($_=~/^#CHROM/)
    {
        @array=split("\t",$_);
        foreach $i(9..$#array)
        {
            if(exists $hash{$array[$i]})
            {
                push @list,$i;
            }
        }
    }
    if($_=~/^\d/)
    {
        @tmp=split("\t",$_);
        $len=length($tmp[4]);
        if($len==1)
        {
            print OUT "$tmp[1]\t$tmp[2]\t";
            foreach $i(0..$#list-1)
            {
                @brray=split/\||\:/,$tmp[$list[$i]];
                print OUT "$brray[0]\t$brray[1]\t";
            }
            @brray=split/\||\:/,$tmp[$list[-1]];
            print OUT "$brray[0]\t$brray[1]\n";
        }
        
    }
}
close IN;
close OUT;
