library(ggplot2)
data<-read.table("dip_tree_num.txt",header=T)
p<-ggplot(data)+geom_bar(aes(x="t",y=num,fill=type),stat="identity",position="fill")+theme_bw()+theme(panel.grid=element_blank(),panel.border=element_blank(),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.line = element_line(colour = "black"),axis.text = element_text(size=16),legend.text = element_text(size=16),axis.title = element_text(size=21))+scale_fill_manual(values=c("#1c77c1","#ff3923","#ff932e"))+facet_grid(~test)+scale_y_continuous(expand=c(0,0))+labs(x="",y="dk")
ggsave(p,file="dip_tree_num.svg",height=5,width=15)
