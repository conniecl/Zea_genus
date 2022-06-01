library(ggplot2)
args<-commandArgs(T)
data<-read.table(paste(args[1],"dip",sep="."),header=T)
sub<-data[which(data$type=="K23"|data$type=="K13"|data$type=="K12"),]
p<-ggplot(sub)+geom_violin(aes(x=factor(type,levels=c("K23","K12","K13")),y=num))+geom_hline(yintercept=0,linetype=2)+theme_bw()+theme(panel.grid = element_blank(),panel.border = element_blank(),axis.line = element_line(colour = "black"),axis.text = element_text(size=16),axis.title = element_text(size=21),legend.position='none',strip.text=element_text(size=16))+labs(x="",y="dK")
#ggsave(p,file=paste(args[1],"dk.svg",sep=""),height=4,width=3)
ggsave(p,file=paste(args[1],"dk.png",sep=""),height=4,width=3)

dk<-data[which(data$type=="ddk"),]
dat<-with(density(dk$num),data.frame(x,y))
dat1<-dat[dat$x<0,]
p<-ggplot()+geom_density(data=dk,aes(x=num),fill="#1c77c1")+geom_area(data=dat1,aes(x=x,y=y),fill="grey")+geom_vline(xintercept=0,linetype=2)+theme_bw()+theme(panel.grid = element_blank(),panel.border = element_blank(),axis.line = element_line(colour = "black"),axis.text = element_text(size=16),axis.title = element_text(size=21),legend.position='none',strip.text=element_text(size=16))+labs(x="ddk",y="Density")+scale_y_continuous(expand=c(0,0))
#ggsave(p,file=paste(args[1],".ddk.svg",sep=""),height=4,width=3)
ggsave(p,file=paste(args[1],".ddk.png",sep=""),height=4,width=3)

dk<-data[which(data$type=="dddk"),]
dat<-with(density(dk$num),data.frame(x,y))
dat1<-dat[dat$x<0,]
p<-ggplot()+geom_density(data=dk,aes(x=num),fill="#1c77c1")+geom_area(data=dat1,aes(x=x,y=y),fill="grey")+geom_vline(xintercept=0,linetype=2)+theme_bw()+theme(panel.grid = element_blank(),panel.border = element_blank(),axis.line = element_line(colour = "black"),axis.text = element_text(size=16),axis.title = element_text(size=21),legend.position='none',strip.text=element_text(size=16))+labs(x="dddk",y="Density")+scale_y_continuous(expand=c(0,0))
#ggsave(p,file=paste(args[1],".dddk.svg",sep=""),height=4,width=3)
ggsave(p,file=paste(args[1],".dddk.png",sep=""),height=4,width=3)
