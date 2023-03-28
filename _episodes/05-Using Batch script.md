---
title: "Using Batch script in SuperPOD"
teaching: 20
exercises: 0
questions:
- "How to run Batch script in SuperPOD"
objectives:
- "Running batch script using CIFAR100 template model"
keypoints:
- "Batch script, Computer Vision"
---

# Using Batch script in SuperPOD

SuperPOD uses SLURM as scheduler so there is no difference in running Batch script comparing to ManeFrame 2. However, there is some command you might need to pay attention when running Batch script using container.

Following are the instructions on how to run Batch script for a Computer Vision sample using [CIFAR10 data](https://www.cs.toronto.edu/~kriz/cifar.html). Here, I use a python file called model_CNN_CIFAR10.py. 

The file can be downloaded from [here](https://github.com/SouthernMethodistUniversity/SMU_SuperPOD_101/blob/e6315c29ca0542351b79233729708dfa16161cdf/files/model_CNN_CIFAR10.py)

## 5.1 Running Batch script with conda environment

Prepare the batch script with name: **modelCNN.sh** using the following content:

```bash
#!/bin/bash
#SBATCH -J CNN_CIFAR10_SPOD       # job name to display in squeue
#SBATCH -t 60                     # maximum runtime in minutes
#SBATCH -c 2                      # request 2 cpus    
#SBATCH -G 1                      # request 1 gpu a100
#SBATCH -D /work/users/tuev       # link to your folder
#SBATCH --mem=32gb                # request 32gb memory
#SBATCH --mail-user tuev@smu.edu  # request to email to your emailID
#SBATCH --mail-type=end           # request to mail when the model **end**

module load conda spack
module load cuda-11.4.4-gcc-10.3.0-ctldo35 cudnn-8.2.4.15-11.4-gcc-10.3.0-eluwegp

source activate ~/tensorflow_2.9
python model_CNN_CIFAR10.py
```

Be on login node to submit the batch script:

```bash
$ sbatch modelCNN.sh
```

## 5.2 Running Batch script with container

Prepare the batch script with name: **modelCNN_ngc.sh** using the following content:

```bash
#!/bin/bash
#SBATCH -J CNN_CIFAR10_SPOD       # job name to display in squeue
#SBATCH -t 60                     # maximum runtime in minutes
#SBATCH -c 2                      # request 2 cpus    
#SBATCH -G 1                      # request 1 gpu a100
#SBATCH --mem=32gb                # request 32gb memory
#SBATCH --mail-user tuev@smu.edu  # request to email to your emailID
#SBATCH --mail-type=end           # request to mail when the model **end**

srun --container-image=/work/users/tuev/sqsh/nvidia+tensorflow+22.02-tf2-py3.sqsh --container-mounts=$WORK python $WORK/model_CNN_CIFAR10.py
```

Be on login node to submit the batch script:

```bash
$ sbatch modelCNN_ngc.sh
```
