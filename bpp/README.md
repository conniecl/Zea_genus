## scripts for divergence time and Ne estimation by using BPP
```bash
perl 1.max_pep.pl ## gain the max protein id
perl 2.maxcds.pl  ## gain the max transcripts gtf file
perl 3.gain_lsf.pl  ## extract consense sequence form mapped bam files (per individual) 
perl 4.random.pl ## randomly select 2000 genes
bpp --cfile A11.bpp.ctl ## run A11 model
bpp --cfile A00.bpp.ctl ## run A00 model
```
