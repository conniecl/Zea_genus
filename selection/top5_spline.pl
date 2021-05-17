#!usr/bin/perl -w
%pos=();@list=();%start=();%xpclr=();
foreach $chr(1..10)
{
    open IN,"<chr$chr.xpclr.spline" or die "$!";
    while(<IN>)
    {
        chomp;
        @tmp=split/\s+/,$_;
        $end=$tmp[2]+999;
        push @list,$tmp[5];
        $pos{$tmp[0]}{$tmp[1]}=$tmp[5];
        $start{$tmp[0]}{$tmp[1]}=$end;
        $xpclr{$tmp[0]}{$tmp[1]}=$tmp[4];
    }
    close IN;
}
@list=sort{$b<=>$a} @list;
$len=scalar(@list);
$index=int($len*0.05)-1;
print "$list[$index]\n";
open OUT,">mex_par.top5.spline.wstatic" or die "cannot open the file $!";
foreach $key1(sort{$a<=>$b} keys %pos)
{
    foreach $key2(sort{$a<=>$b} keys %{$pos{$key1}})
    {
        if($pos{$key1}{$key2}>=$list[$index])
        {
            print OUT "$key1\t$key2\t$start{$key1}{$key2}\t$xpclr{$key1}{$key2}\t$pos{$key1}{$key2}\n";
        }
    }
}
close OUT;
