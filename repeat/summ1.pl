#!usr/bin/perl -w
#
@list=qw/copia gypsy LTR LINE TIR Helitron rDNA satellites plastid total/;
open LI,"<done" or die "$!";
open OUT,">done_summary" or die "$!";
print OUT "\t";
while(<LI>)
{
    chomp;
    @name=split("\t",$_);
    open IN,"<$name[0].output/CLUSTER_TABLE.repeatmasker.csv" or die "$!";
    while(<IN>)
    {
        if($_=~/Number_of_analyzed_reads/)
        {
            $count{"total"}{$name[0]}=(split/\s+/,$_)[1];
            $total{"total"}=1;
        }
        if($_=~/^\d/)
        {
            chomp;@tmp=split/\s+/,$_;
            if($_!~/plastid/)
            {
                $flag=0;
                if($tmp[-1] ne "NA")
                {
                    $count{$tmp[-1]}{$name[0]}+=$tmp[2];
                    $total{$tmp[-1]}=1;
                }
                else
                {
                    foreach $i(@list)
                    {
                        if($_=~/$i/ && $flag==0)
                        {
                           $count{$i}{$name[0]}+=$tmp[2];
                           $flag=1;
                           $total{$i}=1;
                        }
                    }
                    if($flag==0)
                    {
                        $count{"other"}{$name[0]}+=$tmp[2];
                        $total{"other"}=1;
                    }
                }
            }
            else
            {
                $count{"plastid"}{$name[0]}+=$tmp[2];
                $total{"plastid"}=1;
            }
        }
    }
    $pop{$name[0]}=$name[1];
    push @sample,$name[0];
    print OUT "$name[0]\t";
}
close IN;
print OUT "\n";
print OUT "\t";
foreach $i(@sample)
{
    print OUT "$pop{$i}\t";
}
print OUT "\n";
@all=sort{$a cmp $b} keys %total;
foreach $key1(@all)
{
    print OUT "$key1\t";
    foreach $key2(@sample)
    {
        if(exists $count{$key1}{$key2})
        {
            print OUT "$count{$key1}{$key2}\t";
        }
        else
        {
            print OUT "0\t";
        }
    }
    print OUT "\n";
    
}
