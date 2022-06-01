#!usr/bin/perl -w
open LI,"<manual_list" or die "$!";
readline LI;
while(<LI>)
{
    chomp;
    @tmp=split("\t",$_);
    open OUT,">$tmp[-1].$tmp[0].lsf" or die "$!";
    print OUT "#BSUB -J $tmp[-1].$tmp[0]\n";
    print OUT "#BSUB -n 1\n";
    print OUT "#BSUB -R span[hosts=1]\n";
    print OUT "#BSUB -o $tmp[-1].$tmp[0].out\n";
    print OUT "#BSUB -e $tmp[-1].$tmp[0].err\n";
    print OUT "#BSUB -q short\n";
    print OUT "/public/home/lchen/software/plink_linux_x86_64/plink --threads 1 --keep ../../$tmp[-1] --chr $tmp[0] --from-bp $tmp[1] --to-bp $tmp[2] --vcf /public/home/lchen/zeamap/31.data_add/04.merge/snp/merge_new/merge_$tmp[0].filter.vcf.gz --maf 0.05 --make-bed --out $tmp[-1].$tmp[0]\n";
    print OUT "/public/home/lyluo/pan/strc/gcta/gcta64 --bfile $tmp[-1].$tmp[0] --autosome --make-grm --out $tmp[-1].$tmp[0] --thread-num 1\n";
    print OUT "/public/home/lyluo/pan/strc/gcta/gcta64 --grm $tmp[-1].$tmp[0] --pca 2 --out $tmp[-1].$tmp[0] --thread-num 1\n";
    close OUT;
}
close LI;
