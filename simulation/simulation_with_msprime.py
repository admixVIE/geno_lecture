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
## draw with demes in python
conda activate myenv
python3

import demes
import demesdraw

graph = demes.load("~/model.yaml")
ax = demesdraw.tubes(graph)

ax.figure.savefig("~/model.png")

