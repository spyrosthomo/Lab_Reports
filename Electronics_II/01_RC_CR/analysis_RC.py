import matplotlib.pyplot as plt
import math 
import numpy as np
import pandas as pd
from   scipy.optimize import curve_fit 
from   scipy          import stats
import re 
#--------------------------------------------------
import RC_amp
import lin_fun
#-------------------------------------------------
# constants 
R       = 15.05e+3
C       = 10.00e-9
Ui      = 2.0
deltaUi = 0.2

filename_in  = "./data/data_RC_new.txt" #"/media/sthomopo/DATA/ssppy/Documents/ΣΧΟΛΗ/9ο/Electronics II/lab/reports/01_RC_CR/data_CR.txt"
filename_psp = "./data/pspice/RC_f.txt" 
filename_out = "./data/data_RC_out_new.txt"
#-------------------------------------------------
# analysis
#-------------------------------------------------
# import data for RC 
data_in  = np.genfromtxt(filename_in ,comments="#", delimiter=",")     # f  |  u_R    | Δt    | division R | division t | Δf
f        = data_in[:,0]
uC       = data_in[:,1]
Dt       = data_in[:,2]*1e-06
amp      = uC/Ui
#deltaf   = data_in[:,5]
fmin     = np.min(f)
fmax     = np.max(f)

# new matrix containing:  errors / A_{db} +- / phi +-
deltaUC  = data_in[:,3]/10
deltaDt  = data_in[:,4]*1e-06/10
Adb      = 10.0*np.log10(amp)
phi      = 2.0 * math.pi * Dt * f  
deltaAmp = np.sqrt((deltaUC/Ui)**2 + (uC*deltaUi/(Ui*Ui))**2 )
deltaAdb = (10.0/math.log(10)) * deltaAmp / amp
#deltaPhi = 2.0*math.pi*np.sqrt(  (Dt * deltaf)**2 + (f * deltaDt)**2)
deltaPhi = 2.0*math.pi*  (f * deltaDt)   # without freq dev
data_fin = np.column_stack((f, amp, deltaAmp, Dt*1e+06, deltaDt*1e+06, Adb, deltaAdb, phi, deltaPhi))

# Save new matrix to datafin_CR.txt
np.savetxt(filename_out, data_fin, delimiter=" & ", fmt='%.2f', header="!# f | UR | deltaUR | Dt| deltaDt | Adb| deltaAdb| phi | deltaPhi")
# data_latex = np.array2string(data_fin, separator=" & ")
#     # change a bit the  format 
# data_latex = data_latex.strip().split("\n")
# pos = {2,4,6,8}
# def replace_nth_occurrence(input_str, target, replacement, n):
#     parts = input_str.split(target)
#     replaced_parts = [replacement if i in target_positions else part for i, part in enumerate(parts)]
#     return target.join(replaced_parts)
# lines = input_text.strip().split('\n')
# for i, line in enumerate(lines):
#     lines[i] = replace_nth_occurrence(line, "&", "\pm", target_positions)
# data_latex = '\n'.join(lines)
#print(data_latex)

#---------------------------------------------------
# theoretical model 
#---------------------------------------------------
ft     = np.linspace(fmin, fmax, round(1e+06))
amp_th = RC_amp.amp(ft, C, R)
Adb_th = 10.0*np.log10(amp_th)
phi_th = np.arctan(2.0*np.pi*ft*C*R)

#---------------------------------------------------
# fitted function
#---------------------------------------------------
parameters, cov = curve_fit(RC_amp.amp, f, amp)
fit_C           = parameters[0]
fit_R           = parameters[1]

amp_fit         = RC_amp.amp(f, fit_C, fit_R )
Adb_fit         = 10.0*np.log10(amp_fit)
phi_fit         = np.arctan(2.0*np.pi*f*fit_C*fit_R)

print("Fit params : ")
print(r"fit_R = ",  fit_R,   "fit_C = ", fit_C)
#---------------------------------------------------
# PSpice simulation 
#---------------------------------------------------
with open(filename_psp, 'r', errors="ignore") as file: 
    dat = file.read()
dat         = dat.replace("\t", ",").replace("dB","")
dat         = re.sub("[\(\)�]", "", dat)  #°]", "",dat)
data_pspice = np.genfromtxt(dat.splitlines(), delimiter=",")

f_psp       = data_pspice[:,0]
Adb_psp     = data_pspice[:,1]        # not UC/Ui but just UC ???
phi_psp     = -data_pspice[:,2]*math.pi/180
amp_psp     = 10**(Adb_psp/10)  / 4
Adb_psp     = 10.0*np.log10(amp_psp)

#--------------------------------------------------------------
# find A gradient for f >> fb 
#--------------------------------------------------------------
fb      = 1671
ff      = f[0:5]
ffmin   = f[0]; ffmax   = f[5]
AAdb    = Adb[0:5]
AAdbmin = Adb[0] ; AAdbmax = Adb[5]

A, B, r_value, p_value, std_err   = stats.linregress(ff, AAdb)


parameters2, cov2  = curve_fit(lin_fun.amp, ff, AAdb)
p1                 = parameters2[0]
p2                 = parameters2[1]


#AAdb_fit           = p1 * np.linspace(ffmin, ffmax, 100) + p2 
AAdb_fit           = A * np.linspace(ffmin, ffmax, 100) + B
print("Fit params2 : ")
print(r"p1 = {},   p2 = {}", p1, p2)
print(r"A  = {},   B  = {}", A, B)


#-----------------------------------------------------------------------------
# plots
#-----------------------------------------------------------------------------
#------------ Ur - f 
fig1 = plt.figure(); 
ax1  = fig1.add_axes([0.1,0.1,0.82,0.85])

ax1.set_xlabel('f(Hz)')
ax1.set_ylabel(r'$u_C/u_i$')

#experiment
ax1.plot(f, amp, marker='o', linestyle='', ms=1.5, mew=3, color='b', label='data' )  # experimental data
ax1.errorbar(f, amp, yerr=deltaAmp, ls='' )
#theory
ax1.plot(ft, amp_th, label='theory')
#fit
ax1.plot(f, amp_fit, label='fit')
# pspice 
ax1.plot(f_psp, amp_psp, label='pspice')

ax1.legend(loc=5)
ax1.grid()
ax1.set_xscale("log")

fig1.savefig("./plots/RC_f-Uc.pdf")
#-------------------------------------------------------
#-- Adb - f 
fig2 = plt.figure();
ax2  = fig2.add_axes([0.1,0.1,0.82,0.85])

ax2.set_xlabel('f(Hz)')
ax2.set_ylabel(r'$A_{db}=10\cdot log_{10}(u_C/u_i)$')
#ax2.set_yscale("log")

#experimenta
ax2.plot(f, Adb, marker='o', linestyle='', ms=1.5, mew=3, color='b', label='data' )  # data
ax2.errorbar(f, Adb, yerr=deltaAdb, ls='' )
#theory
ax2.plot(ft, Adb_th, label='theory')
#fit 
ax2.plot(f, Adb_fit, label='fit')
#pspice
ax2.plot(f_psp, Adb_psp, label='pspice')

# find f_c: Adb=-3 
ax2.plot([115,1671], [-3,-3],   color='black', lw=0.8)
ax2.plot([1641, 1671],[-22,-3], color='black', lw=0.8)
yticks2     = ax2.get_yticks(); yticks2_lab = ax2.get_yticklabels()
ax2.set_yticks( list(yticks2) + [-3]   ); ax2.set_yticklabels(list(yticks2_lab) + [r"$-3$"])
ax2.scatter(1671, -3, color="red", marker="*", label="$Point, \\text{} (f_b, A_{db})=(1671,- 3)$")

ax2.legend(loc=3)
ax2.grid()
ax2.set_xscale("log")

fig2.savefig("./plots/RC_f-Adb.pdf")
#------------------------------------------------------
#-- phi - f 
fig3 = plt.figure();
ax3  = fig3.add_axes([0.1,0.1,0.82,0.85])

ax3.set_xlabel('f(Hz)')
ax3.set_ylabel(r'$\phi(rad)$')
#ax3.set_yscale("log")

# experiment
ax3.plot(f, phi, marker='o' , linestyle='', ms=1.5, mew=3, color='b', label='data' )   # data
ax3.errorbar(f, phi, yerr=deltaPhi, ls='')
#theory
ax3.plot(ft, phi_th+0.01, label='theory')
# fit 
ax3.plot(f , phi_fit, label='fit')
# pspice 
ax3.plot(f_psp, phi_psp, label='pspice')

ax3.legend(loc=5)
ax3.grid()
ax3.set_xscale("log")
fig3.savefig("./plots/RC_f-phi.pdf")
#-----------------------------------------------------
#-----------------------------------------------------

#linear Adb
fig4 = plt.figure();
ax4  = fig4.add_axes([0.1,0.1,0.82,0.85])
#ax4.set_xscale("log")

ax4.set_xlabel('f(Hz)')
ax4.set_ylabel(r'$A_{db}=10\cdot log_{10}(u_R/u_i)$')

ax4.set_ylim(-0.7,0.5)
ax4.set_xlim(40  ,260)
# experiment
ax4.plot(ff, AAdb, marker='o', linestyle='', ms=1.5, mew=3, color='b', label='data' )  # data
# theory
# fit 
ax4.plot(np.linspace(ffmin, ffmax, 100), AAdb_fit, color='red', label='fit')

ax4.legend(loc=1)
ax4.grid()
fig4.savefig("./plots/RC_f-Adb-linear.pdf")
#=== Fill Experimental 
#plt.show()