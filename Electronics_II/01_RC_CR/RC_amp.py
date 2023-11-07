def amp(f, C, R):
    import math
    import numpy as np 
    h = 1/np.sqrt(1+ (2*np.pi*f*C*R)**2) 
   #np.sqrt(1+ (2*np.pi*f*C*R)**2)
    return h 