# Equations of motion for seismic wave propagation in elastic and acoustic media

In this module I summarize some parts of the `Theory of elastic waves` lecture, especially the equations of motion to describe seismic wave propagation in linear-elastic media, as well as 1D/2D medium approximations. Furthermore, analytical 
solutions are derived to validate the accuarcy of seismic modelling codes, implemented during the course of the lecture.

## Lecture 1: Theory of seismic wave propagation

### [Lesson 1](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/01_Analytical_solutions/1_Equations_of_motion_elastic_medium.ipynb): Equations of motion for a linear-elastic medium

Equations of motion for a linear-elastic medium: conservation of momentum, generalized Hookes law. What changes are required to model seismic wave propagation in anisotropic or visco-elastic media on the local or global scale, in 
time- or frequency domain? Different notations of the linear-elastic equations of motion.

### [Lesson 2](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/01_Analytical_solutions/2_Isotropic_elastic_medium.ipynb): Isotropic linear-elastic media

Stress-strain relation for isotropic linear-elastic media and how to compute it using the symbolic math library **SymPy**. 3D equations of motion for seismic wave propagation in isotropic linear-elastic media.

### [Lesson 3](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/01_Analytical_solutions/3_Acoustic_medium.ipynb): 3D acoustic medium approximation

Estimation of 3D isotropic acoustic wave equation from the isotropic linear-elastic equations of motion.

### [Lesson 4](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/01_Analytical_solutions/4_2D_1D_elastic_acoustic_approx.ipynb): 2D and 1D approximations for elastic and acoustic media

Introducing the 2D elastic PSV/SH and acoustic problem. Getting rid of one dimension and derive the 1D elastic SH and acoustic wave equations.

### [Lesson 5](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/01_Analytical_solutions/5_Greens_function_acoustic_1-3D.ipynb): Green's function and seismograms for homogeneous acoustic media

Deriving the Green's functions for homogeneous 3D, 2D and 1D acoustic media. Definition of source wavelets and calculation of seismograms.

### [Lesson 6](https://nbviewer.jupyter.org/github/daniel-koehn/Theory-of-seismic-waves-II/blob/master/01_Analytical_solutions/6_Thunderstorm_in_1D-3D_acoustic_media.ipynb): Thunderstorms in 3D and 1D acoustic media

Computation of a realistic analytical seismogram for wave propagation of thunder in a homogeneous 3D and 1D acoustic atmosphere, respectively. This example illustrates the shortcomings of the 1D medium approximation.

## Copyright and License

(c) 2018 D. Koehn. All content is under Creative Commons Attribution [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode.txt), and all [code is under BSD-3 clause](https://github.com/engineersCode/EngComp/blob/master/LICENSE). We are happy if you re-use the content in any way!

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause) [![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
