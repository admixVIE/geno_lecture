# in bash:
#mafft --auto all.fa > out.fa

# the necessary libraries
library(phangorn)
library(pheatmap)
# read data
mydata<-read.phyDat("out.fa",format="fasta")
labels=do.call(rbind,strsplit(names(mydata),split=" "))[,2]
# turn into DNA object
mydata<-as.DNAbin(mydata)
# distance matrix & heatmap
dm  <- dist.dna(mydata,model="K81")
pheatmap(dm,cluster_rows=F,cluster_cols=F,labels_row=labels,labels_col=labels)
dm2  <- dist.dna(mydata[-13,],model="K81")
pheatmap(dm2,cluster_rows=F,cluster_cols=F,labels_row=labels[-13],labels_col=labels[-13])
# neighbor joining tree
mytree<-NJ(dm)
mytree=root(mytree,outgroup="NC_001643.1 Chimpanzee")
plot(mytree,root="Chimpanzee")

# pairwise distances
pwdist  <- as.matrix(dist.hamming(mydata,ratio=F))
hist(pwdist,breaks=50)
limit=c(0,max(pwdist))
plot(density(unlist(pwdist[grep("Human",rownames(pwdist)),grep("Human",colnames(pwdist))])),col="green",xlim=limit,main="Pairwise distances")
par(new=T)
plot(density(unlist(pwdist[grep("Neander",rownames(pwdist)),grep("Neander",colnames(pwdist))])),col="blue",xlim=limit,axes=F,bty=NULL,main="",xlab="",ylab="")
par(new=T)
plot(density(unlist(pwdist[grep("Human",rownames(pwdist)),grep("Neander",colnames(pwdist))])),col="red",xlim=limit,axes=F,bty=NULL,main="",xlab="",ylab="")
par(new=T)
plot(density(unlist(pwdist[grep("Human|Neander",rownames(pwdist)),grep("Chimp",colnames(pwdist))])),col="violet",xlim=limit,axes=F,bty=NULL,main="",xlab="",ylab="")
legend("top",legend=c("Human","Neanderthal","Hominin","to-Chimp"),fill=c("green","blue","red","violet"))
