perl gain_lsf.pl mex
Rscript chr_dis.r mex_1
Rscript mds_plot.r mex_1 1
Rscript get_extreme.r mex_1
perl nei_com.pl mex
perl range_combine.pl mex
for i in {1..10};
do
sed -i '$d' ${i}_104.pos
done
bedtools intersect -wa -wb -a teo_nei.select.bed -b cent_nam_v4 >teo_nei.cent.bed
perl candidate_range.pl
Rscript mds.r mex_1
perl mds_plot.pl mex
Rscript mds_plot.r mex
perl add_ref.pl $i
perl split_matrix.pl mex
perl gain_inv.pl mex
perl phase1.pl mex
perl phase_divide.pl mex
Rscript plot.r
perl gain_pca.pl
perl genotype_manual.pl 
Rscript plot_pca.r
perl pca_plot.pl
Rscript pca_plot.r