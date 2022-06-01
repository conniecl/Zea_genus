library(ggplot2)
argv <- commandArgs(TRUE)
data<-read.table(paste(argv[1],".plot",sep=""),header=T)
data1<-read.table(paste(argv[1],".vline",sep=""))
p<-ggplot()+geom_point(data=data,aes(x=pos,y=-log(p,10),color=chr),size=0.8)+theme_bw()+theme(legend.position = 'none', panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.line = element_line(colour = "black"),axis.ticks.x = element_blank(),axis.text.x = element_text(size=16),axis.text.y = element_text(size=16),axis.title.y = element_text(size=21),axis.title.x = element_text(size=21))+scale_x_continuous(breaks=c(150642021,419800249,654364654,891078541,1120622300,1314052038,1486884472,1663032317,1829199806,1982588888),labels=seq(1,10,1))+scale_y_continuous(expand = c(0,0.04))+labs(x="Chromosome",y="-log(P)")+scale_color_manual(values = c("#ff3923","#1c77c1","#1c77c1","#ff3923","#1c77c1","#ff3923","#1c77c1","#ff3923","#1c77c1","#ff3923"))+geom_hline(yintercept =log(data1$V1,10),color="grey",linetype=2,size=1)
ggsave(p,filename=paste(argv[1],".Manhattan.png",sep=""),height=4,width=7)

