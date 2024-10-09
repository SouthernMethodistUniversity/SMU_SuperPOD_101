---
title: "Data Science workflow with GPUs using RAPIDS"
teaching: 20
exercises: 0
questions:
- "How to install and use RAPIDS"
objectives:
- "Using GPUs directly to work with data"
keypoints:
- "NGC Container, RAPIDS, cudf, cuDask"
---

# RAPIDS

RAPIDS provides unmatched speed with familiar APIs that match the most popular PyData libraries. Built on the shoulders of giants including NVIDIA CUDA and Apache Arrow, it unlocks the speed of GPUs with code you already know.

https://rapids.ai/

## Installing RAPIDS
There are several ways to install RAPIDS to HPC systems

### Using Conda Environment
This is the simplest method and usable to both M2 and SuperPOD system.
You can install interactively, first, you just need to request a GPU node and load the corresponding library:

#### In M3:

```bash
$ srun -n1 --gres=gpu:1 -c2 --mem=4gb --time=12:00:00 -p gpu-dev --pty $SHELL
$ module load conda
```

#### In SuperPOD:

```bash
$ srun -n1 --gres=gpu:1 -c2 --mem=4gb --time=12:00:00 --pty $SHELL
$ module load conda
```

Once the necessary module has been loaded, you just need to create the conda environment and install rapids, the following command get the latest standard version from https://rapids.ai/

```bash
$ conda create -n rapids-23.02 -c rapidsai -c conda-forge -c nvidia  rapids=23.02 python=3.10 cudatoolkit=11.8
```

Install jupyter kernel to jupyter lab:

```bash
$ pip install ipykernel
$ python3 -m ipykernel install --user --name rapids-23.02 --display-name Rapids-23.02

```

If you have more personalized version, you can select the corresponding option and copy the command from rapids website: rapids.ai:

![image](https://user-images.githubusercontent.com/43855029/228034833-16cff533-1612-49d8-88a6-cb3b2f9db900.png)


### Using container

This approach is working on SuperPOD only.
We will need to download the RAPIDS container from [NGC](https://catalog.ngc.nvidia.com/orgs/nvidia/teams/rapidsai/containers/rapidsai)

```bash
$ enroot import docker://nvcr.io#nvidia/rapidsai/rapidsai:cuda11.2-runtime-centos7-py3.10
$ enroot create nvidia+rapidsai+rapidsai+cuda11.2-runtime-centos7-py3.10.sqsh
```

Once my docker container has been downloaded to my home/scratch/work directory, I can load it from login node:

```bash
$ srun -N1 -G1 -c10 --mem=64G --time=12:00:00 --container-image $WORK/sqsh/nvidia+rapidsai+rapidsai+cuda11.2-runtime-centos7-py3.10.sqsh --container-mounts=$WORK --pty $SHELL
```

Your installation is done!




