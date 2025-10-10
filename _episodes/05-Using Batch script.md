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

# 5. Using Batch script in SuperPOD

SuperPOD uses SLURM as scheduler so there is no difference in running Batch script comparing to ManeFrame 3. However, there are some commands you might need to pay attention when running Batch script using container.

Following are the instructions on how to run Batch script for a Computer Vision sample using [CIFAR10 data](https://www.cs.toronto.edu/~kriz/cifar.html). Here, I use a python file called model_CNN_CIFAR10.py. 

The file can be downloaded from here to your folder:

```bash
$ wget https://raw.githubusercontent.com/SouthernMethodistUniversity/SMU_SuperPOD_101/e6315c29ca0542351b79233729708dfa16161cdf/files/model_CNN_CIFAR10.py
```

## 5.1 Running Batch script with conda environment

Prepare the batch script with name: **modelCNN.sh** using the following content:

```bash
#!/bin/bash
#SBATCH -J CNN_CIFAR10_SPOD       # job name to display in squeue
#SBATCH -t 60                     # maximum runtime in minutes
#SBATCH -c 2                      # request 2 cpus    
#SBATCH -G 1                      # request 1 gpu a100
#SBATCH --mem=32gb                # request 32gb memory
#SBATCH --mail-user tuev@smu.edu  # request to email to your emailID
#SBATCH --mail-type=end           # request to mail when the model **end**

module load conda gcc
module load cuda cudnn

conda activate ~/tensorflow_2.9
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

srun --container-image=/users/tuev/sqsh/nvidia+tensorflow+22.12-tf2-py3.sqsh python ./sqsh/model_CNN_CIFAR10.py
```

Be on login node to submit the batch script:

```bash
$ sbatch modelCNN_ngc.sh
```
