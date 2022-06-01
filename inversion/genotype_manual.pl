#!usr/bin/perl -w
@file=glob("*.order");
foreach $in(@file)
{
    open OR,"<$in" or die "$!";
    $name=(split/\./,$in)[0];
    $header{$name}=<OR>;
}
open IN,"<manual_list.o" or die "$!";
readline IN;
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    open LI,"<../$tmp[0]_$tmp[4]_$tmp[5].$tmp[3]" or die "$!";
    open OUT,">$tmp[0]_$tmp[1].$tmp[3].genotype" or die "$!";
    print OUT "\t$header{$tmp[3]}\n";
    while(<LI>)
    {
        @array=split("\t",$_,2);
        if($array[0]>=$tmp[1] && $array[0]<=$tmp[2])
        {
            print OUT "$_";
        }
    }
    close OUT;
}
close LI;
