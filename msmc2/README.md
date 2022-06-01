## get the mapablity files
seqbility-20091110/splitfa ../B73_v4.1.fa 150 >B73_v4.1.150.fa
ln -s ../B73_v4.1.fa
bwa index B73_v4.1.fa
bwa aln -R 1000000 -O 3 -E 3 -t 4 B73_v4.1.fa B73_v4.1.150.fa > B73_v4.1.150.sai
bwa samse -f B73_v4.1.150.sam B73_v4.1.fa B73_v4.1.150.sai B73_v4.1.150.fa
seqbility-20091110/gen_raw_mask.pl B73_v4.1.150.sam >B73_v4.1.150.mask.fa
seqbility-20091110/gen_mask -l 150 -r 0.5 B73_v4.1.150.mask.fa >B73_v4.1.150_50.fa
for i in {1..10};
do
        gzip B73_v4.$i.bed
done
## calcute the lambda among specie
perl gain_lsf.pl
msmc2 -p 5*4+25*2+5*4 -o mex_msmc22_adj2 mex.chr1.txt mex.chr2.txt mex.chr3.txt mex.chr4.txt mex.chr5.txt mex.chr6.txt mex.chr7.txt mex.chr8.txt mex.chr9.txt mex.chr10.txt ##change the mex to other species you want to test
## calculate the lambda between species
python generate_multihetsep.py --mask=6B11.chr1.mask.gz --mask=5G6.chr1.mask.gz --mask=6D12.chr1.mask.gz --mask=5B2.chr1.mask.gz --mask=B73_v4.1.bed.gz 6B11.chr1.recode.vcf.gz 5G6.chr1.recode.vcf.gz 6D12.chr1.recode.vcf.gz 5B2.chr1.recode.vcf.gz >mex.par.chr1.txt  ## change mex.par to other species you want to test, and change the chr1 to chr2,chr3....chr10
msmc2_linux64bit -p 5*4+25*2+5*4 -I 0-4,0-5,0-6,0-7,1-4,1-5,1-6,1-7,2-4,2-5,2-6,2-7,3-4,3-5,3-6,3-7 -o mex.par_msmc2 mex.par.chr1.txt mex.par.chr2.txt mex.par.chr3.txt mex.par.chr4.txt mex.par.chr5.txt mex.par.chr6.txt mex.par.chr7.txt mex.par.chr8.txt mex.par.chr9.txt mex.par.chr10.txt ##change mex.par to other species you want to test

