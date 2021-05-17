#!usr/bin/perl -w
open LI,"<B73.max.pep.fa" or die "$!";
while(<LI>)
{
    if($_=~/^>/)
    {
        chomp;
        s/>//;
        s/_P/_T/;
        $hash{$_}=1;
    }
}
close LI;
open IN,"<Zea_mays.AGPv4.36.chr.gtf" or die "$!";
open OUT,">Zea_mays.AGPv4.36.cds.max.gtf" or die "$!";
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    if($tmp[2] eq "CDS")
    {
        $tmp[-1]=~/transcript_id \"(.*?)\";/;
        $trans=$1;
        if(exists $hash{$trans})
        {
            print OUT "$_\n";
        }
    }
}
close IN;
close OUT;
