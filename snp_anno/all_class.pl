#!usr/bin/perl -w
open IN,"<snpeff.class" or die "$!";
open OUT,">zea_anno.type" or die "$!";
while(<IN>)
{
    chomp;
    if($_=~/\+/)
    {
        s/\+/\&/g;
    }
    @tmp=split("\t",$_);
    $hash{$tmp[0]}=$tmp[1];
}
close IN;
foreach $chr(1..10)
{print "$chr\n";
    open IN,"<zea.$chr.anno" or die "$!";
    readline IN;
    while(<IN>)
    {
        chomp;
        @tmp=split("\t",$_);
        if($tmp[0]=~/atac/)
        {
            $count{"cre"}+=$tmp[1];
        }
        else
        {
            $count{$hash{$tmp[0]}}+=$tmp[1];
        }
    }
    close IN;
}
foreach $key(keys %count)
{
    print OUT "$key\t$count{$key}\n";
}
close OUT;
