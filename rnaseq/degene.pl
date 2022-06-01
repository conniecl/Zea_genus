#!usr/bin/perl -w
open LI,"<stem_mexpar_count.matrix" or die "$!";
readline LI;
%hash=();
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_,2);
    $hash{$tmp[0]}=$tmp[1];
}
close LI;
open IN,"<stem_mexpar.deseq" or die "$!";
open OUT,">stem_mexpar.loose.degene" or die "$!";
print OUT "id\tbaseMean\tlog2FoldChange\tlfcSE\tstat\tpvalue\tpadj\tparS\tparS\tparS\tmexS\tmexS\tmexS\n";
readline IN;
while(<IN>)
{
    chomp;
    @tmp=split/\s+/,$_;
    #if($tmp[2]>2 || $tmp[2]<-2)
    if($tmp[2]>1|| $tmp[2]<-1)
    {
        #if($tmp[-1] ne "NA" && $tmp[-1]<0.01)
        if($tmp[-1] ne "NA" && $tmp[-1]<0.05)
        {
            print OUT "$_\t$hash{$tmp[0]}\n";
        }
    }
}
close IN;
close OUT;
