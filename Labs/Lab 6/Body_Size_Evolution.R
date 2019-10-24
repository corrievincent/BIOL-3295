# EVOLUTION OF AGE AND SIZE AT MATURITY IN DROSOPHILA
#__________________________

# Based on the section beginning on p107 of Fox et al. Evolutionary Ecology.
# https://ebookcentral.proquest.com/lib/mun/detail.action?docID=430289

# Remove all objects from the workspace: usually start with this
rm(list=ls())

# Load a package that provides a color palette
# You'll need to install this
require(viridis)

# The number of time steps to run the simulation
# You can change 100 to a different number if you would like
total.time = 100

# Larval mortality rate
# ---------------------
# To figure out that the larval mortality rate was 0.1 individuals per time,
# I tried to reproduce Figure 8.2 from Fox et al: I tried different values of
# l0 until I got a graph that gave reasonable "Survival from egg to adult"
# probabilities as a function of thorax length (see below)
l0 = .1

# Adult mortality rate
# --------------------
# I couldn't find any information on the adult mortality rate so I just
# guessed that adult mortality was 1/2 larval mortality. You could change
# this number, but I'd expect that adult mortality is less than larval.
l1 = l0*0.5

# Population size
#----------------
# This simulation considers evolution in a population that,
# for the most part, doesn't change in size. The population size should be relatively
# large or the evolutionary outcome will be affected by genetic drift.
# Although, Fox et al. 2001 states that their results apply to population growth with
# no density dependence, computation will become very slow if the number of
# individuals is allowed to become very large. To avoid this we assume a fixed population
# size with one birth and one death in a time step.
Popn.Size=1000

# Genotypes
#----------
# Create a list of gentoypes/phenotypes that are present in the population
# The list of numbers below is the thorax size in millimeters. The list below
# considers 3 different genotypes, which correspond to thorax lengths of 
# 1mm, 2mm, and 3mm. Your list of genotypes can consist of more than 3
# genotypes, and you should choose different values for your computational experiments.
genotypes.list = c(1,2,3)

# The number of genotypes
Number.genotypes = length(genotypes.list)

# The different genotypes are assembled into a dataframe where different
# facts about these genotypes can be added, for example, the development
# time to reach a particular lenghth at maturity.
genotypes = data.frame(id=1,L=genotypes.list[1])

# Each genotype is given an "id" named by its position in genotypes.list.
for(i in seq(2,Number.genotypes)){
  genotypes = rbind(genotypes,c(id = i,L=genotypes.list[i]))
}

# The development time function
#-----------------------------
# The time to reach maturity (i.e. be reproductive) is determined by the length
# at maturity, for example, if the length at maturity is quite large, then
# it will take more days to reach maturity
Development = function(L){
  # The graph provided in Fox et al. 2001 Fig. 8.2 was used to estimate the
  # parameters d0, d1, and d2. 
  d0 =4
  d1 = 2.7
  d2 = 5
  # The formula for D, is equation 8.3 on p107 of Fox et al. 2001
  D = d0*L^d1 + d2
  return(D)
}

# Make a graph of development time versus thorax length
#-----------------------
# Make a list of thorax lengths at maturity to go on the x-axis
Lvec = seq(.55,2,.01)
# Now make a graph: on the y-axis are the develpment times for different lengths
# at maturity, on the x-axis are the lengths
plot(Lvec,Development(Lvec),typ="l", lwd=3, ylim = c(0,30), xlim = c(0.55,2), xlab = "Thorax length, L (mm)", ylab = "Development time, d(L)", main = "Fox et al. 2001: Evolutionary ecology, Fig. 8.2")

# Make a graph of the proportion of larvae surviving to maturity as a function
# of thorax length at maturity
#-----------------------------------------------------------
# Every day, there is the same rate of larval mortality, l0, however,
# when the size at maturity is bigger, it takes more days to reach maturity and
# so the probability of dying before reaching the adult stage is higher.
# The equation for the proportion of larvae surviving to adulthood is similiar
# to equation 8.5 in Fox et al. 2001. This graph was used to estimate,
# l0, based on its agreement with Figure 8.2 in Fox et al. 2001
plot(Lvec,exp(-l0*Development(Lvec)),typ="l", lty=2, lwd=3, xlim=c(0.55,2), ylim = c(0,.6), xlab = "Thorax length, L (mm)", ylab = "Survival from egg to adult", main = "Fox et al. 2001: Evolutionary ecology, Fig. 8.2")

# Now we calculate the development time for each of the genotypes and add
# this information to the dataframe summarizing the genotypes
Develop.time = Development(genotypes$L)
genotypes = cbind(genotypes,Develop.time)

# Define the characteristics of all indviduals in the population initially
#------------------------------------------------------------
genotype = NULL
develop.time = NULL
L = NULL
age = NULL

# We begin with all genotypes equally abundant. Run this code below:
for(i in seq(1,Number.genotypes)){
  genotype = c(genotype,rep(i,Popn.Size/Number.genotypes))
  develop.time=c(develop.time,rep(genotypes$Develop.time[i],Popn.Size/Number.genotypes))
  L = c(L,rep(genotypes$Develop.time[i],Popn.Size/Number.genotypes))
  age=c(age,rep(0,Popn.Size/Number.genotypes))
}

# The loop above is used to create a dataframe "Popn" that lists all the
# individuals in the population, their genotype, their age, and the aspects
# of life history that derive from size at maturity, L, i.e. development time
Popn = data.frame(cbind(genotype=genotype,age=age,L=L,develop.time))

# Fecundity is a function of body size at maturity and age:
Fecundity = function(a,L){
  # The parameters weren't given in Fox et al., so I did a bunch of algebra and
  # graphing to figure out what the parameters could be to reproduce Fig. 8.2
  # in Fox et al. I assumed that small implied L = 0.6mm and large implied L = 1.6mm.
  m1 = .45
  # m2: x-intercept
  m2 = 3
  m3 = .15
  m5 = .8
  m4 = 250
  # m0 is described in the text below equation 8.4
  m0 = m4*L^m5
  # m is equation 8.4 on p107
  m = m0*(1-exp(-m1*(a-m2)))*exp(-m3*a)
  # fecundity should not be less than zero
  m[m<0] = 0
  return(m)
}

# Graph age (days) versus female eggs
#------------------------------------
# Vector of ages to plot on the x-axis
avec = seq(0,20,.1)
# The values on the y-axis are given by evaluating the Fecundity function
# for L = 0.6mm (small) and L=1.6mm (large)
plot(avec,Fecundity(avec,0.6), typ="l", lwd=3,ylim = c(0,120), xlab = "Age (days since eclosion)", ylab = "Female eggs, m(x)", main = "Fox et al. 2001: Evolutionary ecology, Fig. 8.2")
lines(avec, Fecundity(avec,1.6), lwd=3, lty=2)

# For the population dynamics, we assume that at each time step one individual dies
# and one individual reproduces making an offspring with the same genotype but
# with age 0. This is called the DB model (death then birth) and I have assumed
# the population has a fixed size (if at least one individual can reproduce).
# Every inidividual in the population gets a "score" for their chance of dying:
# l0 is assigned to all larvae, and l1 to all adults. Any individual dies in
# proportion to its "dscore" based on these mortality rates.

# Setting dscore and bscore = age is preallocation to get the correct size, since bscore
# and dscore will have the same length as the number of individuals in the population.

dscore = age

# Each individual is assinged a "bscore" that reflects their chance of reproducing.
# If the individual has yet to reach reproductive age, then bscore is 0 for them. For all
# individuals that have reach reproductive age, their "bscore" is in proportion to
# their fecundity as determined by the Fecundity() function: depending on their
# age and size at maturity

bscore = age

# At each time step, we count all the individuals with a particular
# genotype, and record these counts in a matrix "Number". Below is
# preallocation, and setting the correct value at t=0 before we let the dynamics
# evolve over time.
Number = matrix(0,total.time+1,1+Number.genotypes)
Number[1,]=c(0,t(unname(table(Popn$genotype))))

# Before we enter the loop, time is set equal to 0. In the loop, Time will
# be incremented with every iteration of the loop
Time = 0

# Run the temporal dynamics to reveal the changes in genotype
# frequency
for(t in seq(1,total.time)){
# Each individual has a corresponding dscore, based on whether the
# individual is a larvae or an adult:
dscore[Popn$age>=Popn$develop.time] = l1
dscore[Popn$age<Popn$develop.time] = l0
# cum.dscore: divide up a number line into intervals with length proportional to the
# dscore for each individual
cum.dscore = cumsum(dscore)
# r1: choose a random number. This random number corresponds to an interval of cum.dscore associated
# with a given individual. Based on this random number an individual is selected to
# die: the individual that dies is randomly choosen, but in proportion its mortality rate.
r1 = runif(1, 0, cum.dscore[length(Popn[,1])])
# ind.d: identifies that row position in the Popn matrix of the individual that will die.
ind.d = min(which(cum.dscore>r1))
# The line of code below removes the individual that experiences the mortality from the population.
Popn = Popn[-ind.d,]
# Below, we re-index the rows so there is not a missing index value.
row.names(Popn) = seq(1,length(Popn[,1]))
# bscore: bscore is zero....
bscore =rep(0,length(Popn[,1]))
# ... unless the individual is an adult. Being an adult is defined as having an age greater than
# the development time needed to reach maturity. Given that an individual is an adult
# their fecundity score is given by the Fecundity() function, which depends on the individuals age and size.
bscore[Popn$age>=Popn$develop.time]=Fecundity(Popn$age[Popn$age>=Popn$develop.time],Popn$L[Popn$age>=Popn$develop.time])

# cum.bscore: break-up a number line so that intervals are proportional to
# the bscore
cum.bscore = cumsum(bscore)
if(cum.bscore[length(Popn[,1])]>0){
# Choose a random number to select the individual that reproduces, in proportion to their bscore.
r1 = runif(1, 0, cum.bscore[length(Popn[,1])])
# ind.b: the row corresponding the individual that is selected to reproduce
ind.b = min(which(cum.bscore>r1))
# Create a new individual with: the same genotype id as the parent; age = 0; the same length at maturity
# as the parent; and the same development time as the parent.
new.ind = c(Popn$genotype[ind.b], 0,Popn$L[ind.b],Popn$develop.time[ind.b])
# Add the new individual to the population
Popn = rbind(Popn,new.ind)
# Fix up the row index names
row.names(Popn) = seq(1,length(Popn[,1]))
}
# For one iteration of the loop, how much does time increment? One idea
# was to base this on the time for one mortality to occur, which is given
# by under a Gillespie algorithm implementation, however, this seemed
# to give the evolution of very small L, so I commented it out.
# dt = -log(runif(1))/cum.dscore[length(Popn[,1])]
# Let's assume that each iteration of the loop corresponds to one day
dt=1

# The new value of Time (upon the completion of this iteration of the loop)
# is the old value of Time (from the previous iteration of the loop) + dt.
Time = Time+dt
# As time progresses, individuals age too.
Popn$age = Popn$age+dt
# Count up the number of individuals with each genotype currently in the population.
# the table() function gives the counts that are non-zero and so the role of the first
# instance of "genotypes.count" is to assign 0 for the all the genotypes that are not
# observed.
genotypes.count = rep(0,Number.genotypes)
genotypes.summary = table(Popn$genotype)
genotypes.count[as.numeric(names(genotypes.summary))]=unname(genotypes.summary)
# Record the time, and the number of individuals with each genotype.
Number[t+1,] = c(Time, genotypes.count)
}

# Plot the results
#----------------
# Fix the color palette, so that we can make a legend that will be
# correct for a variable number of genotypes
Colours = viridis(Number.genotypes)
plot(Number[,1], Number[,2], typ="l", col = Colours[1], ylim = c(min(Number[,2:(Number.genotypes+1)]),max(Number[,2:(Number.genotypes+1)])), xlab = "time, days", ylab = "no. of ind. with genotype i", main = "Evolution of body size at maturity")
for(i in seq(2,Number.genotypes)){
lines(Number[,1], Number[,i+1], typ="l", col = Colours[i])
}
legend("topleft", legend = genotypes$L, col=Colours, lty = rep(1,Number.genotypes),box.lwd = 0)

# SOME NOTES
#-----------
# 1. The outcome of the evolutionary dynamics are quite sensitive to the choice of
#   dt, which was made arbitrarily.
# 2. The initial condition starts with only larvae, and so for the first few iterations
#    of the loop there is no reproduction. During this time, the population decreases in size
#    and it is only once at least one individual is an adult, that reproduction begins and
#    the population size stabilizes. Therefore, whatever the value of "Popn.Size" the population
#    will actually stabilize at a value a bit lower than this.
# 3. The graph shows the length at maturity. If you would like to know the development
#    time, you need to type > Development(L0) into the console, where L0 is a number
#    corresponding to the length at maturity you want to know the corresponding development
#    time for.
# 4. You can make a graph for "Female eggs, m(x)" for a given length maturity, L0 by
#    using the following commands:
#  avec = seq(0,20,.1)
#  plot(avec,Fecundity(avec,L0), typ="l", lwd=3,ylim = c(0,120), xlab = "Age (days since eclosion)", ylab = "Female eggs, m(x)")
