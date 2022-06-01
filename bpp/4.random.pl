#!usr/bin/perl -w
open LI,"<sample.list" or die "$!";
%sample=();$sum=0;
while(<LI>)
{
    chomp;
    @tmp=split/\s+/,$_;
    $sample{$tmp[0]}=$tmp[1];
    $sum++;
}
close LI;

%seq=();
foreach $in(keys %sample)
{
    open IN,"<../$in.cds.fa" or die "$!";
    while(<IN>)
    {
        chomp;
        if($_=~/^>/)
        {
            $id=(split/\s+/,$_)[0];
        }
        else
        {
            $seq{$id}{$in}.=$_;
        }
    }
}
@data=();%len=();
foreach $key1(keys %seq)
{
    push @data,$key1;
    $len{$key1}=length($seq{$key1}{"tri_3"});
    foreach $key2(keys %{$seq{$key1}})
    {
        $seq{$key1}{$key2}=~tr/N/?/;
    }
}
%hash=();
while((keys %hash)<2000)
{
    $hash{int(rand($#data+1))}=1;
}
open OUT,">rand.seq" or die "$!";
foreach $v(keys %hash)
{
    print OUT "$sum $len{$data[$v]}\n";
    print "$data[$v]\n";
    print OUT "\n";
    foreach $key2(sort{$a cmp $b} keys %{$seq{$data[$v]}})
    {
        print OUT "^$key2\t\t$seq{$data[$v]}{$key2}\n";
    }
    print OUT "\n";

}
close OUT;
open OUT1,">rand.imap.txt" or die "$!";
foreach $m(sort{$a cmp $b} keys %sample)
{
    print OUT1 "$m\t$sample{$m}\n";
}
close OUT1;
