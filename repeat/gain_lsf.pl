open OUT,">$ARGV[0].lsf" or die "$!";

print OUT "#BSUB -J $ARGV[0]\n";
print OUT "#BSUB -n 20\n";
print OUT "#BSUB -R span[hosts=1]\n";
print OUT "#BSUB -o $ARGV[0].out\n";
print OUT "#BSUB -e $ARGV[0].err\n";
print OUT "#BSUB -q short\n";
=pod
    print OUT "__conda_setup=\"\$('/public/home/lchen/software/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)\"\n";
    print OUT "if [ \$? -eq 0 ]; then\n";
    print OUT "eval \"\$__conda_setup\"\n";
    print OUT "else\n";
    print OUT "if [ -f \"/public/home/lchen/software/anaconda3/etc/profile.d/conda.sh\" ]; then\n";
    print OUT "    . \"/public/home/lchen/software/anaconda3/etc/profile.d/conda.sh\"\n";
    print OUT "else\n";
    print OUT "    export PATH=\"/public/home/lchen/software/anaconda3/bin:\$PATH\"\n";
    print OUT "fi\n";
    print OUT "fi\n";
    print OUT "unset __conda_setup\n";
    print OUT "conda activate repeatexplorer\n";
    print OUT "/public/home/lchen/software/repex_tarean/seqclust -p -v ./$ARGV[0].output ./$ARGV[0].fa\n";
=cut
print OUT "mkdir /public/home/lchen/tmp/$ARGV[0].tmp\n";
print OUT "export TEMP=/public/home/lchen/tmp/$ARGV[0].tmp\n";
print OUT "module load Singularity/3.7.3\n";
#print OUT "perl bam2fa_lux.pl $ARGV[0]\n";
print OUT "singularity exec /share/Singularity/repex_tarean_latest.sif seqclust -p -v ./$ARGV[0].output ./$ARGV[0].fa\n";
print OUT "module load RepeatMasker/4.1.0\n";
print OUT "RepeatMasker -pa 20 -species maize -e rmblast $ARGV[0].output/contigs.fasta\n";
close OUT;
