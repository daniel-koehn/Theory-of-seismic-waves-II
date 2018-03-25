# Introduction to Python and Jupyter notebooks

Numerous authors have invested a lot of time, effort and passion to create detailed introductions to Python and Jupyter notebooks.
So instead of writing another tutorial, I decided to give some references to some very good tutorials and online books:

* [Dive Into Python](http://www.diveintopython.net/)
* [Think Python Book](http://www.greenteapress.com/thinkpython/thinkpython.html)
 
If you are familiar with Matlab, here are some references to avoid some pitfalls during the transition to Python:
 
* [NumPy for Matlab Users Introdution](http://wiki.scipy.org/NumPy_for_Matlab_Users)
* [NumPy for Matlab Users Cheatsheet](http://mathesaurus.sourceforge.net/matlab-numpy.html)
 
Additionally there is an abundance of resources introducing and teaching parts of the scientific Python ecosystem.
 
* [NumPy Tutorial](http://wiki.scipy.org/Tentative_NumPy_Tutorial)
* [Python Scientific Lecture Notes](http://scipy-lectures.github.io/): Introduces the basics of scientific Python with lots of examples.
* [Lectures on Scientific Computing with Python](http://nbviewer.jupyter.org/github/jrjohansson/scientific-python-lectures/tree/master/): Another scientific Python introduction by J.R. Johansson
* [Python for Signal Processing](http://python-for-signal-processing.blogspot.de/): Free blog which is the basis of a proper book written on the subject.
* [Another NumPy Tutorial](http://www.loria.fr/~rougier/teaching/numpy/numpy.html), [Matplotlib Tutorial](http://www.loria.fr/~rougier/teaching/matplotlib/matplotlib.html)

If you can spare at least 03h 47m 28 s of your life time, I also recommend to watch

[The Wonderful World of Scientific Computing with Python](https://www.youtube.com/watch?v=A9tv7WBIwyM)

a workshop conducted by David P. Sanders at the SciPy 2014. Related Juypter Notebooks are available at 

[The Wonderful World of Scientific Computing with Python (notebooks)](https://github.com/dpsanders/scipy_2014_python)

More generally, all talks given at the SciPy conferences are available online:

[SciPy Conference videos](https://www.youtube.com/user/EnthoughtMedia/playlists)

For the "Theory of Seismic waves II" lectures, I use the introductory part of the "Engineering Computations" class by Prof. Lorena Barba and her doctoral student Natalia C. Clementi from George Washington University:

[Engineering Computations](https://github.com/engineersCode)

Beside the Juypter notebooks, Prof. Barba also produced some short introductory videos, which are available on YouTube:

["Engineering Computations" introductory videos](https://www.youtube.com/playlist?list=PLVc-QdfGfSl0vQ0wUlDbqmp0m9hEoIUmF)

## Description of the "Engineering Computations" introductory notebooks

This course assumes no coding experience, so the first three lessons are focused on creating a foundation with Python programming constructs using essentially no mathematics. The fourth lesson introduces the basic data structure in scientific computing: _arrays_. The final lesson is a worked example of linear regression with real data.

## Module 1: Get data off the ground

### [Lesson 1](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/00_Intro_Python_Jupyter_notebooks/1_Interacting_with_Python.ipynb): Interacting with Python.

Background: What is Python? Idea of interpreted vs. compiled language. Why use Python? It is a general-purpose and high-productivity language.
Getting started: interactive Python (IPython).
Using Python as a calculator.
New concepts: function, string, variables, assignment, type, special variables (`True`, `False`, `None`).
Supported operations, logical operations. Reading error messages.

### [Lesson 2](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/00_Intro_Python_Jupyter_notebooks/2_Jupyter_strings_and_lists.ipynb): Play with data in Jupyter

What is Jupyter? Working with Jupyter. Playing with Python strings: assignment, indexing, slicing. String methods: count, find, index, strip, startswith, split. Play with Python lists: assignment, nested lists, indexing, slicing. String methods: append, index. List membership. Iteration with for-statements. Conditionals.

### [Lesson 4](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/00_Intro_Python_Jupyter_notebooks/4_NumPy_Arrays_and_Plotting.ipynb): Play with NumPy arrays

Two of the most important libraries for scientific computing with Python: **NumPy** and **Matplotlib**. Importing libraries. NumPy functions to create arrays: linspace, ones, zeros, empty, copy. Array operations. Multidimensional arrays. Performance advantage of arrays over lists. Drawing 2D line plots of array data.

### [Lesson 5](http://nbviewer.ipython.org/urls/github.com/daniel-koehn/Theory-of-seismic-waves-II/tree/master/00_Intro_Python_Jupyter_notebooks/5_Linear_Regression_with_Real_Data.ipynb): Linear regression with real data

A full worked example using real data of earth temperature over time. Step 1: reading data from a file. Step 2: plotting the data; making beautiful plots. Step 3: least-squares linear regression. Step 4: applying linear regression using NumPy. Split regression.

## Copyright and License

(c) 2017 Lorena A. Barba, Natalia C. Clementi. All content is under Creative Commons Attribution [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode.txt), and all [code is under BSD-3 clause](https://github.com/engineersCode/EngComp/blob/master/LICENSE). We are happy if you re-use the content in any way!

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause) [![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
