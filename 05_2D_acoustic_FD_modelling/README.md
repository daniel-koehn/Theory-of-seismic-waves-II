# 2D acoustic finite-difference modelling

The 1D acoustic wave equation is very useful to introduce the general concept and problems related to FD modelling. However, for realistic modelling and seismic imaging/inversion applications we have to solve at least the 2D 
acoustic wave equation. In the following lessons we will develop a 2D acoustic modelling code, optimize it's performance, apply it to some benchmark problems and calculate sensitivity kernels.

## Lecture 5: 2D acoustic finite-difference modelling

### [Lesson 1](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/05_2D_acoustic_FD_modelling/1_From_1D_to_2D_acoustic_FD_modelling_final.ipynb): From 1D to 2D acoustic finite difference modelling

Starting from the 1D acoustic code, we develop a 2D acoustic modelling code and compare the numerical with an analytical solution. While the 2D code can be implemented quite fast, the runtime of this implementation is quite bad.

### [Lesson 2](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/05_2D_acoustic_FD_modelling/2_Optimizing_fdac2d_code.ipynb): Performance optimization of the 2D acoustic finite difference modelling code

We improve the poor performance of our 2D acoustic modelling code, implemented during the last class, by using JIT compilation from the Numba library and Numpy array operations. The runtime of optimized Python codes are compared 
with a C++ implementation.

### [Lesson 3](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/05_2D_acoustic_FD_modelling/3_fdac2d_num_stability_anisotropy.ipynb): Numerical stability, dispersion and anisotropy of the 2D acoustic FD code

We derive the CFL-stability criterion for the 2D acoustic FD approximation using von Neumann analysis. The CFL- and grid dispersion criteria are compared by numerical modelling. Furthermore, the problem of numerical 
anisotropy is introduced.

### [Lesson 4](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/05_2D_acoustic_FD_modelling/4_fdac2d_absorbing_boundary.ipynb): Simple absorbing boundary for 2D acoustic FD modelling

Realistic FD modelling results for surface seismic acquisition geometries require a further modification of the 2D acoustic FD code. Except for the free surface boundary condition on top of the model, we want to suppress 
the artifical reflections from the other boundaries. This is accomplished by a simple absorbing Sponge boundary frame. 

### [Lesson 5](https://nbviewer.jupyter.org/github/daniel-koehn/Theory-of-seismic-waves-II/blob/master/05_2D_acoustic_FD_modelling/5_fdac2d_heterogeneous.ipynb): 2D acoustic FD modelling for heterogeneous media

Always modelling homogeneous media becomes boring, so let's model some problems with simple heterogeneous media.

### [Lesson 6](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/05_2D_acoustic_FD_modelling/6_fdac2d_marmousi_model_exercise.ipynb): Exercise: 2D acoustic FD modelling of the Marmousi-2 model

Time for some "serious" FD modelling with the most widely used benchmark problem - the Marmousi-2 model.

### [Lesson 7](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/05_2D_acoustic_FD_modelling/7_fdac2d_sensitivity_kernels.ipynb): Computation of Sensitivity Kernels by 2D acoustic FD modelling

Beside modelling of seismic surveys, our 2D acoustic FD code can be used as the core of a seismic full waveform inversion (FWI) approach based on sensitivity kernels. A very efficient implementation can be realized with 
frequency domain wavefields, which can be computed "on-the-fly" while FD time-looping via DFT.


## Copyright and License

(c) 2018 D. Koehn. All content is under Creative Commons Attribution [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode.txt), and all [code is under BSD-3 clause](https://github.com/engineersCode/EngComp/blob/master/LICENSE). We are happy if you re-use the content in any way!

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause) [![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
