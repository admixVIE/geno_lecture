###############################
## in ms
ms 20 1 -seeds 105 2000 300 -t 2.0 -r 2.0 50000 -I 2 10 10 -n 1 2.0 -n 2 5.0 -ej 0.25 1 2 

###############################
## in msprime (python)
import msprime as msp

rec_rate = 1e-8 
mu = 1e-8
Ne_A = 2000
Ne_B = 5000
T_AB = 1000
n_A = 10
n_B = 10
samples = [msp.Sample(0, 0)] * n_A + [msp.Sample(1, 0)]*n_B

population_configurations = [
  msp.PopulationConfiguration(initial_size = Ne_A),
  msp.PopulationConfiguration(initial_size = Ne_B),
  ]

demographic_events = [
  msp.MassMigration(
    time = T_AB, source = 0, destination = 1, proportion = 1.0),
  ]

ts = msp.simulate(
  samples = samples,
  population_configurations = population_configurations,
  demographic_events = demographic_events,
  length = 50000, recombination_rate = rec_rate,
  mutation_rate = mu,
)

for var in ts.variants():
  print(var.site.position, var.alleles, var.genotypes, sep="\t")

  
###############################
## in R with slendr
library(slendr)
popA <- population("popA", N = 2000, time = 1001)
popB <- population("popB", N = 5000, time = 1000, parent = popA)
model <- compile_model(  list(popA, popB),
                         generation_time = 1,  simulation_length = 1000)

plot_model(model)

p1 <- model$populations[["popA"]]
p2 <- model$populations[["popB"]]
mydata_gt<-schedule_sampling(model,times=0,list(p1,5),list(p2,5))
mydata <- msprime(model, sequence_length = 5000000, recombination_rate = 1e-8,samples=mydata_gt)
mydata_mutate <- ts_mutate(mydata,  mutation_rate = 1e-8)

mydata_gt<-ts_genotypes(mydata_mutate)

## calculate and plot statistics
## heterozygosity
myda_ht<-list();k=1
for (j in seq(1,19,2)) {
  myda_ht[[k]]<-table(rowSums(mydata_gt[,(j+1):(j+2)]))
  k=k+1
  }

mda<-do.call(rbind,myda_ht)
data<-data.frame(name=c(rep("A",5),rep("B",5)),val=mda[,2]/5000000*1000)

library(viridis)
data %>%
  ggplot( aes(x=name, y=val, fill=name)) +
  geom_boxplot() +
  scale_fill_viridis(discrete = TRUE, alpha=0.6) +
  geom_jitter(color="black", size=1, alpha=0.9) +
  theme_minimal() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11)
  ) +
  ggtitle("Heterozygosity") +
  xlab("")

## as VCF file
#mydata_gt<-ts_vcf(mydata_mutate,path="test.vcf.gz")

# calculate FST
ts_fst(mydata_mutate,sample_sets=list(c(paste("popA_",1:5,sep="")),c(paste("popB_",1:5,sep=""))))

## with 5000 generations for the SFS
samp1 <- ts_samples(mydata_mutate) %>% .[.$pop %in% c("popA"), ]
samp2 <- ts_samples(mydata_mutate) %>% .[.$pop %in% c("popB"), ]
afs1<-ts_afs(mydata_mutate, sample_sets = list(samp1$name),polarised=T)
afs2<-ts_afs(mydata_mutate, sample_sets = list(samp2$name),polarised=T)

# calculate SFS
afss<-cbind(afs1,afs2)
pdf("~/test_sfs.pdf",8,5)
barplot(t(afss),beside=T,names.arg=c(1:10),col=c("green","blue"))
legend("topright",fill=c("green","blue"),legend=c("Ne=2000","Ne=5000"),bty="n",border=NA,cex=2)
dev.off()

###############################
## draw with demes in python
import demes
import demesdraw

graph = demes.load("~/model.yaml")
ax = demesdraw.tubes(graph)

ax.figure.savefig("~/model.png")

