import demes
import demesdraw

graph = demes.load("../model.yaml")
demesdraw.tubes(graph)

