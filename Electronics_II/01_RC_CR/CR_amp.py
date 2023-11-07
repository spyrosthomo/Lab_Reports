def amp(f, C, R) :
    import math 
    import numpy as np
    h = 2.0*math.pi*f*C*R/np.sqrt(1+ (2*np.pi*f*C*R)**2)
    return h