#!usr/bin/perl -w
open IN,"<$ARGV[0]/fa_fa_replicates_2021-05-27.csv" or die "$!";
open OUT,">$ARGV[0].dip" or die "$!";
print OUT "num\ttype\n";
$header=<IN>;
chomp($header);
$header=~s/\"//g;
@array=split(",",$header);
#print "@array\n"; exit 0;
foreach $i(0..$#array)
{
    if($array[$i] eq "deltaK23_reps")
    {
        $k23=$i; #print "$k23\n"; exit 0;
    }
    if($array[$i] eq "deltaK12_reps")
    {
        $k12=$i;
    }
    if($array[$i] eq "deltaK13_reps")
    {
        $k13=$i;
    }
    if($array[$i] eq "delta_delta_reps")
    {
        $ddk=$i;
    }
    if($array[$i] eq "dddK_reps")
    {
        $dddk=$i;
    }
}
while(<IN>)
{
    chomp;
    s/\"//g;
    @tmp=split(",",$_);
    print OUT "$tmp[$k23]\tK23\n$tmp[$k12]\tK12\n$tmp[$k13]\tK13\n";
    print OUT "$tmp[$ddk]\tddk\n$tmp[$dddk]\tdddk\n";
}
close IN;
close OUT;
