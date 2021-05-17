## scripts for sanger sequencing and illumina calling SNP comparsion
```bash
perl 1.sanger_all.pl
clustalw2 -infile=sanger_all.fa -align -outfile=sanger_all.aln -outorder=INPUT -type=DNA -output=FASTA
perl 2.format_aln.pl sanger_all
perl 3.overlap.pl sanger
```
