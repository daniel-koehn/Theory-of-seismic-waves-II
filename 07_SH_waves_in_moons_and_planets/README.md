# Global 2D SH/Love wave propagation in planets and moons

To solve global wave propagation in planets and moons, we derive the isotropic elastic equations of motion in spherical coordinates and an axisymmetric SH approximation. 
We use the axisymmetric FD code to model SH waves within the Earth, Moon and Jupiter moon Ganymede.

## Lecture 7: Global 2D SH/Love wave propagation in planets and moons

### [Lesson 1](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/07_SH_waves_in_moons_and_planets/1_SH_wave_propagation_in_spherical_coordinates.ipynb): Global isotropic elastic SH wave propagation using an axisymmetric approximation

So far we solved the isotropic elastic equations of motion or their 2D approximations only in Cartesian coordinates. However, to describe global seismic wave propagation, it is required to rewrite the governing equations 
in spherical coordinates.

### [Lesson 2](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/blob/master/07_SH_waves_in_moons_and_planets/2_2D_SHaxi_FD_modelling_earth.ipynb): 2D axisymmetric spherical SH finite difference modelling - Earth

After deriving the equations of motion to model 2D axisymmetric SH wave propgation in the previous lesson, we can now implement the derived staggered grid FD scheme and test it for a simple earth model consisting of a 
liquid core and homogeneous crust/mantle. A second modelling example incorporates the more realistic 1D PREM.

### [Lesson 3](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/blob/master/07_SH_waves_in_moons_and_planets/3_2D_SHaxi_FD_modelling_moon.ipynb): 2D axisymmetric spherical SH finite difference modelling - Moon

In this lesson we compute the axisymmetric SH wave propagation of a deep moonquake event for an elastic lunar model. The resulting wavefields are compared with the modelling results of the earth PREM.

### [Lesson 4](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/blob/master/07_SH_waves_in_moons_and_planets/4_2D_SHaxi_FD_modelling_ganymede.ipynb): 2D axisymmetric spherical SH finite difference modelling - Ganymede

Does a habitable liquid ocean exist beneath the ice crust of Jupiters moon Ganymede? By global axisymmetric SH modelling we will investigate if a single geophone on Ganymedes surface would be able to detect a possible ocean.


## Copyright and License

(c) 2018 D. Koehn. All content is under Creative Commons Attribution [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode.txt), and all [code is under BSD-3 clause](https://github.com/engineersCode/EngComp/blob/master/LICENSE). We are happy if you re-use the content in any way!

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause) [![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
