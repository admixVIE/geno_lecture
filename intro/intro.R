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
# read and write a table
testfile<-read.table('fileA.txt',as.is=T,sep="\t")
head(testfile)
nrow(testfile)
write.table(testfile, 'fileG.txt ',sep="\t",row.names=F,col.names=F,quote=F)


# plotting
plot(myresult[[1]],i2)
hist(i2)
barplot(i1,col="red")
