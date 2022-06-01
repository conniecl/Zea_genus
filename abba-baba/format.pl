open LI,"<t" or die "$!";
open OUT,">all_result.dip" or die "$!";
while(<LI>)
{
chomp;
open IN,"<$_/fa_fa_DIP_results_2021-05-27.csv" or die "$!";
readline IN;
print OUT "$_\t";
while(<IN>)
{
chomp;
@tmp=split/,/,$_;
print OUT "$tmp[1]\t";
}
close IN;
print OUT "\n";
}
close LI;
