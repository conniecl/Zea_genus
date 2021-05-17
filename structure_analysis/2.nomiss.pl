#!usr/bin/perl -w
open OUT,">merge_all.nomiss.vcf" or die "$!";
print OUT "##fileformat=VCFv4.2\n";
print OUT "##FORMAT=<ID=GT,Number=1,Type=String,Description=\"Genotype\">\n";
foreach $chr(1..10)
{
    open IN,"<../merge_${chr}_filter.vcf" or die "$!";
    while(<IN>)
    {
        chomp;
        if($_=~/^#CHROM/)
        {
            if($chr==1)
            {
                print OUT "$_\n";
            }
        }
        if($_=~/^\d/)
        {
            @tmp=split("\t",$_);
            $count=0;
            foreach $i(9..$#tmp)
            {
                if($tmp[$i]=~/\.\/\./)
                {
                    $count++;
                }
            }
            if($count==0 && length($tmp[4])==1)
            {
                foreach $m(0..$#tmp-1)
                {
                    print OUT "$tmp[$m]\t";
                }
                print OUT "$tmp[-1]\n";
            }
        }
    }
    close IN;
}
close OUT;
