library(ggplot2)
library(RColorBrewer)
arg<-commandArgs(T)

cent<-read.table("cent_nam_v4_chr",header=T)

data<-read.table(paste(arg[1],"_mds.plot",sep=""),header=T)
data$chr<-factor(data$chr,levels=c("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10"))

back<-data[which(data$type=="background"),]
candi<-data[which(data$type!="background"),]
colourCount = length(unique(candi$type))
p1<-ggplot()+geom_point(data=back,aes(x=mds1,y=mds2),alpha=1/2,color="grey",size=0.8)+geom_point(data=candi,aes(x=mds1,y=mds2,color=type),size=0.8)+facet_wrap(~chr,scales = "free")+scale_color_manual(values = colorRampPalette(brewer.pal(7, "Set1"))(colourCount))+theme_bw()+theme(panel.grid = element_blank(),axis.text = element_text(size=12),axis.title = element_text(size=21),legend.position=c(0.7,0.1),strip.text=element_text(size=16),strip.background = element_blank())+labs(x="MDS1",y="MDS2")
ggsave(p1,file=paste(arg[1],"_mds.svg",sep=""),height=5,width=10)

back<-data[grep("mds1",data$type,invert = T),]
candi<-data[grep("mds1",data$type),]
p2<-ggplot()+geom_point(data=back,aes(x=rowMeans(back[1:nrow(back),3:4]),y=mds1),alpha=1/2,color="grey",size=0.8)+geom_point(data=candi,aes(x=rowMeans(candi[1:nrow(candi),3:4]),y=mds1,color=type),size=0.8)+geom_rect(data=cent,aes(xmin=start,xmax=end,ymin=min(data$mds1),ymax=max(data$mds1)),alpha=1/5,fill="red")+facet_grid(chr~.,scales = "free")+scale_color_manual(values = colorRampPalette(brewer.pal(7, "Set1"))(colourCount))+theme_bw()+theme(panel.border=element_blank(),panel.grid = element_blank(),axis.text = element_text(size=12),axis.title = element_text(size=21),legend.position=c(0.8,0.2),strip.text=element_text(size=16),strip.background = element_blank())+labs(x="Physical position",y="MDS1")
ggsave(p2,file=paste(arg[1],"_mds1.svg",sep=""),height=5,width=10)

back<-data[grep("mds2",data$type,invert = T),]
candi<-data[grep("mds2",data$type),]
mds2Count = length(unique(candi$type))
f<-colourCount-mds2Count+1
p3<-ggplot()+geom_point(data=back,aes(x=rowMeans(back[1:nrow(back),3:4]),y=mds2),alpha=1/2,color="grey",size=0.8)+geom_point(data=candi,aes(x=rowMeans(candi[1:nrow(candi),3:4]),y=mds2,color=type),size=0.8)+geom_rect(data=cent,aes(xmin=start,xmax=end,ymin=min(data$mds2),ymax=max(data$mds2)),alpha=1/5,fill="red")+facet_grid(chr~.,scales = "free")+scale_color_manual(values = colorRampPalette(brewer.pal(7, "Set1"))(colourCount)[f:colourCount])+theme_bw()+theme(panel.border=element_blank(),panel.grid = element_blank(),axis.text = element_text(size=12),axis.title = element_text(size=21),legend.position=c(0.8,0.2),strip.text=element_text(size=16),strip.background = element_blank())+labs(x="Physical position",y="MDS2")
ggsave(p3,file=paste(arg[1],"_mds2.svg",sep=""),height=5,width=10)
