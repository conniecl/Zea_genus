#!usr/bin/perl -w
open IN,"<$ARGV[0]/fa_fa_locus_data_2021-05-27.csv" or die "$!";
open OUT,">$ARGV[0].tree.num" or die "$!";
print OUT "tree\tnum\n";
readline IN;
while(<IN>)
{
    if($_!~/NA/)
    {
    chomp;
    @tmp=split/\"/,$_;
    $tmp[7]=~s/:-\d\.\d+e-\d+//g;
    $tmp[7]=~s/:-\d\.\d+//g;
    $tmp[7]=~s/:\d\.\d+e-\d+//g;
    $tmp[7]=~s/:\d\.\d+//g;
    $tmp[7]=~s/:\d//g;
    $hash{$tmp[7]}+=1;
    }
}
close IN;
foreach $key(keys %hash)
{
    print OUT "$key\t$hash{$key}\n";
}
close OUT;
