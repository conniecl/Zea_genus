#!usr/bin/perl -w
open GTF,"gzip -dc /public/home/lchen/ref/Zea_mays.AGPv4.36.chr.gtf.gz|" or die "$!";
%promoter=();
while(<GTF>)
{
    if($_=~/^\d/)
    {
        @tmp=split("\t",$_,8);
        if($tmp[0] eq $ARGV[0] && $tmp[2] eq "gene")
        {
            if($tmp[6] eq "+")
            {
                $start=$tmp[3]-2000;
                foreach $i($start..$tmp[3]-1)
                {
                    $promoter{$i}=1;
                }
            }
            else
            {
                $start=$tmp[4]+2000;
                foreach $i($tmp[4]+1..$start)
                {
                    $promoter{$i}=1;
                }
            }
        }
    }
}
close GTF;
open LI,"<merge_$ARGV[0].atac.vcf" or die "$!";
while(<LI>)
{
    if($_=~/^\d/)
    {
        @tmp=split("\t",$_,3);
        $atac{$tmp[1]}=1;
    }
}
close LI;
open FI,"<../04.merge/snp/merge_new/zeamap_snp.rmmix.loc" or die "$!";
while(<FI>)
{
    chomp;
    @tmp=split/\s+|:/,$_;
    if($tmp[0] eq $ARGV[0])
    {
        $spec{$tmp[1]}=$tmp[2];
    }
}
close FI;
open VCF,"<zea.$ARGV[0].snpeff" or die "$!";
open OUT,">zea_specficsnp.$ARGV[0].anno" or die "$!";
%type=();
while(<VCF>)
{
    if($_=~/^\d/)
    {
        $_=~/ANN=\w\|(.*?)\|/;
        $ann=$1; #print "$ann\n"; #exit 0;
        @tmp=split("\t",$_,3);
        if($ann=~/intergenic|stream/)
        {
            if(exists $atac{$tmp[1]})
            {
                $ann=join(":",$ann,"atac");
            }
            elsif(exists $promoter{$tmp[1]})
            {
                $ann=join(":",$ann,"promoter");
            }
            else
            {
                $ann=$ann;
            }
        }
        $type{$ann}+=1;
        if(exists $spec{$tmp[1]})
        {
            print OUT "$tmp[1]\t$spec{$tmp[1]}\t$ann\n";
        }
    }
}
close OUT;
open OUT1,">zea.$ARGV[0].anno" or die "$!";
print OUT1 "type\tcount\n";
foreach $key(keys %type)
{
    print OUT1 "$key\t$type{$key}\n";
}
close OUT1;
