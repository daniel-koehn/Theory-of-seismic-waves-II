# 2D acoustic finite-difference modelling

The 1D acoustic wave equation is very useful to introduce the general concept and problems related to FD modelling. However, for realistic modelling and seismic imaging/inversion applications we have to solve at least the 2D 
acoustic wave equation. In the following lessons we will develop a 2D acoustic modelling code, optimize it's performance and apply it to some benchmark problems. 

## Lecture 5: 2D acoustic finite-difference modelling

### [Lesson 1](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/05_2D_acoustic_FD_modelling/1_From_1D_to_2D_acoustic_FD_modelling_final.ipynb): From 1D to 2D acoustic finite difference modelling

Starting from the 1D acoustic code, we develop a 2D acoustic modelling code and compare the numerical with an analytical solution. While the 2D code can be implemented quite fast, the runtime of this implementation is quite bad.

### [Lesson 2](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/05_2D_acoustic_FD_modelling/2_Optimizing_fdac2d_code.ipynb): Performance optimization of the 2D acoustic finite difference modelling code

We improve the poor performance of our 2D acoustic modelling code, implemented during the last class, by using JIT compilation from the Numba library and Numpy array operations. The runtime of optimized Python codes are compared 
with a C++ implementation.

### [Lesson 3](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/05_2D_acoustic_FD_modelling/3_fdac2d_num_stability_anisotropy.ipynb): Numerical stability, dispersion and anisotropy of the 2D acoustic FD code

We derive the CFL-stability criterion and for the 2D acoustic FD approximation using von Neumann Analysis. The CFL- and grid dispersion criteria are compared by numerical modelling. Furthermore, the problem of numerical 
anisotropy is introduced.

### [Lesson 4](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/05_2D_acoustic_FD_modelling/4_fdac2d_heterogeneous.ipynb): 2D acoustic FD modelling for heterogeneous media

Always modelling homogeneous media becomes boring, so let's model some problems with simple heterogeneous media.

## Copyright and License

(c) 2018 D. Koehn. All content is under Creative Commons Attribution [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode.txt), and all [code is under BSD-3 clause](https://github.com/engineersCode/EngComp/blob/master/LICENSE). We are happy if you re-use the content in any way!

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause) [![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
