#!usr/bin/perl -w
open IN,"<TEO_B73_linkagemap.v4.noctg" or die "cannot open the file $!";
@pos=();@dis=();
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    if($tmp[0]==$ARGV[1])
    {
        push @pos,$tmp[1];
        push @dis,$tmp[3];
    }
}
close IN;
open LI,"<$ARGV[0]/chr$ARGV[1].nold" or die "cannot open the file $!";
open OUT,">$ARGV[0]/chr$ARGV[1].snp" or die "cannot open the file $!";
$flag=1;
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    foreach $i(0..$#pos-1)
    {
        if($tmp[1]>=$pos[$i]&&$tmp[1]<$pos[$i+1])
        {
            $rate=($dis[$i+1]-$dis[$i])/($pos[$i+1]-$pos[$i]);
            $gen=($tmp[1]-$pos[$i])*$rate+$dis[$i];
            $gen=$gen/100;
            print OUT " snp$flag\t$tmp[0]\t$gen\t$tmp[1]\t$tmp[2]\t$tmp[3]\n";
        }
    }
    if($tmp[1]>$pos[-1])
    {
        $gen=($tmp[1]-$pos[-1])*$rate+$dis[-1];
        $gen=$gen/100;
        print OUT " snp$flag\t$tmp[0]\t$gen\t$tmp[1]\t$tmp[2]\t$tmp[3]\n";
    }
    if($tmp[1]==$pos[-1])
    {
        $gen=$dis[-1]/100;
        print OUT " snp$flag\t$tmp[0]\t$gen\t$tmp[1]\t$tmp[2]\t$tmp[3]\n";
    }
    $flag++;
}
close LI;
close OUT;
