# Lab 7: Spatially explicit population dynamics
(This file is best viewed on the Github website - and other .md files too)

This lab report is due Thursday Nov 7 at 12pm (in lecture - there is no lab next week)

## Background
This lab uses `Netlogo` to simulate disease dynamics in a sheep population. The model is:
* _An Individual-Based Model_: this means that individuals are represented in the simulation;
* _Stochastic_: this means that events occur with a fixed probability, but on any given run of the simulation, the outcome may be different, i.e., such as a coin toss, the probabiilty of a heads is fixed, but for any given toss a heads may occur or not;
* _Spatially explicit_: this means that space is part of the model formulation: individuals are assigned to locations in space, and the status of neighboring patches can affect the probabilities that different events occur.

These characteristics are different from all the models we have studied in class so far (aside from Lab 6, last week, where the evolutionary dynamics were stochastic and individuals were explicitly represented). The logistic growth model considers competition for a limiting resource and assumes that all individuals, within the specified area, experience the same strength of intraspecific competition. The logistic equation is not spatially explicit because the equation, _dN/dt = rN(1-N/K)_ considers only the population size at time, _t_, and does not consider where indiivduals are located. In contrast, for this lab, where individuals are located will be important.

`Local_SI.nlogo` considers infection dynamics where infections can be spread either locally (only to neighbours), with probability, _1-P_, or globally (can be spread to anyone), with probability, _P_. When infections are spread globally, the model is effectively not spatially explicit because, although individuals are assigned to locations in space, the location of an individual has no effect on the population dynamics. Therefore, by setting `P=0`, we can consider only local infection spread, and we can compare the results of these simulations with the results of simulations that are not spatially explicity, by setting `P=1`.

## Getting started

1. Open the file `Local_SI.nlogo` in the `NetLogo` program.
2. Click the purple `setup` box. This will initialize the simulation with the parameter values as given in the green boxes.
3. Click the purple `go` button: the simulation will begin; click `go` and the simulation will pause; to reset press `setup`.
4. Along the top grey bar notice that you have a slider bar that affects the speed of the vizualization. You also have the option to check or uncheck `view updates`: unchecking `view updates` will allow the simulation complete more quickly.
5. You can change the parameters values by typing new numbers into the green boxes and clicking `setup` and `go` (note that you should stop the simulation before you change the parameter values). The meanings of the parameter values are:
  - `r` the reproductive rate,
  - `d` the natural mortality rate,
  - `beta` the transmission rate,
  - `alpha` the disease-induced mortality rate,
  - `P` the proportion of infections that are spread globally.
6. The graphs that you see are plotting:
  - Top left graph: the proportion of patches that are unoccupied (green line), or occupied by infected (red line), or uninfected (black line) sheep.
  - Bottom left right: due to technical considerations, one iteration of the simulation represents a variable amount of time. This graph shows the progression of time as a function of the simulation iteration.
  - Large right panel: unoccupied patches are shown in green, infected sheep are red, and susceptible sheep are white.
7. Note the there tabs in the center `Interface`, `Info`, and `Code`. Click `Info` and read about the assumptions of the simulation.
8. Click the `Code` tab to see the code.

## Objectives
The goal of this is to:
- Investigate the threshold condititions for a disease outbreak, and
- Investigate the effect of local infection spread on disease dynamics.

For these infection dynamics (as described under the `Info` tab), when infections are only spread globally, a disease outbreak might occur if R<sub>0</sub> > 1, where

<img src="https://latex.codecogs.com/svg.latex?\Large&space;R_0=\frac{&beta;S*}{2a}" title="" />

The above equation assumes global reproduction, which is not actually the case for this simulation, and we can't really calculate _S*_, the number of susceptible hosts at equilibrium, but this R<sub>0</sub> will be a useful heuristic, nonetheless. 


## To hand-in
1. Choose parameter values so that infections are only spread globally, and so that R<sub>0</sub> > 1. Sketch the dynamics of the _frequency of patch types_. Describe the trajectory of the proportion of patches that are occupied by infected sheep.
2. Choose parameter values so that infections are only spread globally, and so that R<sub>0</sub> < 1. Sketch the dynamics of the _frequency of patch types_. Describe the trajectory of the proportion of patches that are occupied by infected sheep.
