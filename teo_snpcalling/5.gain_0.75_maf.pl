#!usr/bin/perl -w
open IN,"<04.remerge/merge_recall.vcf" or die "cannot open the file $!";
open OUT,">merge_recall_0.75.pos" or die "cannot open the file $!";
print OUT "chr\tpos\tmissingrate\n";
while(<IN>)
{
    chomp;
    if($_!~/^#/)
    {
        @tmp=split("\t",$_);
        $count=0;
        foreach $i(9..$#tmp)
        {
            if($tmp[$i] eq "\./\.")
            {
                $count++;
            }
        }
        if($count==0)
        {
            print OUT "$tmp[0]\t$tmp[1]\t0\n";
        }
                else
                {
                        $rate=$count/183;
                        if($rate<=0.75)
                        {
                                print OUT "$tmp[0]\t$tmp[1]\t$rate\n"
                        }
                }
    }
}
close IN;
close OUT;
