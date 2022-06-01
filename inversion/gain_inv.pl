#!usr/bin/perl -w
@file=glob("*.matrix");
foreach $in(@file)
{
    if($in=~/^\d/)
    {
        @name=split/\./,$in;print "$name[0].$name[1]\n";
        #system(`mkdir $name[0].$name[1]`);
        open OUT,">$name[0].$name[1]/$name[0].$name[1].lsf" or die "$!";
        print OUT "#BSUB -J $name[0].$name[1]\n";
        print OUT "#BSUB -n 1\n";
        print OUT "#BSUB -R span[hosts=1]\n";
        print OUT "#BSUB -o $name[0].$name[1].out\n";
        print OUT "#BSUB -e $name[0].$name[1].err\n";
        print OUT "#BSUB -q short\n";
        print OUT "module load cURL/7.47.0-foss-2016b\n";
        #print OUT "/public/home/lchen/software/plink_linux_x86_64/plink --keep ../$name[1] --threads 1 --geno 0.5 --vcf ../teo_$name[0].ref.vcf --maf 0.05 --biallelic-only --snps-only --make-bed --out $name[0].$name[1]\n";
        print OUT "/public/home/lchen/software/R-3.5.3/bin/Rscript ../invcluster.r $name[0].$name[1]\n";
        close OUT;
    }
}
