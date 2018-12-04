# LIFE Healthy Forest

Benchmarking classifiers (SVM, RF, XGBOOST) on four different pathogens:

* Armillaria
* Diplodia
* Heterobasidion
* Fusarium



Hyperparameter tuning: Sequential model-based optimization (SMBO)


This project is setup with a [drake workflow](https://github.com/ropensci/drake), ensuring reproducibility.

Options for deployment:

- [clustermq](https://github.com/mschubert/clustermq) uses [zmq](http://zeromq.org/) with the following schedulers: LSF, SGE, SLURM. See [here](https://github.com/mschubert/clustermq/wiki/Comparison-to-other-packages) for more info.
