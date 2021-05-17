argv <- commandArgs(TRUE)
library(inveRsion)
hap <-paste("~/05.genotype/new/",argv[1],".genotype",sep="")
hapCode<-codeHaplo(blockSize=5,file=hap,minAllele=0.3,saveRes=TRUE)
window<-0.5
scanRes<-scanInv(hapCode,window=window,saveRes=TRUE)
invList<-listInv(scanRes,hapCode=hapCode,geno=FALSE,all=FALSE,thBic=0)
sink(paste(argv[1],".inv",sep=""))
invList
sink()
