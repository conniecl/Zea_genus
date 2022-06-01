arg<-commandArgs(T)
win <- 10^4
chr=read.table(paste(arg[1],"geno",sep="."))
count=floor(nrow(chr)/win)
usedata <- chr[,-(1:2)]
get.eigenvector <- function(x, d) {
    chunk <- d[((x-1)*win + 1):(x*win), ]
    temp<-chunk
    temp<-data.matrix(temp)
    n<-ncol(temp)/2
    coded<-temp[,2*(1:n)]+temp[,2*(1:n)-1]
    data=coded
    M=rowMeans(data,na.rm=TRUE)
    M=rep(M,times=ncol(data))
    M=matrix(M,nrow=nrow(data),ncol=ncol(data),byrow=FALSE)
    data=data-M
    cov=cov(data,use="pairwise")
    PCA=eigen(cov)
    Vec=PCA$vectors
    lam=PCA$values
    PC1=Vec[,1]
    PC2=Vec[,2]
    lam1=lam[1]
    lam2=lam[2]
    PCs=c(PC1,lam1,PC2,lam2)
    return(PCs)
}
PCs <- sapply(1:count, get.eigenvector, d=usedata)
write.table(PCs,paste(arg[1],"win_104.pca",sep="_"),sep="\t")
