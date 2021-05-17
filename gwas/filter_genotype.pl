#!usr/bin/perl -w
open IN,"<../teo_$ARGV[0].merge.hmp" or die "cannot open the file $!";
open OUT,">teo_$ARGV[0].genotype.hmp" or die "cannot open the file $!";
$header=<IN>;
print OUT "$header";
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    %hash=(); $flag=0;
    foreach $i(11..$#tmp)
    {
        $hash{$tmp[$i]}+=1;
    }
    foreach $key(keys %hash)
    {
        $rate=$hash{$key}/($#tmp-10);
        if($rate<=0.05)
        {
            $flag=1;
        }
    }
    if($flag==0)
    {
        print OUT "$_\n";
    }
}
close IN;
close OUT;
