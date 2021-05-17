## scripts for k-mers analysis
```bash
## gain the scaled sig file for each individuals
perl bam2fa.pl $i ## change the $i to individual
jellyfish-linux count -m 31 -s 2560M -t 36 -C $i.fasta -o $i.31.count.jf
jellyfish-linux dump -c -t $i.31.count.jf -o $i.31.count.tsv
perl tsv2fa.pl $i
/public/home/lchen/software/anaconda3/bin/sourmash compute -k 31 $i.fa --scaled 1000 -o $i.sig
## merge the sig files from one species, mexicana as example
sourmash sig merge 5A1.sig 5A3.sig 5A6.sig 5A7.sig 5B7.sig 5B8.sig 5B9.sig 5D9.sig 5E7.sig 5E8.sig 5E9.sig 5F10.sig 5F12.sig 5G1.sig 5G2.sig 5G3.sig 5G7.sig 5G8.sig 5H3.sig 5H4.sig 5H5.sig 6A11.sig 6A2.sig 6A3.sig 6A4.sig 6A5.sig 6B1.sig 6B10.sig 6B11.sig 6B12.sig 6B2.sig 6B3.sig 6B4.sig 6B5.sig 6B6.sig 6B8.sig 6B9.sig 6C4.sig 6C7.sig 5G6.sig 5F7.sig 6B7.sig 5A4.sig 6C1.sig 6C2.sig 5A5.sig 6C5.sig 6A10.sig 6C8.sig 6A8.sig 6C3.sig 6A9.sig 5A2.sig 6C6.sig 6A1.sig 5H2.sig 6A7.sig 6D11.sig 6H2.sig 6C9.sig 6E9.sig 6A6.sig 5E12.sig 6A12.sig 5G12.sig 5H1.sig 6E5.sig 5F5.sig 5F1.sig 5F2.sig 5F6.sig 6H3.sig 6H4.sig 6E1.sig 5F4.sig 5E10.sig 5F3.sig 5E11.sig 6E10.sig 5G9.sig 5G10.sig -o mex.sig
sourmash sig subtract mex.sig par.sig hue.sig dip.sig per.sig lux.sig nic.sig ../maize/maize.sig -o mex.only.nomix.sig
sourmash sig describe mex.sig
sourmash sig describe mex.only.nomix.sig
```
