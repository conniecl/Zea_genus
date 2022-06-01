argv <- commandArgs(TRUE)
library(invClust)
library(snpStats)
genofile<-file.path(paste("/public/home/lchen/zeamap/31.data_add/10.inv/01.lostruct/genotype",argv[1],argv[1],sep="/"))
geno.data<-read.plink(genofile)
geno<-geno.data$genotypes
annot.read<-geno.data$map
annot<-annot.read[,c(1,2,4)]
roi<-read.table(paste("/public/home/lchen/zeamap/31.data_add/10.inv/01.lostruct/genotype/",argv[1],".matrix",sep=""))
for (i in 1:nrow(roi))
{
    inv<-data.frame(chr=roi[i,1],LBP=roi[i,2], RBP=roi[i,3], reg= roi[i,4])
    invcall<-invClust(roi=inv, wh = 1, geno=geno, annot=annot, dim=1)
    invUnc<-invcall["genotypes"]
    write.table(invUnc,file=paste(argv[1],roi[i,4],sep="."))
}
