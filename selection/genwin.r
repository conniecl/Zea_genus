library("GenWin")
argv <- commandArgs(TRUE)
data<-read.table(paste(argv[1],".1k.mask.xpclr.txt",sep=""))
sub<-data[which(data$V4!="Inf"),]
spline<-splineAnalyze(Y=sub$V4,map=(sub$V2+sub$V3)/2,smoothness=100,plotRaw=TRUE,plotWindows=TRUE,method=4)
out<-write.table(spline$windowData,sep="\t",row.names=F,col.names=T,file=paste(argv[1],".spline",sep=""),quote=F)
