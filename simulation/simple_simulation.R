simulate <- function(N, p_start, generations) {
  # initialize an (empty) trajectory vector of allele frequencies
  p_traj<- rep(NA, generations)
  p_traj[1] <- p_start
  
  # in each generation...
  for (gen_i in 2:generations) {
    p <- p_traj[gen_i - 1] # get the current frequency
    # ... calculate the allele frequency in the next generation ...
    p_next <- rbinom(1, N, p) / N
    # ... and save it to the trajectory vector
    p_traj[gen_i] <- p_next
  }
  
  p_traj
}

reps <- replicate(20, simulate(N = 50000, p_start = 0.5, generations = 20000))
  
matplot(reps, ylim = c(0, 1), xlab = "generations", ylab = "allele frequency", type = "l", lty = 1)
