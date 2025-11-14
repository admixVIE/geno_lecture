# most simple simulation: random sample from distribution of 285 vs 15 (5%)
initial<-c(rep(0,285),rep(1,15))
newsamp=sample(initial,300,replace=T)

# repeat 100 samplings like this, each based on the previous step
myfreq1<-c()
for (j in 1:100) {
    myfreq1[j]<-length(which(newsamp==1))/300
    newsamp=sample(newsamp,300,replace=T)
    }

# plot it
plot(x=1:100,y=myfreq1,type="b")



## a bit more sophisticated, as R function
simulate <- function(N, p_start, generations) {
  # initialize an (empty) trajectory vector of allele frequencies
  p_traj<- rep(NA, generations)
  p_traj[1] <- p_start
  
  # in each generation...
  for (gen_i in 2:generations) {
    p <- p_traj[gen_i - 1] # get the current frequency
    # calculate the allele frequency in the next generation
    p_next <- rbinom(1, N, p) / N
    # save it to the trajectory vector
    p_traj[gen_i] <- p_next
  }
  
  p_traj
}

# get replicated with specific N, p and number of duration
reps <- replicate(20, simulate(N = 50000, p_start = 0.5, generations = 20000))
  
matplot(reps, ylim = c(0, 1), xlab = "generations", ylab = "allele frequency", type = "l", lty = 1)
