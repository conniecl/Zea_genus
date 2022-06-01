#!usr/bin/perl -w
open IN,"<snpeff.class" or die "$!";
open OUT,">zeaspec_rmsiganno.type" or die "$!";
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
    open IN,"<zea_specficsnp.$chr.anno.num" or die "$!";
    readline IN;
    while(<IN>)
    {
        chomp;
        @tmp=split("\t",$_);
        if($tmp[3]>1)
        {
            if($tmp[2]=~/atac/)
            {
                $count{"cre"}{$tmp[1]}+=1;
                $all{"cre"}+=1;
            }
            elsif($tmp[2]=~/promoter/)
            {
                $count{"pro"}{$tmp[1]}+=1;
                $all{"pro"}+=1;
            }
            else
            {
                $all{$hash{$tmp[2]}}+=1;
                $count{$hash{$tmp[2]}}{$tmp[1]}+=1;
            }
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
