# work with numbers
5+5
5^5

# work with variables
a<-600
b<-7
a+b
a^b

# vectors
1:10
b:a

# built-in functions
sqrt(5)
sqrt(a)
mean(b:a)

# custom functions
# here: multiply value with a vector, and check if values are positive
myfunc<-function(input1, input2) {
  r1<-input1*input2
  for (j in (1:length(r1))) {
    if (r1[j]<0) {r1[j]<-NA}  
    }
    return(r1)
  }

i1<-sample(seq(50:149),11)
i2<-rnorm(n=100,mean=50,sd=33)
myresult<-lapply(i1,myfunc,input2=i2)

# processing data
# read a table
testfile<-read.table('test.mult.vcf.gz',as.is=T,sep="\t",nrows=5000)
head(testfile)
nrow(testfile)
  
# how many transitions vs transversions are there?
transi<-c("A-G","G-A","C-T","T-C")
transver<-c("A-C","A-T","G-C","G-T","C-A","C-G","T-A","T-G")
testset<-paste(testfile[,4],testfile[,5],sep="-")
testtab<-as.data.frame(table(testset))
transi_num<-sum(testtab[which(testtab[,1]%in%transi),2])  
transver_num<-sum(testtab[which(testtab[,1]%in%transver),2])
transi_num/transver_num

