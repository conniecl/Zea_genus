#!usr/bin/perl -w
open LI,"<../select.list" or die "$!";
@list=qw/copia gypsy LTR LINE TIR Helitron rDNA satellites plastid total/;
while(<LI>)
{
    chomp;
    @file=split("\t",$_);
    open IN,"<../$file[0].output/CLUSTER_TABLE.repeatmasker.csv" or die "$!";
    while(<IN>)
    {
        if($_=~/^\d/)
        {
            chomp;
            @tmp=split/\s+/,$_;
            $te=join(".",$file[0],$tmp[0]);
            if($_!~/plastid/)
            {
                $flag=0;
                if($tmp[-1] ne "NA")
                {
                    $hash{$te}=$tmp[-1];
                }
                else
                {
                    foreach $i(@list)
                    {
                        if($_=~/$i/ && $flag==0)
                        {
                            $flag=1;
                            $hash{$te}=$i;
                        }
                    }
                    if($flag==0)
                    {
                        $hash{$te}="other";
                    }
                }
            }
            else
            {
                $hash{$te}="plastid";
            }
        }
    }
    close IN;
}
close LI;
open BAM,"samtools sort -@ 4 $ARGV[0].bam|samtools depth -|" or die "$!";
#open BAM,"<t" or die "$!";
open OUT,">$ARGV[0].te.static" or die "$!";
print OUT "name\tsum_depth\tlen\tclass\n";
while(<BAM>)
{
    chomp;
    @tmp=split("\t",$_);
    $count{$tmp[0]}+=$tmp[-1];
    $len{$tmp[0]}+=1;
}
close BAM;
foreach $key(keys %count)
{
    $key=~/(.*)\.\d*$/;
    if(exists $hash{$1})
    {
        print OUT "$key\t$count{$key}\t$len{$key}\t$hash{$1}\n";
    }
}
close OUT;
