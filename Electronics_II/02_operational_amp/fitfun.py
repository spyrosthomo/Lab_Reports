def func4(x, a, b, c, d, e):
    return d*x**3 + a*x**2 + b*x + c + e*x**4

def func3(x, a, b, c, d):
    return d*x**3 + a*x**2 + b*x + c   
    
def func2(x, a, b, c):
    return a*x**2 + b*x + c 

def be(x,a,b,c): 
    import numpy as np 
    return a* (1 + np.exp(b*(x-c))  )**(-1)