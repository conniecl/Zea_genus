#!usr/bin/perl -w
open IN,"<$ARGV[0].clu" or die "$!";
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    $hash{$tmp[0]}=$tmp[1];
}
close IN;
#open LI,"<$ARGV[1].eigenvec.format" or die "$!";
open LI,"<$ARGV[1].eigenvec" or die "$!";
open OUT,">$ARGV[0].pca.plot" or die "$!";
print OUT "sample\tPC1\tPC2\ttype\n";
while(<LI>)
{
    chomp;
    @tmp=split/\s+/,$_;
#    print OUT "$_\t$hash{$tmp[0]}\n";
#=pod
    if($tmp[0] ne $tmp[1])
    {
        $sample=join("_",$tmp[0],$tmp[1]);
    }
    else
    {
        $sample=$tmp[0];
    }
    print OUT "$sample\t$tmp[2]\t$tmp[3]\t$hash{$sample}\n";
#=cut
}
close LI;
close OUT;
