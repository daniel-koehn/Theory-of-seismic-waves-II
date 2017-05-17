# Theory-of-seismic-waves-II
Course material for the lecture "Theory of seismic waves II" hold in SS 2016 
at the Institute of Geosciences (Department of Geophysics), Christian-Albrechts-University Kiel

This repository contains:
- The 2D Frequency Domain Finite-Difference (FDFD) Matlab Code GERMAINE-AC-Matlab-Edition for the solution of the 2D Helmholtz equation using either a simple 5-point FD stencil or a 9-point mixed-grid FD stencil with PML absorbing boundary conditions according to Z. Chen, D. Cheng, W. Feng, H. Yang, 2013, An optimal 9-point finite difference scheme for the Helmholtz equation with PML, Int. J. Numer. Anal. Model., 10, 389-410. 
- The 2D Time Domain Finite-Difference (FDFD) Matlab Code DENISE-AC-Matlab-Edition for the solution of the 2D Helmholtz equation using a simple 5-point FD stencil with simple FOR loops and sparse matrix-vector multiplication. 
- The 2D Time Domain Finite-Difference (FDFD) Jupyter Notebooks DENISE-PSV-Python-Edition for the solution of the 2D PSV problem on a staggered grid using a simple 2nd order FD scheme in space and time. Code performance is optimized using NUMBA.

Lectures are available at: http://www.geophysik.uni-kiel.de/%7Edkoehn/TEW2.htm

Theory-of-seismic-waves-II is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 2.0 of the License only.

Theory-of-seismic-waves-II is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License in LICENSE.md for more details.

Daniel Koehn and Denise De Nil