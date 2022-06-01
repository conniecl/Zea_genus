arg<-commandArgs(T)
a<-read.table(paste(arg[1],"dist",sep="."))
a <- as.matrix(a)
pos<-read.table(paste(arg[2],"_104.pos",sep=""))
count=floor(nrow(a)*0.05)
fit1<-cmdscale(a,eig=TRUE, k=2)  
x <- fit1$points[,1]
y <- fit1$points[,2]

mds1_max<-order(x,decreasing=T)[1]
mds1_min<-order(x,decreasing=F)[1]
mds2_max<-order(y,decreasing=T)[1]
mds2_min<-order(y,decreasing=F)[1]

get.neibor<-function(x,y){
	     temp=sort(y[,x])
	     neibor=as.numeric(names(temp)[1:count])
	     return(neibor)
}
neibors<-sapply(mds1_max,get.neibor,y=a)
out<-pos[neibors,]
write.table(out,file=paste(arg[1],"mds1_max.neibors",sep="."),sep="\t")

neibors<-sapply(mds1_min,get.neibor,y=a)
out<-pos[neibors,]
write.table(out,file=paste(arg[1],"mds1_min.neibors",sep="."),sep="\t")

neibors<-sapply(mds2_max,get.neibor,y=a)
out<-pos[neibors,]
write.table(out,file=paste(arg[1],"mds2_max.neibors",sep="."),sep="\t")

neibors<-sapply(mds2_min,get.neibor,y=a)
out<-pos[neibors,]
write.table(out,file=paste(arg[1],"mds2_min.neibors",sep="."),sep="\t")

