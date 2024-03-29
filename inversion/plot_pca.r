library(pheatmap)
argv <- commandArgs(TRUE)
data<-read.table(paste(argv[1],".genotype",sep=""),header=T,row.names = 1)
t<-pheatmap(data,cluster_rows = FALSE,silent = TRUE)
clu<-data.frame(type=cutree(t$tree_col,k=3))
write.table(clu,file=paste(argv[1],".clu",sep=""),sep="\t",quote = FALSE, col.names=FALSE)
png(file=paste(argv[1],".png",sep=""),height=400,width=1400)
pheatmap(data,cluster_rows = FALSE,show_rownames=FALSE,show_colnames=TRUE,cutree_cols=3,legend=FALSE,na_col=NA,border_color=NA,annotation_col =data.frame(type=cutree(t$tree_col,k=3)),annotation_colors=list(type=c("#ff932e","#0a8646","grey")),annotation_legend = FALSE,annotation_names_col=FALSE)
dev.off()
