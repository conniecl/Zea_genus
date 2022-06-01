#!usr/bin/perl -w
open IN,"<../soil.list" or die "$!";
while(<IN>)
{
    chomp;
open OUT,">$..lsf" or die "$!";
print OUT "#BSUB -J $.\n";
print OUT "#BSUB -n 1\n";
print OUT "#BSUB -R span[hosts=1]\n";
print OUT "#BSUB -o $..out\n";
print OUT "#BSUB -e $..err\n";
print OUT "#BSUB -q q2680v2\n";
#print OUT "perl change_name.pl $_\n";
print OUT "perl /public/home/lchen/software/tassel3-standalone/run_pipeline.pl -Xmx20g -fork1 -h mex.genotype.hmp -filterAlign -filterAlignMinFreq 0.05 -fork2 -r ../$_.txt -fork3 -q mex.strc -fork4 -k mex_kinship.txt -combine5 -input1 -input2 -input3 -intersect -combine6 -input5 -input4 -mlm -mlmVarCompEst P3D -mlmCompressionLevel None -mlmOutputFile mex_$_ -export mex_$_ -runfork1 -runfork2 -runfork3 -runfork4\n";
print OUT "perl plot.pl $_\n";
print OUT "Rscript manhattan_plot1.r mex_$_\n";
close OUT;
}
close IN;
