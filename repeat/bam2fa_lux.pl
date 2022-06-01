#!usr/bin/perl -w
open IN,"samtools sort -@ 20 -n ./teo/$ARGV[0].fast.sort.bam |samtools view|" or die "$!";
open OUT,">$ARGV[0].fa" or die "$!";
$line1=1;
while(<IN>)
{
    if($line1==1)
    {
        $line1=$_;
        @array=split("\t",$line1);
        $line2=<IN>;
        @brray=split("\t",$line2);
    }
    else
    {
        $line1=$line2;
        @array=split("\t",$line1);
        $line2=$_;
        @brray=split("\t",$line2);
    }
    if($array[0] eq $brray[0])
    {
        $len1=length($array[9]);
        $len2=length($brray[9]);
        if(($array[1]>=65 && $array[1]<=127)||($array[1]>=193 && $array[1]<=255))
        {
            if($len1==$len2 && $len1==150)
            {
                print OUT ">$array[0]/1\n$array[9]\n";
                print OUT ">$brray[0]/2\n$brray[9]\n";
            }
        }
        else
        {
            if($len1==$len2 && $len1==150)
            {
                print OUT ">$brray[0]/1\n$brray[9]\n";
                print OUT ">$array[0]/2\n$array[9]\n";
            }
            
        }
        $line1=1;
    }
    else
    {
        $line1=0;
    }
}
close IN;
close OUT;
