open IN,"<list" or die "cannot open the file $!";
while(<IN>)
{
    chomp;
    @tmp=split("_",$_);
    $file=join("_",$tmp[0],$tmp[1]);
    open OUT,">$tmp[2].pbs" or die "cannot open the file $!";
    print OUT "#BSUB -J $tmp[2]\n";
    print OUT "#BSUB -n 1\n";
    print OUT "#BSUB -R span[hosts=1]\n";
    print OUT "#BSUB -e $tmp[2].err\n";
    print OUT "#BSUB -o $tmp[2].out\n";
    print OUT "#BSUB -q normal\n";
    print OUT "cd \$PBS_O_WORKDIR\n";
    print OUT "java -Xmx10g -jar GATK.jar -R Zea_mays.AGPv4.dna.toplevel.fa -T UnifiedGenotyper -I $tmp[2].fast.recal.sort.bam --genotyping_mode GENOTYPE_GIVEN_ALLELES -alleles merge.all.vcf -o $tmp[2].mo.vcf --read_filter BadCigar -glm BOTH -stand_call_conf 30.0 -stand_emit_conf 0 -out_mode EMIT_ALL_SITES\n";
    print OUT "perl filter_lowqhete.pl $tmp[2]\n";
    close OUT;
}
close IN;
