#!usr/bin/perl -w
open OR,"<zea_k15.strc" or die "$!";
#open OUT1,">trim_reads" or die "$!";
readline OR;
%reads=();
while(<OR>)
{
    chomp;
    @tmp=split/\s+/,$_,4;
    push @order,$tmp[0];
    open IN,"<$tmp[0].out" or die "$!";
    while(<IN>)
    {
        if(/The output \(if any\) follows:/../PS:/)
        {
            if($_=~/^\d/)
            {
                chomp;#print "$_\n"; exit 0;
                $reads{$tmp[0]}+=$_;
            }
        }
    }
    close IN;
    $reads{$tmp[0]}=$reads{$tmp[0]}/2;if($tmp[0] eq "TX5"){$reads{$tmp[0]}=322967638;}
    #print OUT1 "$tmp[0]\t$reads{$tmp[0]}\n";
}
close OUT1;
close OR;
open LI,"<range" or die"$!";
open OUT,">zea_te.norm.matrix" or die "$!";
$header=<LI>;
print OUT "\t$header";
chomp($header);
@range=split/\s+/,$header;
open FI,"<merge_name" or die "$!";
while(<FI>)
{
    chomp;
    @tmp=split/\s+/,$_;
    $merge{$tmp[0]}=$tmp[1];
}
close FI;
open TE,"<zea_te.matrix" or die "$!";
$name=<TE>;
chomp($name);
@array=split/\s+/,$name;
while(<TE>)
{
    chomp;
    @tmp=split("\t",$_);
    foreach $i(1..$#tmp)
    {
        if(exists $merge{$array[$i]})
        {
            $hash{$tmp[0]}{$merge{$array[$i]}}+=$tmp[$i];
        }
    }
}
close TE;
foreach $key1(@order)
{
    print OUT "$key1\t";
    foreach $key2(@range)
    {
        $avg=$hash{$key1}{$key2}/$reads{$key1};
        print OUT "$avg\t";
    }
    print OUT "\n";
}
close OUT;
