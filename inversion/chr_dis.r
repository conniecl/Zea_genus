arg<-commandArgs(T)
PCAs=as.matrix(read.table(paste(arg[1],"_win_104.pca",sep="")))
index <- (1:ncol(PCAs))[!is.na(PCAs[1,])]
k=which(is.na(PCAs[1,]))
if(length(k)==0) {PCA=PCAs}
temp=nrow(PCA)/2
PC1=PCA[1:(temp-1),]
PC2=PCA[(temp+1):(2*temp-1),]
Lam=rbind(PCA[temp,],PCA[2*temp,])
count=ncol(PC1)
Distance=matrix(NA,nrow=count,ncol=count)
for (i in 1:count)
{
        M1=(Lam[1,i]*tcrossprod(PC1[,i])+Lam[2,i]*tcrossprod(PC2[,i]))/(Lam[1,i]+Lam[2,i])
        M1=as.vector(M1)
        for (j in 1:count)
        {    
                    M2=(Lam[1,j]*tcrossprod(PC1[,j])+Lam[2,j]*tcrossprod(PC2[,j]))/(Lam[1,j]+Lam[2,j])
                    M2=as.vector(M2)
                    M=rbind(M1,M2)
                Distance[i,j]=dist(M)
        }
}
rownames(Distance) <- index
colnames(Distance) <- index
write.table(Distance,file=paste(arg[1],"dist",sep="."),sep="\t")
