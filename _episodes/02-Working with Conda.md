---
title: "Working with Conda Environment"
teaching: 20
exercises: 0
questions:
- "How to create personal conda environment in SuperPOD"
objectives:
- "Create Conda environment for AI&ML Application"
keypoints:
- "Conda environment"
---
# 2. Conda Environment
 
- Beside Spack module manager installed in SuperPOD, you can also use [Conda](https://conda.io/) for your own package manager.
- In many cases, you want to use Conda environment for many AI&ML application, just like you do in M2
- First thing first, just load the conda module installed:

```
$ module load conda
$ conda env list

# conda environments:
#
base                     /hpc/mp/apps/conda
```

## Create conda environment for Tensorflow with GPUs support

Next, let's create a conda environment for Tensorflow 2.9, here are the steps:

### (1) Request a compute node with 1 GPU

```
$ srun -N1 -G1 -c10 --mem=64G --time=12:00:00 --pty $SHELL
```

### (2) Load cuda and cudnn module

```
$ module load spack conda
$ module load cuda-11.4.4-gcc-10.3.0-ctldo35 cudnn-8.2.4.15-11.4-gcc-10.3.0-eluwegp
```

### (3) Create Tensorflow environment

```
$ conda create --prefix ~/tensorflow_2.9 python=3.8 pip --y
```

### (4) Activate the conda environment and Install Tensorflow 2.9.1

```
$ source activate ~/tensorflow_2.9/  
$ pip install tensorflow==2.9.1 --no-cache-dir
```

### (5) Once installation done, check if the conda environment is able to enable the GPU

```
$  python
>>> import tensorflow as tf
>>> tf.config.list_physical_devices('GPU')
[PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
```

