#!usr/bin/perl -w
@file=glob("*$ARGV[0]*stats.txt");
#print "@file\n"; exit 0;
open IN,"<$file[0]" or die "$!";
readline IN;
open OUT,">mex_$ARGV[0].plot" or die "cannot open the file $!";
print OUT "chr\tpos\tp\n";
$chr=1;$now_pos=0;$count=0;
while(<IN>)
{
    chomp;
    if($_!~/NaN/)
    {
        @tmp=split("\t",$_);
        if($tmp[2]!=$chr)
        {
            $now_pos+=$last;
            $chr=$tmp[2];
        }
        $last=$tmp[3];
        $chr=$tmp[2];
        $pos=$now_pos+$tmp[3];
        print OUT "chr$tmp[2]\t$pos\t$tmp[6]\n";
        $count++;
    }
}
close IN;
close OUT;
open OUT1,">mex_$ARGV[0].vline" or die "cannot open the file $!";
print OUT1 "$count\n";
close OUT1;
