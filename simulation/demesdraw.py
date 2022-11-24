import demes
import demesdraw

graph = demes.load("../examples/two_epoch.yaml")
demesdraw.tubes(graph)

