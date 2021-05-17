#!usr/bin/perl -w
open IN,"<teo_$ARGV[0].merge.vcf" or die "cannot open the file $!";
open OUT,">teo_$ARGV[0].merge.hmp" or die "cannot open the file $!";
while(<IN>)
{
    chomp;
    if($_=~/^#CHROM/)
    {
        @tmp=split("\t",$_);
        print OUT "rs#\talleles\tchrom\tpos\tstrand\tassembly#\tcenter\tprotLSID\tassayLSID\tpanelLSID\tQCdode\t";
        foreach $i(9..$#tmp-1)
        {
            print OUT "$tmp[$i]\t";
        }
        print OUT "$tmp[-1]\n";
    }
    if($_=~/^\d/)
    {
        @tmp=split("\t",$_);
        if(length($tmp[4])==1)
        {
            $base{0}=$tmp[3];
            $base{1}=$tmp[4];
            print OUT "chr$tmp[0].S_$tmp[1]\t$tmp[3]/$tmp[4]\t$tmp[0]\t$tmp[1]\t+\tAPGV4\tNA\tNA\tNA\tNA\tNA\t";
            foreach $i(9..$#tmp-1)
            {
                @array=split/\|/,(split(":",$tmp[$i],2))[0];
                if(!exists $base{$array[0]} || !exists $base{$array[1]})
                {
                    print OUT "NN\t";
                    print "$_\n";
                }
                else
                {
                    print OUT "$base{$array[0]}","$base{$array[1]}\t";
                }
            }
            @array=split/\|/,(split(":",$tmp[-1],2))[0];
            if(!exists $base{$array[0]} || !exists $base{$array[1]})
            {
                print OUT "NN\t";
                print "$_\n";
            }
            else
            {
                print OUT "$base{$array[0]}","$base{$array[1]}\n";
            }

        }

    }
}
close IN;
close OUT;
