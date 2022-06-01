#!usr/bin/perl -w
@sample=qw/7S 2S 10S 11S 1S 9S/;
open OUT,">stem_mexpar_count.matrix" or die "$!";
print OUT "\t";
foreach $in(@sample)
{
    open IN,"<$in.count/$in.merge.reverse.count" or die "$!";
    while(<IN>)
    {
        chomp;
        @tmp=split("\t",$_);
        if($_!~/^_/)
        {
            $hash{$tmp[0]}{$in}=$tmp[1];
            $gene{$tmp[0]}=1;
        }
    }
    close IN;
}
foreach $i(0..$#sample-1)
{
    print OUT "$sample[$i]\t";
}
print OUT "$sample[-1]\n";
@gene_list=keys %gene;
foreach $key1(@gene_list)
{
    $sum=0;
    foreach $key2(0..$#sample)
    {
        $sum+=$hash{$key1}{$sample[$key2]};
    }
    if($sum!=0)
    {
        print OUT "$key1\t";
        foreach $key2(0..$#sample-1)
        {
            print OUT "$hash{$key1}{$sample[$key2]}\t";
        }
        print OUT "$hash{$key1}{$sample[-1]}\n";
    }
}
close OUT;
