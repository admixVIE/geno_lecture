#R --vanilla
'%ni%' <- Negate('%in%')
sufu<-function(input) { sum(as.numeric(unlist(strsplit(as.character(input),split="/")))) }  
safu<-function(input) { rava<-sample(c(0,1),length(input),replace=T);ifelse(input==1,rava,input) }
ofu<-function(i1,i2,tb) { return(ifelse(i1==i2,NA,length(which(tb[,i1]==tb[,i2]))) ) }
tabl<-system(paste("bcftools query -u -f '[%GT ] \n' /scratch/admixlab/pans/2_pans_21.vcf.gz"),intern=T)
tabl<-do.call(rbind,strsplit(tabl,split=" "))
tabl<-tabl[1:100000,-71]
tabl[which(tabl%ni%c("0/0","0/1","1/1"))]<-NA
tab3<-tabl[which(rowSums(is.na(tabl))==0),]
tab2<-apply(tab3,c(1,2),sufu)
tab4<-apply(tab2,2,safu)

tab5<-list()
for (j in (1:ncol(tab4))) { print(j); tab5[[j]]<-unlist(lapply(1:ncol(tab4),ofu,i2=j,tb=tab4)) }
tab5<-do.call(rbind,tab5)

save(tab5,file="sharemat")

library(pheatmap)
load("sharemat")
tab5<-tab5[-36,-36]
tab5<-tab5[-c(1:10),-c(1:10)]
tab5<-tab5[-c(49:59),-c(49:59)]
png("/home/kuhlwilm/scrna/heatmap.png")
pheatmap(tab5,cluster_rows=F,cluster_cols=F)
dev.off()



