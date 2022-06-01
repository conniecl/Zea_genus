library(ncdf4)
argv <- commandArgs(TRUE)
nc<-nc_open(paste(argv[1],argv[2],".nc",sep=""))
lat <- ncvar_get( nc = nc, varid = 'lat')
lon <- ncvar_get( nc = nc, varid = 'lon')
depth <- ncvar_get( nc = nc, varid = 'depth')
for (k in 1:length(depth))
{
  num<-ncvar_get(nc,varid=argv[1],start=c(1,1,k),count=c(-1,-1,1))
  write.table(num,file=paste(argv[1],argv[2],".",depth[k],".num",sep=""),sep="\t",row.names=lon,col.names=lat)
}
