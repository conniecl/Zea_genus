fastqc -t 2 ${input}-103_1.fq.gz ${input}-103_2.fq.gz
trimmomatic-0.36.jar PE -threads 20 -phred33  ${input}_1.fq.gz ${input}_2.fq.gz ${input}_1.trimed.fq.gz ${input}_1.un.fq.gz ${input}_2.trimed.fq.gz ${input}_2.un.fq.gz ILLUMINACLIP:adapters.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:76
bowtie2 -q --phred33 --very-fast --end-to-end -p 20 -x Zea_mays.AGPv4.dna.toplevel.fa -1 ${input}_1.trimed.fq.gz -2 ${input}_2.trimed.fq.gz -S ${input}.fast.sam
samtools view -bS ${input}.fast.sam > ${input}.fast.bam
##unique mapping
grep "AS:" ${input}.fast.sam |grep -v "XS:" > ${input}.fast.uiq.sam
##head
samtools view -H ${input}.fast.bam > ${input}.head
cat ${input}.head ${input}.fast.uiq.sam > ${input}.fast.uiq.h.sam
##add read header
java -Xmx10g -jar /public/home/ypeng/Software/picard-tools-1.119/AddOrReplaceReadGroups.jar INPUT=${input}.fast.uiq.h.sam OUTPUT=${input}.fast.uiq.addrg.bam SORT_ORDER=coordinate RGID=Tripsacum RGLB=libTripsacum RGPL=ILLUMINA RGPU="unkn-0.0" RGSM=Tripsacum
##sort
java -Xmx10g -jar /public/home/ypeng/Software/picard-tools-1.119/SortSam.jar INPUT=${input}.fast.uiq.addrg.bam OUTPUT=${input}.fast.uiq.addrg.sort.bam SORT_ORDER=coordinate
##index
java -Xmx10g -jar /public/home/ypeng/Software/picard-tools-1.119/BuildBamIndex.jar INPUT=${input}.fast.uiq.addrg.sort.bam
java -Xmx10g -jar /public/home/ypeng/Software/GenomeAnalysisTK/GATK.jar -R /public/home/ypeng/yangn/snpcalling/testfile/Zea_mays.AGPv4.dna.toplevel.fa -T RealignerTargetCreator -I ${input}.fast.uiq.addrg.sort.bam -o ${input}.fast.realn.intervals
java -Xmx10g -jar /public/home/ypeng/Software/GenomeAnalysisTK/GATK.jar -R /public/home/ypeng/yangn/snpcalling/testfile/Zea_mays.AGPv4.dna.toplevel.fa -T IndelRealigner -targetIntervals ${input}.fast.realn.intervals -I ${input}.fast.uiq.addrg.sort.bam -o ${input}.fast.realn.bam
java -Xmx10g -jar /public/home/ypeng/Software/GenomeAnalysisTK/GATK.jar -R /public/home/ypeng/yangn/snpcalling/testfile/Zea_mays.AGPv4.dna.toplevel.fa -T UnifiedGenotyper -I ${input}.fast.realn.bam -o ${input}.fast.gatk.raw1.vcf --read_filter BadCigar -glm BOTH -stand_call_conf 30.0 -stand_emit_conf 0
/public/home/ypeng/Software/samtools-0.1.19/samtools mpileup -DSugf /public/home/ypeng/yangn/snpcalling/testfile/Zea_mays.AGPv4.dna.toplevel.fa ${input}.fast.realn.bam | /public/home/ypeng/Software/samtools-0.1.19/bcftools/bcftools view -Ncvg - > ${input}.fast.samtools.raw1.vcf
java -Xmx10g -jar /public/home/ypeng/Software/GenomeAnalysisTK/GATK.jar -R /public/home/ypeng/yangn/snpcalling/testfile/Zea_mays.AGPv4.dna.toplevel.fa -T SelectVariants --variant ${input}.fast.samtools.raw1.vcf --concordance ${input}.fast.gatk.raw1.vcf -o ${input}.fast.concordance.raw1.vcf
MEANQUAL=`awk '{ if ($1 !~ /#/) { total += $6; count++ } }  END { print total/count }' ${input}.fast.concordance.raw1.vcf`
java -Xmx10g -jar /public/home/ypeng/Software/GenomeAnalysisTK/GATK.jar -R /public/home/ypeng/yangn/snpcalling/testfile/Zea_mays.AGPv4.dna.toplevel.fa -T VariantFiltration --filterExpression "QD < 20.0 || ReadPosRankSum < -8.0 ||  FS > 10.0 || QUAL < $MEANQUAL"  --filterName LowQualFilter --variant ${input}.fast.concordance.raw1.vcf --missingValuesInExpressionsShouldEvaluateAsFailing --logging_level ERROR -o ${input}.fast.concordance.flt1.vcf
grep -v "Filter" ${input}.fast.concordance.flt1.vcf > ${input}.fast.concordance.filter1.vcf
java -Xmx10g -jar /public/home/ypeng/Software/GenomeAnalysisTK/GATK.jar -R /public/home/ypeng/yangn/snpcalling/testfile/Zea_mays.AGPv4.dna.toplevel.fa -T BaseRecalibrator -I ${input}.fast.realn.bam -o ${input}.fast.recal_data.grp -knownSites ${input}.fast.concordance.filter1.vcf
java -Xmx10g -jar /public/home/ypeng/Software/GenomeAnalysisTK/GATK.jar -R /public/home/ypeng/yangn/snpcalling/testfile/Zea_mays.AGPv4.dna.toplevel.fa -T PrintReads -I ${input}.fast.realn.bam -o ${input}.fast.recal.bam -BQSR ${input}.fast.recal_data.grp
java -Xmx10g -jar /public/home/ypeng/Software/GenomeAnalysisTK/GATK.jar -R /public/home/ypeng/yangn/snpcalling/testfile/Zea_mays.AGPv4.dna.toplevel.fa -T UnifiedGenotyper -I ${input}.fast.recal.bam -o ${input}.fast.gatk.raw2.vcf --read_filter BadCigar -glm BOTH -stand_call_conf 30.0 -stand_emit_conf 0
/public/home/ypeng/Software/samtools-0.1.19/samtools mpileup -DSugf /public/home/ypeng/yangn/snpcalling/testfile/Zea_mays.AGPv4.dna.toplevel.fa ${input}.fast.recal.bam |/public/home/ypeng/Software/samtools-0.1.19/bcftools/bcftools view -Ncvg - > ${input}.fast.samtools.raw2.vcf
java -Xmx10g -jar /public/home/ypeng/Software/GenomeAnalysisTK/GATK.jar -R /public/home/ypeng/yangn/snpcalling/testfile/Zea_mays.AGPv4.dna.toplevel.fa -T SelectVariants --variant ${input}.fast.samtools.raw2.vcf --concordance ${input}.fast.gatk.raw2.vcf -o ${input}.fast.concordance.raw2.vcf
java -Xmx10g -jar /public/home/ypeng/Software/GenomeAnalysisTK/GATK.jar -R /public/home/ypeng/yangn/snpcalling/testfile/Zea_mays.AGPv4.dna.toplevel.fa -T VariantFiltration --filterExpression "QD < 10.0 || ReadPosRankSum < -8.0 || FS > 10.0 || QUAL < 30" --filterName LowQualFilter --variant ${input}.fast.concordance.raw2.vcf --missingValuesInExpressionsShouldEvaluateAsFailing --logging_level ERROR -o ${input}.fast.concordance.flt2.vcf
grep -v "Filter" ${input}.fast.concordance.flt2.vcf >${input}.fast.final.vcf
##snp_indel
grep -v "INDEL" ${input}.fast.final.vcf >${input}.fast.final.snps.vcf
grep "INDEL" ${input}.fast.final.vcf > ${input}.fast.final.indel.vcf
cat ${input}.snps.head ${input}.fast.final.indel.vcf > ${input}.fast.final.Indel.vcf
rm -rf ${input}.fast.final.indel.vcf
##cluster
cat ${input}.fast.final.snps.vcf | /public/home/maize/software/vcftools_0.1.13/perl/vcf-annotate --filter SnpCluster=2,5 > ${input}.fast.final.snps.Cluster.vcf
grep -v "SnpCluster" ${input}.fast.final.snps.Cluster.vcf > ${input}.fast.final.snps.cluster.vcf
