#!usr/bin/perl -w
open IN,"<$ARGV[0].output/contigs.fasta.out" or die "$!";
print scalar <IN> for(1..3);
while(<IN>)
{
    chomp;
    @tmp=split/\s+/,$_; #print "$tmp[5]\n"; exit 0;
    $_=~/CL(\d+)Cont/;
    $name=$1;
    if($tmp[9] eq "C" || $tmp[9] eq "+")
    {$hash{$name}{$tmp[11]}+=1;}
    else
    {$hash{$name}{$tmp[10]}+=1;}
}
close IN;
foreach $key1(keys %hash)
{
    $flag="";$max=0;
    foreach $key2(keys %{$hash{$key1}})
    {
        if($hash{$key1}{$key2}>$max)
        {
            $flag=$key2;
            $max=$hash{$key1}{$key2};
        }
    }
    $mask{$key1}=$flag;
}
open LI,"<$ARGV[0].output/CLUSTER_TABLE.csv" or die "$!";
open OUT,">$ARGV[0].output/CLUSTER_TABLE.repeatmasker.csv" or die "$!";
while(<LI>)
{
    if($_=~/^\d/)
    {
        chomp;
        @tmp=split("\t",$_,2);
        if(exists $mask{$tmp[0]})
        {
            print OUT "$_\t$mask{$tmp[0]}\n";
        }
        else
        {
            print OUT "$_\tNA\n";
        }
    }
    else
    {
        print OUT "$_";
    }
}
close LI;
close OUT;
