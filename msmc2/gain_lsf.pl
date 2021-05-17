#!usr/bin/perl -w
open IN,"<list" or die "$!";
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    open OUT,">$tmp[1].lsf" or die "$!";
    print OUT "#BSUB -J $tmp[1]\n";
    print OUT "#BSUB -n 20\n";
    print OUT "#BSUB -R span[hosts=1]\n";
    print OUT "#BSUB -o $tmp[1].out\n";
    print OUT "#BSUB -e $tmp[1].err\n";
    print OUT "#BSUB -q q2680v2\n";
    print OUT "export PATH=/public/home/lchen/130/maize/lchen/software/msmc-1.0.0/msmc-tools:\$PATH\n";
    foreach $j(1..10)
    {
        print OUT "samtools mpileup -u -r $j -f Zea_mays.AGPv4.dna.toplevel.fa $tmp[1].fast.uiq.addrg.sort.bam |bcftools view -cgI - >$tmp[1].chr$j.vcf\n";
        print OUT "cat $tmp[1].chr$j.vcf |python bamCaller_teo.py 20 --minConsQ 0 $tmp[1].chr$j.mask.gz|gzip -c >$tmp[1].chr$j.out.vcf.gz\n";
        print OUT "vcftools --gzvcf chr$j.snp.vcf.gz --indv $tmp[1] --out $tmp[1].$j --recode --recode-INFO-all\n";
        print OUT "gzip $tmp[1].$j.recode.vcf\n";
        print OUT "python generate_multihetsep.py --mask $tmp[1].chr$j.mask.gz --mask=B73_v4.$j.bed.gz $tmp[1].$j.recode.vcf.gz >$tmp[1].chr$j.txt\n";
    }
    close OUT;
}
close IN;
