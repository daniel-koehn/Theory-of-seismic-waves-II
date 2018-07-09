# Import Libraries 
# ----------------
import numpy as np
from numba import jit
import matplotlib
import matplotlib.pyplot as plt
from pylab import rcParams

# Ignore Warning Messages
# -----------------------
import warnings
warnings.filterwarnings("ignore")

from mpl_toolkits.axes_grid1 import make_axes_locatable

@jit(nopython=True) # use JIT for C-performance
def update_d2px_d2pz(p, dx, dz, nx, nz, d2px, d2pz):
    
    for i in range(1, nx - 1):
        for j in range(1, nz - 1):
                
            d2px[i,j] = (p[i + 1,j] - 2 * p[i,j] + p[i - 1,j]) / dx**2                
            d2pz[i,j] = (p[i,j + 1] - 2 * p[i,j] + p[i,j - 1]) / dz**2
        
    return d2px, d2pz

# Define simple absorbing boundary frame based on wavefield damping 
# according to Cerjan et al., 1985, Geophysics, 50, 705-708
def absorb(nx,nz):

    FW = 60     # thickness of absorbing frame (gridpoints)    
    a = 0.0053
    
    coeff = np.zeros(FW)
    
    # define coefficients in absorbing frame
    for i in range(FW):    
        coeff[i] = np.exp(-(a**2 * (FW-i)**2))

    # initialize array of absorbing coefficients
    absorb_coeff = np.ones((nx,nz))

    # compute coefficients for left grid boundaries (x-direction)
    zb=0 
    for i in range(FW):
        ze = nz - i - 1
        for j in range(zb,ze):
            absorb_coeff[i,j] = coeff[i]

    # compute coefficients for right grid boundaries (x-direction)        
    zb=0
    for i in range(FW):
        ii = nx - i - 1
        ze = nz - i - 1
        for j in range(zb,ze):
            absorb_coeff[ii,j] = coeff[i]

    # compute coefficients for bottom grid boundaries (z-direction)        
    xb=0 
    for j in range(FW):
        jj = nz - j - 1
        xb = j
        xe = nx - j
        for i in range(xb,xe):
            absorb_coeff[i,jj] = coeff[j]

    return absorb_coeff

# FD_2D_acoustic code with JIT optimization
# -----------------------------------------
def FD_2D_acoustic_JIT(model_name):        

    # Definition of initial modelling parameters
    # ------------------------------------------
    xmax = 2000.0 # maximum spatial extension of the 1D model in x-direction (m)
    zmax = xmax   # maximum spatial extension of the 1D model in z-direction (m)
    dx   = 5.0   # grid point distance in x-direction (m)
    dz   = dx     # grid point distance in z-direction (m)

    tmax = 0.75    # maximum recording time of the seismogram (s)
    dt   = 0.0010 # time step

    vp0  = 3000.  # P-wave speed in medium (m/s)

    # acquisition geometry
    xsrc = 1000.0 # x-source position (m)
    zsrc = dz     # z-source position (m)

    f0   = 100.0 # dominant frequency of the source (Hz)
    t0   = 0.1   # source time shift (s)

    isnap = 2  # snapshot interval (timesteps) 

    # define spatial model discretization
    # -----------------------------------
    nx = (int)(xmax/dx) # number of grid points in x-direction
    print('nx = ',nx)

    nz = (int)(zmax/dz) # number of grid points in x-direction
    print('nz = ',nz)

    # Define model
    # ------------    
    vp  = np.zeros((nx,nz))
    vp_rand  = np.zeros((nx,nz))

    # define homogeneous model with mean random medium velocity
    if(model_name=="hom"):
        pert = 0.4
        r = 2.0 * (np.random.rand(nz, nx) - 0.5) * pert
        vp_rand += vp0 * (1 + r)
        vp += 0.91 * np.mean(vp_rand) 	

    # define random medium model
    if(model_name=="rand"):
        pert = 0.4
        r = 2.0 * (np.random.rand(nz, nx) - 0.5) * pert
        vp += vp0 * (1 + r)

    vp2 = vp**2

    # calculate dt according to the CFL-criterion
    dt = dx / (np.sqrt(2.0) * np.max(vp))   

    # define temporal model discretization
    # ------------------------------------
    nt = (int)(tmax/dt) # maximum number of time steps            
    print('nt = ',nt)

    isrc = (int)(xsrc/dx)  # source location in grid in x-direction
    jsrc = (int)(zsrc/dz)  # source location in grid in x-direction

    # receiver postion
    ir = isrc
    jr = (int)(nz/2)

    # Source time function (Gaussian)
    # -------------------------------
    src  = np.zeros(nt + 1)
    time = np.linspace(0 * dt, nt * dt, nt)

    # 1st derivative of Gaussian
    src  = -2. * (time - t0) * (f0 ** 2) * (np.exp(- (f0 ** 2) * (time - t0) ** 2)) 
    
    # define clip value: 0.1 * absolute maximum value of source wavelet
    clip = 0.1 * max([np.abs(src.min()), np.abs(src.max())]) / (dx*dz) * dt**2
    
    # Define absorbing boundary frame
    # -------------------------------    
    absorb_coeff = absorb(nx,nz)    
    
    # Initialize empty pressure arrays
    # --------------------------------
    p    = np.zeros((nx,nz)) # p at time n (now)
    pold = np.zeros((nx,nz)) # p at time n-1 (past)
    pnew = np.zeros((nx,nz)) # p at time n+1 (present)
    d2px = np.zeros((nx,nz)) # 2nd spatial x-derivative of p
    d2pz = np.zeros((nx,nz)) # 2nd spatial z-derivative of p   

    # Initialize seismogram
    # ---------------------
    seis = np.zeros(nt) 
    
    # Initalize animation of pressure wavefield 
    # -----------------------------------------    
    fig = plt.figure(figsize=(7,3.5))  # define figure size
    plt.tight_layout()
    extent = [0.0,xmax,zmax,0.0]     # define model extension
    
    # Plot pressure wavefield movie
    ax1 = plt.subplot(121)
    image = plt.imshow(p.T, animated=True, cmap="RdBu", extent=extent, 
                          interpolation='nearest', vmin=-clip, vmax=clip)        
    plt.title('Pressure wavefield')
    plt.xlabel('x [m]')
    plt.ylabel('z [m]')    
    
    # Plot Vp-model
    ax2 = plt.subplot(122)
    image1 = plt.imshow((vp.T)/1000, cmap=plt.cm.viridis, interpolation='nearest', 
                        extent=extent)
    
    plt.title('Vp-model')
    plt.xlabel('x [m]')
    plt.setp(ax2.get_yticklabels(), visible=False) 
    
    divider = make_axes_locatable(ax2)
    cax2 = divider.append_axes("right", size="2%", pad=0.1)
    fig.colorbar(image1, cax=cax2)         
    plt.ion()    
    plt.show(block=False)
    
    # Calculate Partial Derivatives
    # -----------------------------
    for it in range(nt):
    
        # FD approximation of spatial derivative by 3 point operator
        d2px, d2pz = update_d2px_d2pz(p, dx, dz, nx, nz, d2px, d2pz)

        # Time Extrapolation
        # ------------------
        pnew = 2 * p - pold + vp2 * dt**2 * (d2px + d2pz)

        # Add Source Term at isrc
        # -----------------------
        # Absolute pressure w.r.t analytical solution
        pnew[isrc,jsrc] = pnew[isrc,jsrc] + src[it] / (dx * dz) * dt ** 2
        
        # Apply absorbing boundary frame
        # ------------------------------
        p *= absorb_coeff
        pnew *= absorb_coeff
        
        # Remap Time Levels
        # -----------------
        pold, p = p, pnew

	# Write seismogram    
	# ----------------
        seis[it] = p[ir,jr]

        # display pressure snapshots 
        if (it % isnap) == 0:
            image.set_data(p.T)
            fig.canvas.draw()  
            
    return time, seis 
