#!usr/bin/perl -w
open IN,"<$ARGV[0]/$ARGV[1].nold.marker" or die "cannot open the file $!";
%dict=();
while(<IN>)
{
    chomp;
    $dict{$_}=1;
}
close IN;
open LI,"</public/home/lchen/zeamap/05.ld/new/$ARGV[1].$ARGV[0]_haploview.info" or die "cannot open the file $!";
%hash=();
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    if(exists $dict{$tmp[0]})
    {
        $hash{$tmp[1]}=$tmp[0];
    }
}
close LI;
open SNP,"</public/home/lchen/zeamap/01.data/final_vcf/merge_$ARGV[1]_filter.vcf" or die "cannot open the file $!";
open OUT2,">$ARGV[0]/chr$ARGV[1].nold" or die "$!";
while(<SNP>)
{
    if($_=~/^\d/)
    {
        chomp;
        @tmp=split("\t",$_);
        $len=length($tmp[4]);
        if(exists $hash{$tmp[1]} && $len==1)
        {
            print OUT2 "$tmp[0]\t$tmp[1]\t$tmp[3]\t$tmp[4]\n";
        }
    }
}
close SNP;
close OUT2;
