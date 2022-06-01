#!usr/bin/perl -w
open IN,"</public/home/lchen/zeamap/31.data_add/04.merge/snp/merge_new/zeamap_snp.rmmix.loc" or die "$!";
%hash=();
while(<IN>)
{
    chomp;
    @tmp=split/\:|\s+/,$_;
    if($tmp[0] eq $ARGV[0])
    {
        $hash{$tmp[1]}{$tmp[2]}=$tmp[3];
    }
}
close IN;
@file=qw/dip hue lux mex nic par per tem tst/;
@pop=qw/diploperennis huehuetenangensis luxurians mexicana nicaraguensis parviglumis perennis TEM TST/;
foreach $i(0..$#file)
{
    $convert{$file[$i]}=$pop[$i];
}
foreach $in(@file)
{
    open FI,"</public/home/lchen/zeamap/31.data_add/04.merge/snp/merge_new/merge_$ARGV[0].$in.frq" or die "$!";
    readline FI;
    while(<FI>)
    {
        chomp;
        @tmp=split/_|\s+/,$_; #print "$tmp[-5]\t$tmp[-1]\t$in\t$convert{$in}\n"; exit 0;
        if(exists $hash{$tmp[-5]}{$convert{$in}})
        {
            $count{$tmp[-5]}{$convert{$in}}=$tmp[-1]/2;
        }
    }
    close FI;
}
open LI,"<zea_specficsnp.$ARGV[0].anno" or die "$!";
open OUT,">zea_specficsnp.$ARGV[0].anno.num" or die "$!";
print OUT "pos\tpop\tregion\tind\tgenotyped\n";
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    print OUT "$_\t$hash{$tmp[0]}{$tmp[1]}\t$count{$tmp[0]}{$tmp[1]}\n";
}
close LI;
close OUT;
