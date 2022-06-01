#!usr/bin/perl -w
open IN,"<snpeff.class" or die "$!";
open OUT,">zeaspec_anno.type" or die "$!";
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
{
    open IN,"<zea_specficsnp.$chr.anno" or die "$!";
    while(<IN>)
    {
        chomp;
        @tmp=split("\t",$_);
        if($tmp[-1]=~/atac/)
        {
            $count{"cre"}{$tmp[1]}+=1;
            $all{"cre"}+=1;
        }
        elsif($tmp[-1]=~/promoter/)
        {
            $count{"pro"}{$tmp[1]}+=1;
            $all{"pro"}+=1;
        }
        else
        {
            $all{$hash{$tmp[-1]}}+=1;
            $count{$hash{$tmp[-1]}}{$tmp[1]}+=1;
        }
    }
    close IN;
}
foreach $key1(keys %count)
{
    print OUT "$key1\tall\t$all{$key1}\n";
    foreach $key2(keys %{$count{$key1}})
    {
        print OUT "$key1\t$key2\t$count{$key1}{$key2}\n";
    }
    
}
close OUT;
