#!usr/bin/perl -w
open LI,"<list.pop" or die "$!";
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    if($tmp[1] ne "landraces")
    {
        $hash{$tmp[0]}=$tmp[1];
    }
}
close LI;
open IN,"<../$ARGV[0]/merge_$ARGV[0].vcf" or die "$!";
open OUT,">merge_$ARGV[0]_filter.vcf" or die "$!";
print OUT "##fileformat=VCFv4.2\n";
print OUT "##FORMAT=<ID=GT,Number=1,Type=String,Description=\"Genotype\">\n";
@list=();@sample=();
while(<IN>)
{
    if($_=~/^#CHROM/)
    {
        chomp;
        @array=split("\t",$_);
        foreach $j(9..$#array)
        {
            $name=(split/\.variant/,$array[$j])[0];
            if(exists $hash{$name})
            {
                push @list,$j;
                push @sample,$name;
            }
        }
        foreach $m(0..8)
        {
            print OUT "$array[$m]\t";
        }
        foreach $n(0..$#sample-1)
        {
            print OUT "$sample[$n]\t";
        }
        print OUT "$sample[-1]\n";
    }
    if($_=~/^\d/)
    {
        chomp;
        %sum=();%count=();$flag=0;$zero=0;$total=0;
        @tmp=split("\t",$_);
        foreach $i(0..$#list)
        {
            if(exists $hash{$sample[$i]})
            {
                if($tmp[$list[$i]]=~/^\.\/\./)
                {
                    $count{$hash{$sample[$i]}}+=1;
                }
                $sum{$hash{$sample[$i]}}+=1;
            }
        }
        foreach $key(keys %count)
        {
            $rate=$count{$key}/$sum{$key};
            if($rate>=0.75)
            {
                #print "$tmp[1]\t$key\t$rate\n"; exit 0;
                $flag=1;
            }
        }
        if($flag!=1)
        {
            foreach $m(9..$#list)
            {
                if($tmp[$list[$m]]!~/^\.\/\./)
                {
                    if($tmp[$list[$m]]=~/^0\/0/)
                    {
                        $zero++;
                    }
                    $total++;
                }
            }#print "$tmp[1]\t$zero\t$total\n"; #exit 0;
            if($total>$zero)
            {
                foreach $n(0..6)
                {
                    print OUT "$tmp[$n]\t";
                }
                print OUT ".\t$tmp[8]\t";
                foreach $n(0..$#list-1)
                {
                    print OUT "$tmp[$list[$n]]\t";
                }
                print OUT "$tmp[$list[-1]]\n";
            }
            
        }
    }
}
close IN;
close OUT;
