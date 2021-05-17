#!usr/bin/perl -w
open OUT,">teo_par_mex.prune.out.2.Q";
foreach $i(1..20)
{
    open IN,"<$i/teo_par_mex.prune.out.2.Q" or die "canot open the file $!";
    $j=1;
    while(<IN>)
    {
                chomp;
                @tmp=split/\s+/,$_;
                print OUT "$j\t$j\t(0)\t1\t:\t$tmp[0]\t$tmp[1]\n";
=pod
        if($j<10)
        {
            print OUT "  $j   $j (0) 0 : $_";
        }
        elsif($j<100)
        {
            print OUT " $j  $j (0) 0 : $_";
        }
        else
        {
            print OUT "$j $j (0) 0 : $_";
        }
=cut
        $j++;
    }
        print OUT "\n";
    close IN;
}
close OUT;
