#usr/bin/perl -w
open LI,"<../maize_id" or die "$!";
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
#=pod
    open OUT,">$tmp[1].lsf" or die "$!";
    print OUT "#BSUB -J $tmp[1]\n";
    print OUT "#BSUB -n 1\n";
    print OUT "#BSUB -R span[hosts=1]\n";
    print OUT "#BSUB -o $tmp[1].out\n";
    print OUT "#BSUB -e $tmp[1].err\n";
    print OUT "#BSUB -q short\n";
    print OUT "zcat /jbyan/lchen/amp_trim/$tmp[0]_1.trimed.fq.gz |awk 'END{print NR}'\n";
    #print OUT "bwa mem -t 4 /public/home/lchen/zeamap/31.data_add/15.repeat/select_repeat.fa /jbyan/lchen/amp_trim/$tmp[0]_1.trimed.fq.gz /jbyan/lchen/amp_trim/$tmp[0]_2.trimed.fq.gz |samtools view -@ 4 -bS >$tmp[1].bam\n";
    close OUT;
#print "$tmp[1].bam\n";
}
close LI;
