# Stability, dispersion and accuracy of finite-difference operators

After developing a 1D acoustic finite difference code, we will investigate in this lecture how to choose optimum modelling parameters, especially the spatial grid point distance dx and time step dt.
Furthermore, optimzed FD operators are introduced by using Tayler series expansion and Lagrange polynomials.

## Lecture 4: Stability, dispersion and accuracy of finite-difference operators

### [Lesson 1](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/04_FD_stability_dispersion/1_fd_stability_dispersion.ipynb): FD stability and dispersion

We investigate the stability and dispersion of our 1D acoustic FD modelling approach. In order to estimate the time step dt, we introduce the Courant-Friedrichs-Lewy (CFL) stability criterion for the 1D acoustic 
wave equation using the von Neumann analysis. A grid dispersion analysis allows to estimate reasonable values for the spatial grid point distance dx. The derived CFL and grid dispersion criteria are used to 
optimize the FD modelling in terms of stability, dispersion and runtime.

### [Lesson 2](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/04_FD_stability_dispersion/2_fd_accuracy.ipynb): Accuracy of Finite-difference operators

Defining the accuracy of finite-difference operators based on the remainder of Taylor series expansion.

### [Lesson 3](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/04_FD_stability_dispersion/3_fd_taylor_operators.ipynb): Improving the accuracy of FD operators based on Taylor series expansion

We use a more systematic approach to derive high-order and therefore more accurate finite-difference operators using Taylor series expansion. FD operator weighting factors are estimated by `SymPy`. As an example, 
we derive a 5-point FD operator to approximate the 2nd derivative in the numerical solution of the 1D acoustic wave equation. Accuracy, runtime and the Courant criterion for the 5-point operator are compared with 
the 3-point operator.

### [Lesson 4](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/04_FD_stability_dispersion/4_general_fd_taylor_operators.ipynb): Generalization of Taylor based FD operators

We derive a general formula to estimate FD operators with arbritary derivative and error order based on Taylor series expansion. Finally, a symbolic approach to compute FD operators for given discrete points using `SymPy`
is introduced.

## Copyright and License

(c) 2018 D. Koehn. All content is under Creative Commons Attribution [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode.txt), and all [code is under BSD-3 clause](https://github.com/engineersCode/EngComp/blob/master/LICENSE). We are happy if you re-use the content in any way!

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause) [![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
