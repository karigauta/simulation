############### Packages to use     ###############
library(gamlss.dist) # for making zero inflated poisson random deviates for mating willingness
library(pedigree)    # for calculating inbreeding and trimming pedigree
library(data.table)  # faster then data frames
library(mvtnorm)     # generating random deviates from a multivariate normal distribution

##############Switches, best left alone ###########
assortative <- 1
random <- 0
no.selection <- 0
selection <- 1
blup <- 2
############### Controls for simulation ############
n.females <-  1000             # NUMBER OF FEMALES
nruns <- 2                    # how many replicates of the simulation
n <- 5                        # number of generation per replicate
mating.method <- assortative   # mating method, random or assortative
selection.method <- blup  # selection mating, selection = truncation,  no selection = next gen is chosen at random
make.obs.file <- 1 # 1 = make observation file, 0 otherwise
use.true.sire <- 0 # 1 if true sire of kits is wanted for BV prediction, 0 otherwise
############# Mean settings for traits   #####################
mean.body.size.male <- 3000
mean.body.size.female <- 1650

############### Innter settings, change at own risk##########
male.ratio <-  6               # MALE TO FEMALE RATIO
male.inf <-  0.98              # % ODDS OF MALE BEING NOT BARREN
female.inf <- 0.9              # % ODDS OF FEMALE BEING NOT BARREN
prop.oldfemales <-  0.4        # Proportion of older females
ibd.fertility <- 0.06          # Inbreeding depression on fertility NOTE: not in use atm
max.age.females <- 3           # define how old the females can be
yearling.effect <- -0.07       # setting for yearling effect, current best guess is -0.07
sib.effect.male <- -13.4      # Effect on body size of (male) one extra kit in litter, Hansen(1997)
sib.effect.female <- -18.6    # Effect on body size of (female) one extra kit in litter, Hansen(1997)
quantile.setting <- 0.4        # amount of kits to throw away because of too low littersize
mating.will.yearling.1st          <- 0.95 # probability of yearling being mated
mating.will.yearling.2nd          <- 0.98 # probability of yearling being remated
mating.will.old.1st               <- 0.98 # probability of old female being mated
mating.will.old.2nd               <- 0.98 # probability of old female being remated
pr.barren.one.mating.yearling     <- 0.8 # probability of single mated yearling being barren
pr.barren.double.mating.yearling  <- 0.9 # probability of double mated yearling being barren
pr.barren.one.mating.old          <- 0.9 # probability of single mated old female being barren
pr.barren.double.mating.old       <- 0.95 # probaility of double mated old female being barren

############# Variance settings for traits ###################
variance.fertility     <-  0.0122738     # Genetic variance of fertility, live born
var.perm.env.ls        <-  0.0004464     # Variance of permanent environment of litter size of dam
var.body.size.direct   <-  40000         # Genetic variance of body size, direct effect 
var.body.size.spec.env <-  5300          # variance of specific environment (litter) on body size
var.res.body.size      <-  32500         # residual variance of body size
roof.body.size         <-  2400          # Maximum body weight of females to be allowed for selection
bw.eff.damage          <-  34.5          # effect of dam age on weight of males
############# (Co)Variance matrix ############################
sigma <-  matrix( 
  c(1, -0.5, -0.5, 1), # genetic correlations of traits
  nrow=2, 
  ncol=2) 
colnames(sigma) <- c("body.size.direct","litter.size")
rownames(sigma)<- c("body.size.direct","litter.size")
