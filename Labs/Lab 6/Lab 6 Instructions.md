# Lab 6: Simulating the evolution of body size and age at maturation for _Drosophila_
(This file is best viewed on the Github website - and other .md files too)

This report is due Wednesday Oct 30 at 2pm

<img src="https://upload.wikimedia.org/wikipedia/commons/c/cb/Biology_Illustration_Animals_Insects_Drosophila_melanogaster.svg">

Attribution: Madboy74 [CC0]

This lab is based on the section _The evolution of age and size at maturity in Drosophilia_ beginning on p107 in Fox et al. 2001 Evolutionary Ecology, which is available as an ebook through the MUN library https://ebookcentral.proquest.com/lib/mun/detail.action?docID=430289.

The relevant evolutionary biology is that _Drosophilia_ that mature at a larger size:
1. Will produce more eggs, but
1. Will take longer to develop to adulthood (i.e. reproductive age), and
1. Since development time is longer, there is a higher chance of dying before reaching maturity.

All of these points are illustrated in Figure 8.2 on p108 of Fox et al. 2001. As such, and as shown in the lower panel of Figure 8.2 on p108 of Fox et al., evolution selects for _Drosophilia_ with intermediate sizes at maturity. Specifically, size is measured as the thorax length, and Fox et al. notes that observed thorax sizes are between 0.7 and 1.5 mm in North America.

The script `Body_Size_Evolution.R` considers the information provided on p107-108 of Fox et al. 2001 and simulates the evolutionary dynamics to see which genotypes prevail and which go extinct. If you open this file in `RStudio` and click `Source` you will see that four graphs are produced.

I was unable to easily find the parameters corresponding to Figure 8.2 in Fox et al. and so I guessed the parameter values until I was able to get graphs that matched Fox et al.: the first three graphs are checking the correspondence between the parameters that we are using for the simulations, and Figure 8.2 from Fox et al. This simulation procedure does have limitations, but despite the guess work, these parameters seem to be estimated quite well.

The fourth graph shows the evolutionary dynamics of the genotypes over time. The default code values have:

```
total.time = 100
```

which corresponds to `100*dt` days and `dt=0.1`, so 10 days. For a simulation this short, we can see the changes resulting from one individual dying or reproducing, but a simulation this short does not give us an idea of the long term population dynamics, and so you might wish to increase `total.time` in the code, while keeping in mind that the larger `total.time` is, the longer your simulation will take to finish.

Next, let's consider

```
genotypes.list = c(1,2,3)
```

This line of code states that there are three genotypes present in the population, and these genotypes correspond to thorax lengths at maturity of 1 mm, 2 mm, and 3 mm. The fourth graph produced by this R script shows that after a simulation for a long time, the genotypes with thorax lengths _L_ = 2 mm and _L_ = 3 mm go extinct, and the genotype with thorax length _L_ = 1 mm goes to fixation.

Your task for this lab is to:
1. Explore the evolutionary dynamics more thoroughly, and
1. To understand the assumptions that this script makes as it implements the evolutionary dynamics.

## Exploring the population dynamics more thoroughly
So far, we know that if there are 3 genotypes corresponding to maturity at 1 mm, 2 mm, and 3 mm thorax lengths, then maturity at 1 mm thorax length will be selected. We do not know anything about other values of thorax length, and we do not know to what extent the presence of other genotypes shapes the outcome of evolution (i.e., if there were just two genotypes _L_=1 mm and _L_=2 mm (but not _L_=3 mm), will _L_=1 mm still be the strategy that goes to fixation?)

You are to devise a set of numerical experiments to better understand the evolutionary dynamics of body size at maturation by changing `genotypes.list`, running simulations, and recording the outcome.

### You are to hand-in
- A table that lists: the genotypes you considered; and the outcome of each simulation, for a series of numerical experiments.
- A description of the logic you used in deciding what values of `genotype.list` to use for your numerical experiments.
- Answers to the following questions:
  - Do you expect there is a single best body size at maturity, that if present in the population will always go to fixation? What is this value? Explain how your table of results led you to this conclusion.
  - Does the outcome of the evolutionary dynamics depend on the size of mutations? Describe the simulations that you did to test this.
  
Specifically, if mutations have small effect, then competing genotypes will have similar values, and you might consider a simulation like this:

```
genotypes.list = c(0.95,1,1.05)
```

but if mutations have big effect, then the competing genotypes will be more different, and you might consider a simulation like this:

```
genotypes.list = c(0.5,1,1.5)
```


## Understanding the assumptions that this script makes regarding the evolutionary dynamics

Pseudocode is a step-by-step description of how an algorithm works. For example, pseudocode for numerically solving a discrete-time population growth model might look like this:

```
1. Assign the parameters numerical values.
1. Define a vector listing the values of time to be considered.
1. Preallocate a vector that will record the population size for each point in time.
1. Assign a value for the initial population size.
1. Define a loop, such that, the different values of time are sequentially considered, and so that the current size of the population is used to calculate the size of the population at the next time step.
1. Within the loop, record the current time and the current population size.
1. At the end of each loop iteration, advance time to its next value, and set the current value of the population size equal to the value that had been calculated for the population size at the next time step.
```
A valuable aspect of reporting code in this way is skipping over non-essential details, such as syntax and exact numerical values, and to focus instead on the concepts of what the code is doing.

### To hand-in
You are to write pseudocode that describes how this evolutionary simulation works.

Your pseudocode should:
- Be an ordered list of steps.
- Describe in words what the script is doing.
- Ignore the parts of the code where graphs are made.
- Ignore the parts of the code where I am checking that the parameters values match with Figure 8.2 of Fox et al. 2001.
- Focus on describing the steps, and the procedural assumptions that are made, and that give rise to the evolutionary dynamics.
- Start by mentioning what needs to be defined before entering into the loop. For example, we need to define a function that describes the number of female eggs produced by an individual, or more generally, the reproduction of an individual. Focus on what is done, without providing too many specific details that don't contribute to understanding the building blocks of this evolutionary process. For example, you do not need to provide the value of `d0`, that is too much of a specific detail, your pseudocode needs to focus how the simulation works.

To write the pseudocode you will need to read through the comments of the R script `Body_Size_Evolution.R`. You should hand in your pseudocode.

