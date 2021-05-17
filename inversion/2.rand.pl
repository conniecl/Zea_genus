#!usr/bin/perl -w
open NU,"<$ARGV[0].out" or die "$!";
while(<NU>)
{
    if($_=~/^the/)
    {
        chomp;
        $total=(split/:/,$_)[1];
    }
}
close NU;
%hash=();
while((keys %hash)<$ARGV[1])
{
    $hash{int(rand($total))}=1;
}
open IN,"<$ARGV[0].maf.vcf" or die "$!";
open OUT,">$ARGV[0].rand.vcf" or die "$!";
while(<IN>)
{
    if($_=~/^#/)
    {
        print OUT "$_";
    }
    else
    {
        if(exists $hash{$.-11})
        {
            print OUT "$_";
        }
    }
}
close IN;
close OUT;
