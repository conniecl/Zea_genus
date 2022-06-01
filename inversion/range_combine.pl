#!usr/bin/perl -w
@file=qw/mds1_min mds1_max mds2_min mds2_max/;
open OUT,">$ARGV[0].nei.combine" or die "$!";
foreach $in(@file)
{
    open IN,"<$ARGV[0].$in.sort.nei" or die "$!";
    $header=<IN>;
    chomp($header);
    @array=split/\s+/,$header;
    $chr=$array[0];
    $end=$array[2];
    $pos=$array[3];
    $count=1;
    print OUT "$chr\t$array[1]\t";
    while(<IN>)
    {
        chomp;
        @tmp=split/\s+/,$_;
        if($tmp[0] eq $chr)
        {
            $range=$tmp[3]-$pos;
            if($range>=10)
            {
                print OUT "$end\t$count\t$in\n$tmp[0]\t$tmp[1]\t";
                $count=1;
            }
            else
            {
                $count++;
            }
        }
        else
        {
            print OUT "$end\t$count\t$in\n$tmp[0]\t$tmp[1]\t";
            $count=1;
        }
        $chr=$tmp[0];$end=$tmp[2];$pos=$tmp[3];
    }
    close IN;
    print OUT "$tmp[2]\t$count\t$in\n";
}
close OUT;
