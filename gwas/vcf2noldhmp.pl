#!usr/bin/perl -w
open LI,"<list" or die "$!";
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    $hash{$tmp[0]}=1;
}
close LI;
open BI,"<mex.prune.bim" or die "$!";
%remain=();
while(<BI>)
{
	chomp;
	@tmp=split/\s+/,$_;
	$remain{$tmp[1]}=1;
}
close BI;
open OUT,">mex.nold.hmp" or die "$!";
@list=();
foreach $chr(1..10)
{
    open IN,"gzip -dc ../../05.imp/teo/teo_$chr.gt.vcf.gz|" or die "$!";
    while(<IN>)
    {
        chomp;
        if($_=~/^#CHROM/ && $chr==1)
        {
            @array=split("\t",$_);
            foreach $i(9..$#array)
            {
                if(exists $hash{$array[$i]})
                {
                    push @list,$i;
                }
            }
            print OUT "rs#\talleles\tchrom\tpos\tstrand\tassembly#\tcenter\tprotLSID\tassayLSID\tpanelLSID\tQCdode\t";
            foreach $i(0..$#list-1)
            {
                print OUT "$array[$list[$i]]\t";
            }
            print OUT "$array[$list[-1]]\n";#print "@list\n"; exit 0;
        }
        if($_=~/^\d/)
        {
            %base=();
            @tmp=split("\t",$_);
            $len=length($tmp[4]);
            if($len==1)
            {
                $base{0}=$tmp[3];
                $base{1}=$tmp[4];
                if(exists $remain{$tmp[2]})
                {
                    print OUT "$tmp[2]\t$tmp[3]/$tmp[4]\t$tmp[0]\t$tmp[1]\t+\tAPGV4\tNA\tNA\tNA\tNA\tNA\t";
                    foreach $j(0..$#list-1)
                    {
                        @brray=split/\||\:/,$tmp[$list[$j]];#print "$j\t$list[$j]\t$tmp[$list[$j]]\n";
                        print OUT "$base{$brray[0]}","$base{$brray[1]}\t";
                    }
                    @brray=split/\||\:/,$tmp[$list[-1]];#print "$list[-1]\t$tmp[$list[-1]]\n";
                    print OUT "$base{$brray[0]}","$base{$brray[1]}\n";
                }
            }
        }
    }
    close IN;
}
close OUT;
