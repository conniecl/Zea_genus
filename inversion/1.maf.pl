#!usr/bin/perl -w
open IN,"<$ARGV[0].recode.vcf" or die "$!";
open OUT,">$ARGV[0].maf.vcf" or die "$!";
$snp=0;
while(<IN>)
{
    if($_!~/^#/)
    {
        chomp;
        @tmp=split("\t",$_);
        %count=();$sample=0;$flag=0;$sum=0;
        foreach $i(9..$#tmp)
        {
            @array=split/\||:/,$tmp[$i];
            $count{$array[0]}+=1;
            $count{$array[1]}+=1;
            $sample+=2;
        }
        foreach $key(keys %count)
        {
            $rate=$count{$key}/$sample;
            if($rate<=0.05)
            {
                $flag=1;
            }
            $sum++;
        }
        if(length($tmp[4])!=1)
        {
            $flag=1;
        }
        if($flag!=1 && $sum>=2)
        {
            print OUT "$_\n";
            $snp++;
        }
    }
    else
    {
        print OUT "$_";
    }
}
print "the number of snp:$snp\n";
close IN;
close OUT;
