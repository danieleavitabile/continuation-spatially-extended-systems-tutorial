This tutorial presents material and codes that I presented in a few talks on numerical bifurcation analysis. It aims to be a hands-on guide to perform numerical bifurcation analysis for PDEs or Integro-Differential Equations, starting from a given spatial discretisation. The material covers introductory concepts for the computation of branches of stationary states, and for stability computations. The accompanying codes give templates and workflows that have been adopted in several published papers. These notes, which are meant to be updated in the future, may be useful also for researchers who use other existing numerical bifurcation packages, and want to know more about how they work.
Cite this tutorial as follows 

@misc{avitabile2020,<br/>
  author       = {Daniele Avitabile},<br/>
  title        = {{Numerical Computation of Coherent Structures in 
                   Spatially-Extended Systems}},<br/>
  month        = may,<br/>
  year         = 2020,<br/>
  publisher    = {Zenodo},<br/>
  version      = {v1.2-alpha},<br/>
  doi          = {10.5281/zenodo.3821169},<br/>
  url          = {https://doi.org/10.5281/zenodo.3821169}<br/>
}

TODO:
* I would like to provide a better example for Travelling Wave continuation. At present there are codes for a neural field travelling wave, using FFTs on a bounded domain. That example is contrived, and this is why I have hidden it in the slides.

* Add examples of a time-periodic structure, and of continuation for time-steppers.
