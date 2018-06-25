# 2D SH/Love wave finite-difference modelling

After solving the 2D acoustic wave equation with constant density, we focus in the next step on 2D elastic approximations. We begin with the 2D isotropic SH problem which is very similar to the acoustic problem 
but is an accurate elastic description of the subsurface.

## Lecture 6: 2D SH/Love wave finite-difference modelling

### [Lesson 1](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/06_2D_SH_Love_wave_modelling/1_2D_SH_FD_staggered.ipynb): Solving the isotropic elastic 2D SH problem by the staggered grid FD method

I introduce the basics of a 2nd order in time and 2nd order in space staggered grid finite difference approach to solve the 2D elastic SH problem in stress-velocity formulation.

### [Lesson 2](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/06_2D_SH_Love_wave_modelling/2_From_2D_acoustic_to_SH_FD_modelling_final.ipynb): From 2D acoustic to 2D SH finite difference modelling

Starting from the 2D acoustic code, we develop the 2D SH modelling code using a 2nd order space/time staggered grid finite difference scheme and compare the numerical with an analytical solution for a homogeneous medium

### [Lesson 3](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/06_2D_SH_Love_wave_modelling/3_2D_SH_FD_modelling_quarter_plane_problem.ipynb): 2D SH finite difference modelling - the quarter plane problem

Before modelling the propagation of Love-waves, let's take a look how accurate reflected body waves from the free-surface boundary can be modelled using the quarter plane problem. This is an important aspect, because one 
way to understand Love waves is by the interference of SH-body waves in a layered medium.

### [Lesson 4](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/06_2D_SH_Love_wave_modelling/4_2D_SH_FD_modelling_Love_waves.ipynb): 2D SH finite difference modelling - Love wave propagation in the Fossa Carolina canal

After analyzing the accuracy of SH body waves and their free-surface boundary reflections in the previous lessons, we are now able to model SH surface (Love) waves. Instead of using a simplified synthetic sub-surface model, 
we can rely in this lesson on Full Waveform Inversion (FWI) results of a field dataset acquired across a medieval canal. The reconstructed Vs-model was verified by an archaeological excavation.

## Copyright and License

(c) 2018 D. Koehn. All content is under Creative Commons Attribution [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode.txt), and all [code is under BSD-3 clause](https://github.com/engineersCode/EngComp/blob/master/LICENSE). We are happy if you re-use the content in any way!

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause) [![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
