## get the input file
perl nold_list.pl mex $i #$i=1,2,3...10

perl nold_pos.pl mex $i #$i=1,2,3...10

perl snp_genetic.pl mex $i #$i=1,2,3...10

perl geno.pl $i #$i=1,2,3...10

XPCLR -xpclr ../mex/chr$i.mex.geno ../mex/chr$i.par.geno ../mex/chr$i.snp chr$i.1k -w1 0.005 100 1000 $i -p0 0.7 #$i=1,2,3...10

## mask the centromere
for i in {1..10};
do
Rscrip genwin.r chr$i
perl smooth2xpclr.pl $i
bedtools subtract -a chr$i.1k.xpclr.txt -b cent_nam_v4_chr  >chr$i.xpclr.spline.mask
done
perl top5_gregion.pl
