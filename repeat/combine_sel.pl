#!usr/bin/perl -w
open LI,"<select.list" or die "$!";
open OUT,">select_repeat.fa" or die "$!";
while(<LI>)
{
    chomp;
    @name=split("\t",$_);
    open IN,"<$name[0].output/contigs.fasta" or die "$!";
    %hash=();%contig=();
    while(<IN>)
    {
        if($_=~/^>/)
        {
            $_=~/CL(\d+)Contig/;
            push @{$contig{$1}},$_;
            $id=$_;
        }
        else
        {
            $hash{$id}.=$_;
        }
    }
    close IN;
    open FI,"<$name[0].output/CLUSTER_TABLE.csv" or die "$!";
    $flag=1;
    while(<FI>)
    {
        if($_=~/^\d/)
        {
            @tmp=split("\t",$_,2);
            foreach $key(@{$contig{$tmp[0]}})
            {
                print OUT ">$name[0].$tmp[0].$flag\n$hash{$key}";
                $flag++;
            }
            
        }
    }
    close FI;
}
close LI;
close OUT;
