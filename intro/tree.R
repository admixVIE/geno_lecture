# in bash!
mafft --auto all.fa > out.fa

## now in R!
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


## heterozygosity (again in bash) 
# get data and calculate heterozygosity
wget https://phaidra.univie.ac.at/pfsa/o_2066302/merged_segregating/Pan/Pan_wild/chr21.vcf.gz
bcftools stats -s - chr21.vcf.gz > stats21.txt
plot-vcfstats -p test stats21.txt

# get only numbers of heterozygous sites per individual, or allele frequencies
grep "^PSC" stats21.txt | cut -f6 > hets.txt
grep "^AF" stats21.txt > afs.txt

# calculate and plot per 10,000 bp (in R)
stat<-read.table("hets.txt",)
chromlen=30000000
hestat<-unlist(stat)/chromlen*10000
plot(sort(hestat), type="p")

# calculate allele frequencies (in R)
afs<-read.table("afs.txt")
freq=afs[,4]/sum(afs[,4])
plot(x=afs[,3],y=freq,type="b",col="red",lwd=2)
