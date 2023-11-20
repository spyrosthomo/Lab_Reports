import matplotlib.pyplot as plt
import math 
import numpy as np
import pandas as pd
from   scipy.optimize import curve_fit
from   scipy          import stats
import re 
#-------------------------------------------------
import amplifier_RR
import fitfun
#-------------------------------------------------
# constants 
R1       = 0.986*1e+03 # Ohm
R2       = 4.32*1e+03  #32.85*1e+03 # Ohm
Ui       = 0.1         # Volt
deltaUi  = 0.01

filename_in  = "./data/data_R2_2.txt" 
filename_out = "./data/data_R2_2_out.txt"
filename_psp = "./data/pspice/rr2_4.65.txt"
#------------------------------------------------
# analysis
# import data for r2=4.65k
data_in   = np.genfromtxt(filename_in ,comments="#", delimiter=",")     # f  |  u_R    | Δt(μs)    | division R | division t 
f         = data_in[:,0]#*1e+03    # kHz   
uOut      = data_in[:,1]          # volts
Dt        = data_in[:,2]*1e-06    # secs
deltaUOut = data_in[:,3]/10       # error in Uout in Volts
deltaDt   = data_in[:,4]*1e-06/10 # error in Dt in secs

amp       = uOut/Ui
fmin      = np.min(f)
fmax      = np.max(f)

#--------------------------------------------
# new matrix containing: error/ A_db +- / phi +- 
Adb        = 20.0*np.log10(amp) 
phi        = 2.0 * np.pi * Dt * f *1e+03 
deltaAmp   = np.sqrt( (deltaUOut/Ui)**2 + (uOut*deltaUi/(Ui*Ui))**2  )
deltaAdb   = (10.0/math.log(10)) * deltaAmp / amp
deltaPhi   = 2.0*math.pi * f*1e+03 *deltaDt # without frequency deviations
data_fin   = np.column_stack((f, uOut, deltaUOut, Dt*1e+06, deltaDt*1e+06, Adb, deltaAdb, phi, deltaPhi))
# Save new matrix to data_R2_{1,2}_out.txt
np.savetxt(filename_out, data_fin, delimiter=" & ", fmt='%.2f', header="!# f(kHz) | Uout | deltaUOut | Dt(μs) | deltaDt(μs) | Adb| deltaAdb| phi | deltaPhi")
data_latex = np.array2string(data_fin, separator=" & ")

#---------------------------------------------------
# theoretical model for ideal amplifier 
#---------------------------------------------------
ft     = np.linspace(fmin,fmax,round(1e+6))
amp_th = amplifier_RR.amp(ft, R1, R2)
Adb_th = 20.0*np.log10(amp_th)      #CR_amp.amp(ft, C, R))
phi_th = np.pi*np.ones(np.size(ft)) # np.pi/2.0 - np.arctan(2.0*np.pi*ft*R*C)


#---------------------------------------------------
# fitted funciton
#---------------------------------------------------
# poly fit for amplitude
parameters, cov = curve_fit(fitfun.func4, f, Adb)
a = parameters[0]
b = parameters[1]
c = parameters[2]
d = parameters[3]
e = parameters[4]
Adb_fit = a*ft**2 + b*ft + c + d*ft**3 + e*ft**4

print("Fit params: ax^2 + bx + c")
print(r"a = ",a , "b = ",b, "c = ", c, "d = ",d, " e = ", e )

#---------------------------------------------------
# pspice 
#---------------------------------------------------
with open(filename_psp, 'r', errors='ignore') as file:
    dat = file.read()
dat         = dat.replace("\t", ",").replace("dB","")
dat         = re.sub("[\(\)�]", "", dat)  #°]", "",dat)
data_pspice = np.genfromtxt(dat.splitlines(), delimiter=",")

f_psp       = data_pspice[:,0]*1e-3
Adb_psp     = data_pspice[:,1]        # 
phi_psp     = data_pspice[:,2]*math.pi/180
#amp_psp     = 10**(Adb_psp/20) 

#
#-----------------------------------------------------------------------------
# plots
#-----------------------------------------------------------------------------
#-------------------------------------------------------
#-- Adb - f 
fig1 = plt.figure()
ax1  = fig1.add_axes([0.1,0.1,0.82,0.85])
ax1.set_xlabel('f(Hz)')
ax1.set_ylabel(r'$A_{db}=20\cdot log_{10}(V_o/V_i)$')

# experiment 
ax1.plot(f, Adb, marker="o", linestyle='', ms=1.5, mew=3, color='b', label='data')
ax1.errorbar(f, Adb, yerr=deltaAdb, ls='' )
# theory
ax1.plot(ft, Adb_th, color='g', label='theory-ideal amp')
# fit 
ax1.plot(ft, Adb_fit, color='r', label='fit')
#pspice
ax1.plot(f_psp, Adb_psp, label='ltspice')

#find f_b
    #plot lines
ax1.plot([159.8, 159.8], [0, 9.87], color='black', lw=0.7)
ax1.plot([0, 159.8], [9.87, 9.87], color='black', lw=0.7)
    #add tickers
xticks      = ax1.get_xticks(); xticks_lab = ax1.get_xticklabels()
yticks      = ax1.get_yticks(); yticks_lab = ax1.get_yticklabels()
ax1.set_yticks( list(yticks) + [28.13]); ax1.set_yticklabels(list(yticks_lab) + [r"$28.13$"])
ax1.set_xticks( list(xticks) + [15.77]); ax1.set_xticklabels(list(xticks_lab) + ["15.77"])
    # plots the point
ax1.scatter(159.8, 9.87, color="red", marker='*', label="$Point, \\text{ } (f_b, A_{db})=(159.80kHz, 9.87db)$")


ax1.legend(loc=6)
ax1.grid()
ax1.set_xscale("log")
fig1.savefig("./plots/amplifier_RR2_Adb.pdf")
#-------------------------------------------------------
#-- phi - f 
fig2 = plt.figure()
ax2  = fig2.add_axes([0.1,0.1,0.82,0.85])
ax2.set_xlabel('f(Hz)')
ax2.set_ylabel(r'$\phi(rad)$')

# experiment
ax2.plot(f, phi, marker='o', linestyle='', ms=1.5, mew=3, color='b', label='data')
ax2.errorbar(f, phi, yerr=deltaPhi, ls='')
# theory 
ax2.plot(ft, phi_th, color='g', label='theory-ideal amp')
# fit 
#ax2.plot(ft, phi_fit, color='r', label='fit')
#pspice
ax2.plot(f_psp, phi_psp, label='ltspice')

ax2.legend(loc=6)
ax2.grid()
ax2.set_xscale("log")
fig2.savefig("./plots/amplifier_RR2_phi.pdf")
#-----------------------------------------------------------
#plt.show()