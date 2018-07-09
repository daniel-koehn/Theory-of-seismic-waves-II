# 1D viscoelastic SH-modelling

Especially in near-surface SH modelling/full wavefrom applications, the elastic medium description is not sufficient to accurately describe amplitude and phase of the modelled waveforms.
Instead a viscoelastic medium approximation is required. Therefore, we derive the equations of motion for 1D viscoelastic SH wave propagation. Different viscoelastic models are compared 
in the frequency domain to achieve a frequency-independent Q model. The complex modulus of the Generalized Maxwell model is transformed back to time domain to estimate a time-domain 
relaxation function. With the time-domain description of the viscoelastic medium, we can finally model viscoelastic SH wave propagation using finite-differences.

## Lecture 8: 1D viscoelastic SH-modelling

### [Lesson 1](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/08_1D_visco_elastic_SH_modelling/1_Intro_viscoelasticity.ipynb): Viscoelasticity: Introduction

As introduction, we first distinguish different elastic "damping" effects of seismic waves and non-elastic damping. How can we describe seismic damping and what are the reasons?

### [Lesson 2](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/08_1D_visco_elastic_SH_modelling/2_viscoelastic_stress_strain.ipynb): Viscoelastic stress-strain relations

We compare different visco-elastic stress-strain relations in the frequency-domain to achieve a constant Q(ω) behavior. 

## Copyright and License

(c) 2018 D. Koehn. All content is under Creative Commons Attribution [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode.txt), and all [code is under BSD-3 clause](https://github.com/engineersCode/EngComp/blob/master/LICENSE). We are happy if you re-use the content in any way!

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause) [![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
