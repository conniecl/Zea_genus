#!usr/bin/perl -w
open LI,"<basic" or die "$!";
#open LI,"<properties" or die "$!";
while(<LI>)
{
chomp;
open OUT,">$_.f.pbs" or die "$!";
print OUT "#PBS -N $_.f\n";
print OUT "#PBS -l nodes=1:ppn=1\n";
print OUT "#PBS -q batch\n";
print OUT "#PBS -V\n";
print OUT "cd \$PBS_O_WORKDIR\n";
#print OUT "unzip $_","1.zip\n";
print OUT "Rscript extract_num_basic_fast.r $_\n";
#print OUT "unzip $_.zip\n";
#$_=~/^(.*)(\d)$/g;
#$name=$1;
#$id=$2;
#print "$name\n";
#print "$id\n"; exit 0;
#print OUT "Rscript extract_num_fast.r $name $id\n";
close OUT;
}
close LI;
