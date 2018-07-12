# 1D viscoelastic SH-modelling

Especially in near-surface SH modelling/full wavefrom applications, the elastic medium description is not sufficient to accurately describe amplitude and phase of the field data.
Instead a viscoelastic medium approximation is required. Therefore, we compare different viscoelastic models in the frequency domain, starting with the Maxwell body, Kelvin Voigt 
to the Standard Linear Solid in Maxwell representation and finally the Generalized Maxwell body (GMB). Only the GMB is able to achieve a frequency-independent Q model. The 
complex modulus of the Generalized Maxwell model is transformed back to time domain to estimate a time-domain relaxation function. With the time-domain description of the viscoelastic 
medium, we can finally model viscoelastic SH wave propagation using finite-differences.

## Lecture 8: 1D viscoelastic SH-modelling

### [Lesson 1](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/08_1D_visco_elastic_SH_modelling/1_Intro_viscoelasticity.ipynb): Viscoelasticity: Introduction

As introduction, we first distinguish different elastic "damping" effects of seismic waves and non-elastic damping. How can we describe seismic damping and what are the reasons?

### [Lesson 2](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/08_1D_visco_elastic_SH_modelling/2_viscoelastic_stress_strain.ipynb): Viscoelastic stress-strain relations

We compare different visco-elastic stress-strain relations in the frequency-domain to achieve a constant Q(ω) behavior. 

### [Lesson 3](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/08_1D_visco_elastic_SH_modelling/3_TD_viscoelastic_equations_of_motion.ipynb): Time-domain viscoelastic equations of motion

In the last lesson we proved that the Generalized Maxwell model (GMB) is able to describe a constant Q-spectrum, necessary for realistic SH wave propagation in viscoelastic media. 
Now, we only have to transform the frequency domain GMB stress-strain relation back to time-domain and assemble the forward problem in a form which can be solved by finite-differences.

### [Lesson 4](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/08_1D_visco_elastic_SH_modelling/4_1D_visc_SH_FD_modelling.ipynb): 1D viscoelastic SH modelling

After deriving the equations of motion for 1D wave propagation in viscoelastic SH media, we can now solve the problem using a staggered grid FD scheme. Furthermore, the anelastic 
coefficients of the Generalized Maxwell body (GMB) are optimized by a global Differential Evolution (DE) algorithm to achive a constant Q-spectrum. Finally, elastic and viscoelastic 
modelling results for a homogeneous model are compared. 

## Copyright and License

(c) 2018 D. Koehn. All content is under Creative Commons Attribution [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode.txt), and all [code is under BSD-3 clause](https://github.com/engineersCode/EngComp/blob/master/LICENSE). We are happy if you re-use the content in any way!

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause) [![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
