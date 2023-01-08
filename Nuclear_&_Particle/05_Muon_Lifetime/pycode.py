#muons lifetime 
import matplotlib.pyplot as plt 
import numpy as np 
import math
from scipy.optimize import curve_fit

#%matplotlib inline
####### opening the file muons data
#
# First we make a list for the measured times that we want to process.
# Create empty list with time values (ns)
time = [];

with open('data_muons.data') as file: 
    for line in file: # read each line 
        col1_element,col2_element = line.split() 
        
        # take times only if t<40.000ns, all the other muons have not decayed
        if int(col1_element)<40000:
            # fill the list of data (Time) and convert the ns to μs
            time.append(float(col1_element)*0.001);
            
#Check that your data were imported correctly.
#Print the 10 first values of the times, open your file and compare them.

#print(time[0:10])

#################################333
# Histogram
Nbins = 40 

# 
counts, bin_edges = np.histogram(time,bins=Nbins)

# find the bin centers 
bin_centers = 0.5*(bin_edges[1:] + bin_edges[:-1])


# remove the data with zero counts - you can ignore that -
i_delete = []
for i in range(len(counts)):
    if counts[i]==0:
        i_delete.append(i)
counts = np.delete(counts,i_delete)
bin_centers = np.delete(bin_centers,i_delete)

# ReminderL For each bin the counts follow th Poisson distribution 
# For this reason the error of a bin with counts is sqrT(counts)
#
#

counts_error = np.sqrt(counts)

# We have the counts and their errors 
plt.figure(figsize=[12,8])
plt.errorbar(bin_centers, counts, counts_error, fmt='.', color='black')
plt.grid(True)
plt.xlabel("time [$\mu$s]", fontsize=15)
plt.ylabel("counts", fontsize=15)

plt.show()


#------------------------------------------
#  DEFINE OUR MODEL 
#
#  f(t;\tau,A) = A exp(-t/\tau)
# A, \tau are the fit parameters which we want to estimate via the data 
#
#
A_initial       = 15000
tau_initial     = 2 
params_initial = [tau_initial, A_initial]

#------------------------------------
# Definition of the model
def fit_model(x, tau, A):
    return A*np.exp(-1.*(x/tau))

# perform the chi^2 fit 
#params, covariance_matrix = curve_fit(fit_model, bin_centers, counts, p0=params_initial, sigma=counts_error)
params, covariance_matrix = curve_fit(fit_model, bin_centers, counts, p0=params_initial, sigma=counts_error)



# calculate the paramters errors by taking the aquare root of the diagonal of the covarince matrix 

params_errors = np.sqrt(np.diag(covariance_matrix))

#print results 
print("tau = ", params[0], " +/-",  params_errors[0], "microseconds")
print("A   = ", params[1], " +/- ", params_errors[1])

# make plot of the data with fitted model 

plt.figure(figsize=[12,8])
plt.plot(bin_centers,fit_model(bin_centers, params[0], params[1]), color='blue')
plt.errorbar(bin_centers,counts, counts_error, fmt='.', color='black')
plt.grid(True)
plt.xlabel("time [$\mu$s]", fontsize=15)
plt.ylabel("model value",fontsize=15)

plt.show()

    