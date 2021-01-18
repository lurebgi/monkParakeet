seed = -1
seqfile = All.4DSites.paml
treefile = species_tree.nwk
mcmcfile = mcmc.txt
outfile = 02run.out.txt
ndata = 1
seqtype = 0    * 0: nucleotides; 1:codons; 2:AAs
usedata = 2    * 0: no data; 1:seq like; 2:normal approximation
clock = 3    * 1: global clock; 2: independent rates; 3: correlated rates
model = 4    * 0:JC69, 1:K80, 2:F81, 3:F84, 4:HKY85
alpha = 0.5  * alpha for gamma rates at sites
ncatG = 5    * No. categories in discrete gamma
cleandata = 0    * remove sites with ambiguity data (1:yes, 0:no)?
BDparas = 1 1 0  * birth, death, sampling
kappa_gamma = 6 2      * gamma prior for kappa
alpha_gamma = 1 1      * gamma prior for alpha
rgene_gamma = 1 31.5  * gamma prior for rate for genes
sigma2_gamma = 1 4.5    * gamma prior for sigma^2    (for clock=2 or 3)

print = 1
burnin = 500000
sampfreq = 5000
nsample = 20000
