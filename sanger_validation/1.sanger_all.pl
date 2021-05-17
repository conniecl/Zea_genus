#!usr/bin/perl -w
open IN,"<../sanger.fa" or die "$!";
while(<IN>)
{
    chomp;
    if($_=~/^>/)
    {
        $id=$_;
    }
    else
    {
        $hash{$id}.=$_;
    }
}
close IN;
open OUT,">sanger_all.fa" or die "$!";
open IN2,"<../sanger_b73" or die "$!";
while(<IN2>)
{
    print OUT "$_";
}
close IN2;
foreach $key(keys %hash)
{
        $hash{$key}=uc($hash{$key});
        $hash{$key}=~tr/ATCG/TAGC/;
        $hash{$key}=reverse($hash{$key});
        print OUT "$key\n$hash{$key}\n";
}
close OUT;
