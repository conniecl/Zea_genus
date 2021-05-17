### scripts for highland and high latitude adaptation regions indentification
##### highland as example, change the mex to maize to gain the input files. 
```bash
perl nold_list.pl mex $i #$i=1,2,3...10
perl nold_pos.pl mex $i #$i=1,2,3...10
perl snp_genetic.pl mex $i #$i=1,2,3...10
perl geno.pl $i #$i=1,2,3...10
## for high latitude adaptation, change the mex to temperate maize and par to tropical maize
XPCLR -xpclr ../mex/chr$i.mex.geno ../mex/chr$i.par.geno ../mex/chr$i.snp chr$i.1k -w1 0.005 100 1000 $i -p0 0.7 #$i=1,2,3...10
## mask the reported inversion and centromere
for i in {1..10};
do
bedtools subtract -a chr$i.1k.xpclr.txt -b mex_mask.sort >chr$i.1k.mask.xpclr.txt
Rscrip genwin.r chr$i
perl smooth2xpclr.pl $i
done
```
