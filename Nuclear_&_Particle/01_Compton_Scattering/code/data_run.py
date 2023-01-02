# -*- coding: utf-8 -*-
"""
Created on Tue Dec 20 16:50:19 2022

@author: ssppy
"""

import math 
import numpy as np
import matplotlib.pyplot as plt

Eg   = np.array([849.9, 669.5, 1235.6]); 
Tmax = np.array([602.2, 485.5, 967.9 ]);
Ebs  = np.array([139.3, 126.5, 155.7 ]);

summ = Tmax + Ebs;
DE   = np.divide(Eg-summ, Eg); 
print("SUM      = ",summ)
print("delta E = ", DE)
      