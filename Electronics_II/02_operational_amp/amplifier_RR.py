def amp(f, R1, R2):
    import numpy as np 
    h = (R2/R1) * np.ones(np.size(f))
    return h