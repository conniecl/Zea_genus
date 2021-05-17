#!usr/bin/perl -w
open LAT,"<lat.loc" or die "$!";
while(<LAT>)
{
    s/\"//g;
    chomp;
    @tmp=split("\t",$_);
    foreach $i(0..$#tmp)
    {
        $lat{$tmp[$i]}=1;
    }
}
close LAT;
open LON,"<lon.loc" or die "$!";
readline LON;
while(<LON>)
{
    chomp;
    s/\"//g;
    $lon{$_}=1;
}
close LON;
open IN,"<teo.loc" or die "$!";
open OUT,">teo_format.loc" or die "$!";
$header=<IN>;
print OUT "$header";
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    print OUT "$tmp[0]\t";
    $min_lat=1000;
    $flag_lat="";
    foreach $key1(keys %lat)
    {
        $diff=abs($tmp[1]-$key1);
        if($diff<$min_lat)
        {
            $min_lat=$diff;
            $flag_lat=$key1;
        }
    }
    print OUT "$flag_lat\t";
    $min_lon=1000;
    $flag_lon="";
    foreach $key2(keys %lon)
    {
        $diff=abs($tmp[2]-$key2);
        if($diff<$min_lon)
        {
            $min_lon=$diff;
            $flag_lon=$key2;
        }
    }
    print OUT "$flag_lon\n";
}
close IN;
close OUT;
