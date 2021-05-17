#!usr/bin/perl -w
open OUT,">$ARGV[0].lsf" or die "$!";
print OUT "#BSUB -J $ARGV[0].a\n";
print OUT "#BSUB -n 1\n";
print OUT "#BSUB -o $ARGV[0].out\n";
print OUT "#BSUB -e $ARGV[0].err\n";
print OUT "#BSUB -q normal\n";
print OUT "samtools view -h $ARGV[0].fast.sort.bam|grep -E \"^@|AS:\"|grep -v \"XS:\" |samtools view -bS - > $ARGV[0].uniq.bam\n";
print OUT "angsd -doFasta 2 -doCounts 1 -i $ARGV[0].uniq.bam -out $ARGV[0]\n";
print OUT "gzip -dc $ARGV[0].fa.gz >$ARGV[0].fa\n";
print OUT "gffread ~/ref/Zea_mays.AGPv4.36.cds.max.gtf -g $ARGV[0].fa -x $ARGV[0].cds.fa\n";
close OUT;
