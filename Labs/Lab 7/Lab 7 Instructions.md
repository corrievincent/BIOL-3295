# Lab 7: Spatially explicit population dynamics
(This file is best viewed on the Github website - and other .md files too)

This lab report is due Thursday Nov 7 at 12pm (in lecture - there is no lab next week)

## Background
This lab uses `Netlogo` to simulate disease dynamics in a sheep population. The model is:
* _An Individual-Based Model_: this means that individuals are represented in the simulation.
* _Stochastic_: this means that events occur with a fixed probability, but on any given run of the simulation, the outcome may be different, i.e., such as a coin toss, the probabiilty of a heads is fixed, but for any given toss a heads may occur or not.
* _Spatially explicit_: this means that space is part of the model formulation: individuals are assigned to locations in space, and the status of neighboring patches can affect a focal individual.

This characteristics are different from all the models we have studied in class so far (aside from Lab 6, last week, where the evolutionary dynamics were stochastic and individuals were explicitly represented). The logistic growth model considers competition for a limiting resource, however, it is assumed that all individuals within the specified area experience the same strength of intra-specific competition. The logistic equation is not spatially explicit because the equation, _dN/dt = rN(1-N/K)_ considers only the population size at time, _t_, and does not consider where indiivduals are located. In contrast, for this lab, where individuals are located will be important.

Open the file `Local_SI.nlogo` in the `NetLogo` program.
