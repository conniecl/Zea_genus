#!usr/bin/perl -w
open IN,"<chr$ARGV[0].snp" or die "cannot open the file $!";
%hash=();
while(<IN>)
{
    chomp;
    @tmp=split/\s+/,$_;
    $hash{$tmp[4]}=1; #print "$tmp[0].done\n$tmp[1].done\n$tmp[2].done\n$tmp[3].done\n"; exit 0;
}
close IN;
open FI,"</public/home/lchen/zeamap/05.ld/new/mex" or die "$!";
%par=();
while(<FI>)
{
    chomp;
    $par{$_}=1;
}
close FI;
open FI1,"</public/home/lchen/zeamap/05.ld/new/par" or die "$!";
%maize=();
while(<FI1>)
{
    chomp;
    $maize{$_}=1;
}
close FI1;
open SNP,"</public/home/lchen/zeamap/01.data/final_vcf/merge_$ARGV[0]_filter.vcf" or die "cannot open the file $!";
open OUT,">chr$ARGV[0].par.geno" or die "cannot open the file $!";
open OUT1,">chr$ARGV[0].mex.geno" or die "$!";
@list1=();@list2=();
while(<SNP>)
{
    if($_=~/^#CHROM/)
    {
        chomp;
        @array=split("\t",$_);
        foreach $i(9..$#array)
        {
            if(exists $maize{$array[$i]})
            {
                push @list1,$i;
            }
            if(exists $par{$array[$i]})
            {
                push @list2,$i;
            }
        }
    }
    if($_=~/^\d/)
    {
        chomp;
        @tmp=split("\t",$_);
        if(exists $hash{$tmp[1]})
        {
            foreach $m(0..$#list1-1)
            {
                if($tmp[$list1[$m]]=~/\.\/\./)
                {
                    print OUT "9 9 ";
                }
                else
                {
                    @brray=split/\/|:/,$tmp[$list1[$m]];
                    print OUT "$brray[0] $brray[1] ";
                }
            }
            if($tmp[$list1[-1]]=~/\.\/\./)
            {
                print OUT "9 9\n";
            }
            else
            {
                @brray=split/\/|:/,$tmp[$list1[-1]];
                print OUT "$brray[0] $brray[1]\n";
            }
            foreach $n(0..$#list2-1)
            {
                if($tmp[$list2[$n]]=~/\.\/\./)
                {
                    print OUT1 "9 9 ";
                }
                else
                {
                    @crray=split/\/|:/,$tmp[$list2[$n]];
                    print OUT1 "$crray[0] $crray[1] ";
                }
            }
            if($tmp[$list2[-1]]=~/\.\/\./)
            {
                print OUT1 "9 9\n";
            }
            else
            {
                @crray=split/\/|:/,$tmp[$list2[-1]];
                print OUT1 "$crray[0] $crray[1]\n";
            }
        }
    }
}
close SNP;
close OUT;
close OUT1;
