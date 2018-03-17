# Theory-of-seismic-waves-II
Course material for the lecture "Theory of seismic waves II" (SS 2018)
at the Institute of Geosciences (Department of Geophysics), Christian-Albrechts-University Kiel

This lecture will be based on the book "Computational Seismology" by Heiner Igel:

[http://www.computational-seismology.org/](http://www.computational-seismology.org/)

Some programming exercises using Jupyter Notebooks are from the "Seismo-Live" Homepage:

[http://www.seismo-live.org/](http://www.seismo-live.org/)

distributed under the terms of CC BY-NC-SA 4.0:

[https://creativecommons.org/licenses/by-nc-sa/4.0/](https://creativecommons.org/licenses/by-nc-sa/4.0/)

This repository also contains:
- The 2D Frequency Domain Finite-Difference (FDFD) Matlab Code GERMAINE-AC-Matlab-Edition for the solution of the 2D Helmholtz equation using either a simple 5-point FD stencil or a 9-point mixed-grid FD stencil with PML absorbing boundary conditions according to Z. Chen, D. Cheng, W. Feng, H. Yang, 2013, An optimal 9-point finite difference scheme for the Helmholtz equation with PML, Int. J. Numer. Anal. Model., 10, 389-410. 
- The 2D Time Domain Finite-Difference (FDFD) Matlab Code DENISE-AC-Matlab-Edition for the solution of the 2D Helmholtz equation using a simple 5-point FD stencil with simple FOR loops and sparse matrix-vector multiplication. 
- The 2D Time Domain Finite-Difference (FDFD) Jupyter Notebooks DENISE-PSV-Python-Edition for the solution of the 2D PSV problem on a staggered grid using a simple 2nd order FD scheme in space and time. Code performance is optimized using NUMBA.

During the course of the lecture, I will add more Jupyter notebooks dealing with mesh generation, Love/Rayleigh wave propagation, FD modelling in spherical coordinates and SH wave propagation in visco-elastic and anisotropic media.

Daniel Koehn

Kiel, 17.03.2018
