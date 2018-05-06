# How to put the earth into a computer, also known as mesh generation

In this module I give an overview on how to discretize the subsurface, a vital step before the numerical solution of the elastic/acoustic forward problem. 
I also discuss different approaches for mesh generation, possible pitfalls and their solution.

## Lecture 2: Mesh generation

### [Lesson 1](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/02_Mesh_generation/1_Cartesian_Finite_Difference_grid.ipynb): Equidistant Cartesian meshes for 2D finite-difference modelling

Generation of equidistant Cartesian grids in Python and their visualization. Discretization errors introduced by layers not coinciding with the Cartesian main axes. 

### [Lesson 2](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/02_Mesh_generation/2_Quad_mesh_TFI_intro.ipynb): Quad mesh generation by Transfinite Interpolation

The Cartesian grid discretization is not able to accurately describe the free-surface topography of a sea dike, required for accurate seismic modelling of surface waves. Therefore, we introduce the generation of a deformed 
Cartesian mesh by Transfinite Interpolation. As an introduction we are folding a digital swan.

### [Lesson 3](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/02_Mesh_generation/3_Quad_mesh_TFI_sea_dike.ipynb):  Mesh generation by Transfinite Interpolation applied to the sea dike problem

We revisit the sea dike problem from lesson 2 and generate a deformed quad mesh by Transfinite Interpolation adapted to the sea dike topography.

### [Lesson 4](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/02_Mesh_generation/4_Tri_mesh_delaunay_yigma_tepe.ipynb): Triangular mesh generation

For another problem with complex topography - the Yigma Tepe tumulus, we compare the TFI quad mesh with triangular meshes created by (constrained) Delaunay triangulation. Some problems related to triangular mesh generation 
are discussed in more detail. Finally, I recommend some mesh generators.


## Copyright and License

(c) 2018 D. Koehn. All content is under Creative Commons Attribution [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode.txt), and all [code is under BSD-3 clause](https://github.com/engineersCode/EngComp/blob/master/LICENSE). We are happy if you re-use the content in any way!

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause) [![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
