# CALCULATING EIGENVALUES AND THE RIGHT EIGENVECTOR IN R
##--------

# We have done this exact example in lecture. Here we are
# verifying that we can get the same conclusions using R.

# Define our projection matrix
A = matrix(c(0,2,0.5,.1), 2,2, byrow=TRUE)

# Type A into the console to check that A has the correct
# number of rows and columns and the numerical entries in the
# correct place.

# The function eigen() is a built-in function that will
# calculate the eigenvalues and eigenvectors for the projection
# matrix A.
ev = eigen(A)

# Type ev into the console.
# There are two eigenvalues. Why are there two? Which is the dominant eigenvalue?
# Will this population grow (for a positive initial number of individuals)?

# There is an eigenvector (2 rows x 1 column) associated with each eigenvalue
# (= 2 eignvectors). The eigenvector associated with the nth eigenvalue is in
# column n.

# The dominant eigenvalue is the first one. Therefore, the associated right eigenvector,
# that will tell us about the long-term relative stage abundance, is
# in the first column.
vec1 = ev$vectors[,1]

# Eigenvectors are not unique - they can be multiplied by a constant and are
# still the same eigenvector
norm.vec1 = -100*vec1

# What happens if our initial population size is a right eigenvector?
A%*%norm.vec1

# How does this compare to if the right eigenvector is multiplied by the dominant
# eigenvalue?
1.05*norm.vec1