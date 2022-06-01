#!usr/bin/perl -w
open IN,"samtools view $ARGV[0].fast.sort.bam|" or die "$!";
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    $hash{$tmp[9]}=1; #print "$tmp[9]\n"; exit 0;
}
close IN;
open OUT,">$ARGV[0].fasta" or die "$!";
$flag=0;
foreach $key(keys %hash)
{
    $flag++;
    print OUT ">seq$flag\n$key\n";
}
close OUT;
