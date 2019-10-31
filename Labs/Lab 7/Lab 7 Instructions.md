# Lab 7: Spatially explicit population dynamics
(This file is best viewed on the Github website - and other .md files too)

This lab report is due Thursday Nov 7 at 12pm (in lecture - there is no lab next week)

## Background
This lab uses `Netlogo` to simulate disease dynamics in a sheep population. `Netlogo` is a simulation platform with strengths in simulation visualization and built-in functions for ease of programming Agent-Based Models. The model we are simulating in `Netlogo` today could have been programmed and vizualized in `R`, we have switched to `Netlogo` to gain an awareness of different programming platforms, and because `Netlogo` is appropriate given the topic of this lab. 

The model we will investigate is:
* _An Individual-Based Model_: this means that individuals are represented in the simulation;
* _Stochastic_: this means that events occur with a fixed probability, but on any given run of the simulation, the outcome may be different, i.e., such as a coin toss where the probabiilty of a heads is fixed, but for any given toss a heads may occur or not;
* _Spatially explicit_: this means that space is included in the model formulation: individuals are assigned to locations in space, and the status of neighbouring patches can affect the probabilities that different events occur.

These characteristics are different from all the models we have studied in class so far (except for Lab 6, last week, where the evolutionary dynamics were stochastic and individuals were explicitly represented). For example, the logistic growth model implicitly considers competition for a limiting resource (i.e., space) and assumes that all individuals, within the specified area, experience the same strength of intraspecific competition (even though in reality some individuals are closer to each other and would compete more strongly). The logistic equation is not spatially explicit because the equation, _dN/dt = rN(1-N/K)_ considers only the population size at time, _t_, and does not consider where indivduals are located, i.e. _N(t,x)_ where _x_ is related to the spatial location of an individual. In contrast, for this lab, _where_ individuals are located will be important.

`Local_SI.nlogo` considers infection dynamics where infections can be spread either locally (only to neighbours), with probability, _1-P_, or globally (can be spread to anyone), with probability, _P_. When infections are spread globally, the model is not spatially explicit because, although individuals are assigned to locations in space, the location of individuals has no effect on the population dynamics. By setting `P=0`, we can consider only local infection spread, and we can compare the results of these simulations with the results of simulations that are not spatially explicit, by setting `P=1`.

## Getting started

1. Open the file `Local_SI.nlogo` in the `NetLogo` program.
2. Click the purple `setup` box. This will initialize the simulation with the parameter values as given in the green boxes.
3. Click the purple `go` button: the simulation will begin; click `go` again, and the simulation will pause; to reset, press `setup`. If you do not pause the simulation it will run until time is `tend`.
4. Along the top grey bar notice that you have a slider bar that affects the speed of the vizualization. You also have the option to check or uncheck `view updates`: unchecking `view updates` will allow the simulation complete more quickly.
5. You can change the parameter values by typing new numbers into the green boxes and clicking `setup` and `go` (note that you should pause, or the simulation should be stopped, before you change the parameter values). The meanings of the parameter values are:
  - `tend` the time when the simulation stops,
  - `r` the reproductive rate,
  - `d` the natural mortality rate,
  - `beta` the transmission rate,
  - `alpha` the disease-induced mortality rate,
  - `P` the proportion of infections that are spread globally.
6. The graphs that you see are plotting:
  - Top left graph: the proportion of patches that are unoccupied (green line), or occupied by infected (red line), or uninfected (black line) sheep.
  - Bottom left right: due to technical considerations, one iteration of the simulation represents a variable amount of time. This graph shows the progression of time as a function of the simulation iteration (i.e., one iteration of a for-loop).
  - Large right panel: unoccupied patches are shown in green, infected sheep are red, and susceptible sheep are white.
7. Note the three tabs in the center: `Interface`, `Info`, and `Code`. Click `Info` and read about the assumptions of the simulation.
8. Click the `Code` tab to see the code.

## Objectives
The goal of this lab is to investigate:
- the threshold condititions for disease outbreaks, and
- the effect of local infection spread on disease dynamics.

For these infection dynamics (as described under the `Info` tab), when infections are only spread globally, a disease outbreak might occur if R<sub>0</sub> >> 1, where R<sub>0</sub> = (&beta;S<sup>E</sup>)/(&alpha; + d) and where &alpha; is `alpha` and &beta; is `beta`. The R<sub>0</sub> equation assumes global reproduction, which is not actually the case for this simulation, and we can't really calculate S<sup>E</sup>, the number of susceptible hosts at equilibrium, but this R<sub>0</sub> equation will be a useful heuristic to understand whether increasing specific parameters will increase the propensity of the population for a disease outbreak.


## To hand-in
1. Consider the R<sub>0</sub> equation. Do larger values values of `beta` suggest larger or smaller values of R<sub>0</sub>? Is an outbreak more likely when `beta` is large or small? What is the meaning of `beta`?
2. Choose parameter values so that infections are only spread globally, and so that R<sub>0</sub> >> 1. Export the Interface from the end of your simulation by choosing `File>Export>Export Interface...`. This will save your Interface as a .png. Describe the trajectory of the proportion of patches that are occupied by infected sheep.
3. Set `beta` very small: note that with global infection spread a disease outbreak will occur.
4. Set `beta` to be small, i.e. `beta < 4`. Change the value of `P` so that now infections are only spread locally. Export the Interface from the end of your simulation by choosing `File>Export>Export Interface...`. Describe the trajectory of the proportion of patches that are occupied by infected sheep. Does local infection spread increase or decrease the potential for an outbreak of disease in the sheep population?
5. Run a simulation with only local infection spread where there is a substantial disease outbreak (i.e., the proportion of patches with infected individuals reaches greater than 0.2). Describe a visual difference that you observe regarding the spatial distribution of the infected sheep relative to when infection spread is global.
6. What is `alpha`? Consider the `alpha` in the R<sub>0</sub> equation. State a hypothesis regarding how large values of `alpha` will affect the disease dynamics. Run a simulation to test your hypothesis. Remember, much like a _real_ experiment, for the computer experiment, you can most easily draw conclusions if you have a control and you manipulate only your experiment variable. Did your simulations support your hypothesis?
7. Can the sheep population go extinct? Describe the state of the population prior to extinction.
8. Let's edit the code! Go to the `Code` tab and find the line of code `set-default-shape turtles "sheep"`. Other shapes that are available are: `"default" "airplane" "arrow" "box" "bug" "butterfly" "car" "circle" "circle 2" "cow" "cylinder" "dot" "face happy" "face neutral" "face sad" "fish" "flag" "flower" "house" "leaf" "line" "line half" "pentagon" "person" "plant" "square" "square 2" "star" "target" "tree" "triangle" "triangle 2" "truck" "turtle" "wheel" "x"`. Change the shape of the 'turtle' (note: that in `Netlogo` individuals are generally referred to as 'turtles' - even when they are actually sheep). Then return to the `Interface` tab and click `setup` to reveal if your changes have taken effect. Then, in the `Code` tab, find the line `ask patches [ set pcolor green ]` and change the color of the empty patches too. Your color options are described here <http://ccl.northwestern.edu/netlogo/docs/programming.html#colors>. Change the patch color and return to the `Interface` and click `setup`. Add a picture of the changes you have made to your lab report by exporting a .png of the Interface.


