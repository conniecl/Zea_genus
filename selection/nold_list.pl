#!usr/bin/perl -w
@file=glob("/public/home/lchen/zeamap/05.ld/new/$ARGV[0]_split/$ARGV[1].ped.*.LD");
foreach $in(@file)
{
    open IN,"<$in" or die "cannot open the file $!";
    print "$in\n";
    readline IN;
    $header=<IN>;
    chomp($header);
    @tmp=split("\t",$header);
    $hash{$tmp[0]}=1;
    if($tmp[4]<=0.2)
    {
        $hash{$tmp[1]}=1;
    }
    while(<IN>)
    {
        chomp;
        @tmp=split("\t",$_);
        if($tmp[4]<=0.2)
        {
            $hash{$tmp[1]}=1;
        }
        if(exists $hash{$tmp[1]} && $tmp[4]>0.2)
        {
            delete($hash{$tmp[1]});
        }
    }
    close IN;
}
open OUT,">$ARGV[0]/$ARGV[1].nold.marker" or die "cannot open the file $!";
foreach $key(keys %hash)
{
    print OUT "$key\n";
}
close OUT;
