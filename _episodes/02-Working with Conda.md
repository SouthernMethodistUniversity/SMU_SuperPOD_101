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
- In many cases, you want to use Conda environment for many AI&ML application, just like you do in M3
- First thing first, just load the conda module installed:

```bash
$ module load conda
$ conda env list

# conda environments:
#
base                     /hpc/mp/apps/conda
```

## Create conda environment for Tensorflow with GPUs support

Next, let's create a conda environment for Tensorflow 2.9, here are the steps:

### (1) Request a compute node with 1 GPU

Make sure you have your own allocation name 
```bash
$ srun -A tuev_oitrts_workshop_0001 -N1 -G1 -c10 --mem=64G --time=12:00:00 --pty $SHELL
```

### (2) Load cuda and cudnn module for GPU support

```bash
$ module load conda gcc/11
$ module load cuda/10
$ module load cudnn
```

### (3) Create Tensorflow environment with your prefered version of python

```bash
$ conda create --prefix ~/tensorflow_2.9 python=3.8 pip --y
```

The conda environment named **tensorflow_2.9** is created on your home directory

### (4) Activate the conda environment and Install Tensorflow 2.9.1 (or your prefered TF version)

```bash
$ conda activate ~/tensorflow_2.9/  
$ pip install tensorflow==2.9.1
```

Install ipkernel and create the kernel for Notebook

```bash
$ pip install ipykernel
$ python3 -m ipykernel install --user --name tensorflow_2.9 --display-name TensorflowGPU29
```

### (5) Once installation done, check if the conda environment is able to enable the GPU

```bash
$  python
>>> import tensorflow as tf
>>> tf.config.list_physical_devices('GPU')
[PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
```

Usage of conda environment manager is **no difference** compared to running in M3.

## Create conda environment for Pytorch with GPUs support

Similar to Tensorflow, one can create conda environment for Pytorch with GPUs support.

Following is the brief steps (3) to (5) to create the env and install Pytorch after requesting a node and load the libraries

```bash
$ conda create --prefix ~/pytorch_1.13 python=3.8 pip --y
$ source activate ~/pytorch_1.13
$ conda install pytorch==1.13.1 torchvision==0.14.1 torchaudio==0.13.1 pytorch-cuda=11.6 -c pytorch -c nvidia --y
$ python
>>> import torch 
>>> torch.cuda.is_available()
True
>>> torch.cuda.device_count()
1
```


