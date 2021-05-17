#!usr/bin/perl -w
open OUT,">$ARGV[0]_ld_mean.r2" or die "cannot open the file $!";
print OUT "distance\tr2_mean\tspecises\n";
%r_square=();%count=();
@d=qw/0 10 50 100 200 500 1000 2000 5000 10000 20000 50000 100000 150000 200000 300000 400000 500000/;
@file=glob("/public/home/lchen/zeamap/05.ld/new/$ARGV[0]_split/*.LD");
foreach $i(@file)
{
    open IN,"<$i" or die "cannot open the file $!";
    print "$i\n";
    readline IN;
    while(<IN>)
    {
        chomp;
        @tmp=split/\s+/,$_;
        foreach $n(1..$#d)
        {
            if($tmp[7] <= $d[$n] && $tmp[7]>$d[$n-1])
            {
                $r_square{$d[$n]}+=$tmp[4];
                $count{$d[$n]}+=1;
            }
        }
    }
    close IN;
}
foreach $key(sort{$a<=>$b} keys %r_square)
{
    $avg=$r_square{$key}/$count{$key};
    print OUT "$key\t$avg\t$ARGV[0]\n";
}
close OUT;
