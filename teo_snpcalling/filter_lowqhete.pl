#!usr/bin/perl -w
open IN,"<03.recall/$ARGV[0].mo.vcf" or die "cannot open the file $!";
open OUT,">$ARGV[0].mod.vcf" or die "cannot open the file $!";
while(<IN>)
{
    chomp;
    if($_=~/^#CHROM/)
    {
        @array=split("\t",$_);
        foreach $i(0..$#array-1)
        {
            print OUT "$array[$i]\t";
        }
        print OUT "teo_","$ARGV[1]\n";
    }
    elsif($_=~/^#/)
    {
        print OUT "$_\n";
    }
    else
    {
        @tmp=split("\t",$_);
        @brray=split(":",$tmp[9]);
                @crray=split("/",$brray[0]);
        if($tmp[6] ne "LowQual" || $crray[0] eq $crray[1])
        {
            print OUT "$_\n";
        }
    }
}
close IN;
close OUT;
