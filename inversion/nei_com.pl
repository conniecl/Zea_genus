#!usr/bin/perl -w
@file=qw/mds1_min mds1_max mds2_min mds2_max/;
foreach $in(@file)
{
    open OUT,">$ARGV[0]_$in.nei.combine" or die "$!";
    foreach $chr(1..10)
    {
        open IN,"<$ARGV[0]_$chr.$in.neibors" or die "$!";
        readline IN;
        while(<IN>)
        {
            chomp;
            @tmp=split/\s+/,$_;
            print OUT "$chr\t$tmp[2]\t$tmp[3]\t$tmp[1]\n";
        }
        close IN;
    }
    close OUT;
}
