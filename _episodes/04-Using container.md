---
title: "Using NGC Container in SuperPOD"
teaching: 20
exercises: 0
questions:
- "How to use NGC Container in SuperPOD?"
objectives:
- "Learn how to master NGC Container useage in SuperPOD"
keypoints:
- "NGC Container"
---

# 4. Using NVIDIA NGC Container in SuperPOD

## What is Container?

- Container demonstrates its efficiency in application deployment in HPC.
- Containers can encapsulate complex programs with their dependencies in isolated environments making applications more portable.
- A container is a portable unit of software that combines the application and all its dependencies into a single package that is agnostic to the underlying host OS.
- Thereby, it removes the need to build complex environments and simplifies the process of application development to deployment.

## Docker Container

- [Docker](docker.com) is the most popular container system at this time
- It allows applications to be deployed inside a container on Linux systems. 

## NVIDIA NGC Container

- NGC Stands for NVIDIA GPU Clouds
- NGC providing a complete catalog of GPU-accelerated containers that can be deployed and maintained for artificial intelligence applications.
- It enables users to run their projects on a reliable and efficient platform that respects confidentiality, reversibility and transparency.
- NVIDIA NGC containers and their comprehensive catalog are an amazing suite of prebuilt software stacks (using the Docker backend) that simplifies the use of complex deep learning and HPC libraries that must leverage some sort of GPU-accelerated computing infrastructure.
- Complete catalogs of NGC can be found [here](https://catalog.ngc.nvidia.com/containers), where you can find tons of containers for Tensorflow, Pytorch, NEMO, Merlin, TAO, etc...

## ENROOT
It is very convenient to download docker and NGC container to SuperPOD. Here I would like to introduce a very effective tool name **enroot**

- A simple, yet powerful tool to turn traditional container/OS images into unprivileged sandboxes.
- This approach is generally preferred in high-performance environments or virtualized environments where portability and reproducibility is important, but extra isolation is not warranted.

### Importing docker container to SuperPOD from docker hub

- The following command import docker container **ubuntu** from https://hub.docker.com/_/ubuntu
- It then create the squash file named ubuntu.sqsh at the same location
- Finally, it start the ubuntu container

```
$ enroot import docker://ubuntu
$ enroot create ubuntu.sqsh
$ enroot start ubuntu

#Type ls to see the content of container:
# ls

bin   dev  home  lib32  libx32  mnt  proc  run   srv  tmp    usr
boot  etc  lib   lib64  media   opt  root  sbin  sys  users  var
```

- Type exit to quit container environment

### Exercise

Go to dockerhub, search for any container, for example lolcow then use enroot to contruct that container environment

```
enroot import docker://godlovedc/lolcow
enroot create godlovedc+lolcow.sqsh
enroot start godlovedc+lolcow
```

![image](https://user-images.githubusercontent.com/43855029/180532404-60f32edc-489a-4ed1-bfa8-ae4f6fbaa566.png)

## Download Tensorflow container and start using in interactive mode

### Search and download container:

- Now, let's start downloading Tensorflow container from NGC. By browsing the [NGC Catalog](https://catalog.ngc.nvidia.com/containers) and search for Tensorflow, I got the link:
https://catalog.ngc.nvidia.com/orgs/nvidia/containers/tensorflow

- Copy the image path from website:

![image](https://user-images.githubusercontent.com/43855029/210624494-f3304104-32d6-4c02-bc2c-388b3f30caa7.png)

The following information was copied to the memory when selecting the 22.12-tf2 version:

```
nvcr.io/nvidia/tensorflow:22.12-tf2-py3
```

- Im gonna download the version 22.12 tf2 to my **work** location using **enroot**, pay attention to the syntax difference when pasting:

```
$ cd $WORK/sqsh
$ enroot import docker://nvcr.io#nvidia/tensorflow:22.12-tf2-py3
```

The sqsh file **nvidia+tensorflow+22.12-tf2-py3.sqsh** is created.

- Next create the sqsh file:

```
$ enroot create nvidia+tensorflow+22.12-tf2-py3.sqsh
```

### Start loading container in SuperPOD

Once the container is import and created into your folder in SuperPOD, you can simply activate it from login node when requesting a compute node:

```
$ srun -N1 -G1 -c10 --mem=64G --time=12:00:00 --container-image $WORK/sqsh/nvidia+tensorflow+22.12-tf2-py3.sqsh --container-mounts=$WORK --pty $SHELL

```

- Once loaded, you are placed into **/workspace** which is the container local storage. You can navigate to your **$HOME or $WORK** folder freely.

- Note that in this example, I mounted the container to **$WORK** location only but you can always mount it to your own working directory

### Check the GPU enable:

```
$ python
>>> import tensorflow as tf
>>> tf.config.list_physical_devices('GPU')
[PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
```

