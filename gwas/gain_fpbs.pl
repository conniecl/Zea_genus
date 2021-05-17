#!usr/bin/perl -w
open LI,"<list" or die "$!";
$i=1;
while(<LI>)
{
chomp;
open OUT,">gwas/$i.pbs" or die "$!";
print OUT "#PBS -N $i\n";
print OUT "#PBS -l nodes=1:ppn=1\n";
print OUT "#PBS -q batch\n";
print OUT "#PBS -V\n";
print OUT "cd \$PBS_O_WORKDIR\n";
#print OUT "#perl format.pl $_\n";
#print OUT "perl trait.pl $_\n";
print OUT "perl /home/maize/software/tassel3-standalone/run_pipeline.pl -Xmx20g -fork1 -h teo_par_mex.genotype.hmp -filterAlign -filterAlignMinFreq 0.05 -fork2 -r ../$_.txt -fork3 -q strc_new.txt -fork4 -k mex_par_kinship.txt -combine5 -input1 -input2 -input3 -intersect -combine6 -input5 -input4 -mlm -mlmVarCompEst P3D -mlmCompressionLevel None -mlmOutputFile mex_par -export mex_par -runfork1 -runfork2 -runfork3 -runfork4\n";
print OUT "perl plot.pl $_\n";
print OUT "Rscript manhattan_plot.r $_\n";
$i++;
close OUT;
}
close LI;
